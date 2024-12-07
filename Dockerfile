FROM ubuntu:latest
RUN apt-get update && apt-get install -y sudo
WORKDIR /root/.dotfiles
CMD ["/bin/bash"]