require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua",
    "vim",
    "typescript",
    "javascript",
    "html",
    "css",
    "json",
    "c",
  },
  sync_install = false,

  auto_install = true,

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
--- @date 2024-05-19 update fold to using nvim-ufo
