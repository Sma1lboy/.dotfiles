local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  "nguyenvukhang/nvim-toggler",
  "simrat39/symbols-outline.nvim",
  "otavioschwanck/tmux-awesome-manager.nvim",
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  "wakatime/vim-wakatime",
  "axelvc/template-string.nvim",
  "windwp/nvim-ts-autotag",
  "sainnhe/everforest",

  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  {
    "stevearc/conform.nvim",
    opts = {},
  },
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}, -- this is equalent to setup({}) function
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  "mg979/vim-visual-multi",
  "MattesGroeger/vim-bookmarks",
  "tom-anders/telescope-vim-bookmarks.nvim",
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  "mfussenegger/nvim-lint",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/vim-vsnip",
  "nvim-treesitter/nvim-treesitter",
})

vim.cmd("colorscheme tokyonight")
require("base")
require("keymap")
require("p-mason")
require("p-lsp")
require("lsp-lua")
require("p-conform")
require("p-tree")
require("p-telescope")
require("p-bookmarks")
require("lsp-typescript")
require("p-lint")
require("p-cmp")
require("p-treesitter")
require("p-neogit")
require("lsp-sh")
require("lsp-c")
require("p-tmux-manager")
require("p-symbols-outline")
require("p-nvim-toggler")
require("p-lualine")
