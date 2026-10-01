"""Run a command in a pty sized like ours; copy its output to stdout and the
bytes written to FIFO into its input.

asciinema records this relay. Keys written to the FIFO reach the tmux CLIENT,
so prefix bindings fire exactly as they do for a person at the keyboard;
`tmux send-keys` would hand them straight to the pane and bypass them.

usage: relay.py FIFO COMMAND...
"""

import fcntl
import os
import pty
import select
import sys
import termios

fifo, command = sys.argv[1], sys.argv[2:]
pid, fd = pty.fork()
if pid == 0:
    os.execvp(command[0], command)

fcntl.ioctl(fd, termios.TIOCSWINSZ, fcntl.ioctl(sys.stdout.fileno(), termios.TIOCGWINSZ, b"\0" * 8))
# O_RDWR keeps the FIFO open between writers, so it never reads as EOF.
keys = os.open(fifo, os.O_RDWR | os.O_NONBLOCK)
out = sys.stdout.fileno()
while True:
    ready, _, _ = select.select([fd, keys], [], [])
    if fd in ready:
        try:
            data = os.read(fd, 65536)
        except OSError:
            break
        if not data:
            break
        os.write(out, data)
    if keys in ready:
        os.write(fd, os.read(keys, 4096))
os.waitpid(pid, 0)
