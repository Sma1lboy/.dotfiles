vim.cmd([[highlight BookmarkSign ctermbg=NONE ctermfg=160]])
vim.cmd([[highlight BookmarkSign ctermbg=NONE ctermfg=160]])
vim.g.bookmark_sign = "♥"
vim.g.bookmark_highlight_lines = 1

require("telescope").load_extension("vim_bookmarks")

local keymap = vim.keymap

local wk = require("which-key")
wk.register({
  m = {
    name = "bookmark telescope",
    a = {
      "<cmd>lua require('telescope').extensions.vim_bookmarks.all()<cr>",
      "Show All Bookmarks",
    },
    c = {
      "<cmd>lua require('telescope').extensions.vim_bookmarks.current_file()<cr>",
      "Current File",
    },
  },
})
