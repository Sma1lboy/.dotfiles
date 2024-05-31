require("tmux-awesome-manager").setup({
  per_project_commands = { -- Configure your per project servers with
    -- project name = { { cmd, name } }
    api = { { cmd = "rails server", name = "Rails Server" } },
    front = { { cmd = "yarn dev", name = "react server" } },
  },
  session_name = "Neovim Terminals",
  use_icon = false, -- use prefix icon
  icon = " ", -- Prefix icon to use
  -- project_open_as = 'window', -- Open per_project_commands as.  Default: separated_session
  default_size = "20%", -- on panes, the default size
  open_new_as = "pane", -- open new command as.  options: pane, window, separated_session.
  -- default_orientation = 'vertical' -- Can also be horizontal
})
local tmux = require("tmux-awesome-manager")
local tmux_term = require("tmux-awesome-manager.src.term")
local wk = require("which-key")

wk.register({
  q = {
    name = "Tmux",
    q = {
      "<cmd>Telescope tmux-awesome-manager list_terms<CR>",
      "list optional item",
    },
  },
})

tmux.run_wk({
  cmd = "yarn add %1",
  name = "Yarn Add",
  questions = { { question = "package name: ", required = true } },
})
tmux.run_wk({
  cmd = "npm add %1",
  name = "Npm Add",
  questions = { { question = "package name: ", required = true } },
})

tmux.run_wk({
  cmd = "npm start",
  name = "Npm Start",
})
tmux.run_wk({ name = "compile C" })
tmux.run_wk({
  cmd = "yarn start",
  name = "yarn start",
})
tmux.run_wk({
  cmd = "yarn",
  name = "yarn",
})
