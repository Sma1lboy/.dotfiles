require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua",
    "vim",
    "typescript",
    "javascript",
    "html",
    "css",
    "json",
  },
  sync_install = false,

  auto_install = true,

  ignore_install = { "javascript" },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  autotag = {
    enable = true,
  },
})
--- template string
require("template-string").setup()
--- fold
local opt = vim.opt
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
