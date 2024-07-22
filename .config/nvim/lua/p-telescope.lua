local builtin = require("telescope.builtin")
local wk = require("which-key")

wk.register({
  f = { builtin.find_files, "telescope fuzzy search" },
  g = { builtin.live_grep, "telescope live grep" },
}, { prefix = "<leader>" })

local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["esc"] = actions.close,
      },
    },
    file_ignore_patterns = {
      ".git",
      "lazy-lock.json",
      "node_modules",
      "yarn.lock",
    },
    dynamic_preview_title = true,
    path_display = { "smart" },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    colorscheme = {
      enable_preview = true,
    },
  },
  layout_config = {
    hotizontal = {
      preview_cutoff = 100,
      preview_width = 0.5,
    },
  },
})
