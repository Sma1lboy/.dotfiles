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
  -- {
  --   "MeanderingProgrammer/render-markdown.nvim",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "echasnovski/mini.nvim",
  --   },
  --   ---@module 'render-markdown'
  --   ---@type render.md.UserConfig
  --   opts = {},
  -- },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            {
              icon = " ",
              key = "f",
              desc = "Find File",
              action = ":lua Snacks.dashboard.pick('files')",
            },
            {
              icon = " ",
              key = "n",
              desc = "New File",
              action = ":ene | startinsert",
            },
            {
              icon = " ",
              key = "g",
              desc = "Find Text",
              action = ":lua Snacks.dashboard.pick('live_grep')",
            },
            {
              icon = " ",
              key = "r",
              desc = "Recent Files",
              action = ":lua Snacks.dashboard.pick('oldfiles')",
            },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            {
              icon = " ",
              key = "s",
              desc = "Restore Session",
              section = "session",
            },
            {
              icon = "󰒲 ",
              key = "L",
              desc = "Lazy",
              action = ":Lazy",
              enabled = package.loaded.lazy ~= nil,
            },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          header = [[
███████╗███╗   ███╗ █████╗ ██╗     ██╗     ██╗   ██╗██╗███╗   ███╗
██╔════╝████╗ ████║██╔══██╗██║     ██║     ██║   ██║██║████╗ ████║
███████╗██╔████╔██║███████║██║     ██║     ██║   ██║██║██╔████╔██║
╚════██║██║╚██╔╝██║██╔══██║██║     ██║     ╚██╗ ██╔╝██║██║╚██╔╝██║
███████║██║ ╚═╝ ██║██║  ██║███████╗███████╗ ╚████╔╝ ██║██║ ╚═╝ ██║
╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        },
      },
      indent = { enabled = true },
      input = { enabled = true },
      -- notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      lazygit = { enabled = true },
      gitbrowse = { enabled = true },
      zen = { enabled = true },
    },
    keys = {
      {
        ";;",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit Open",
      },
    },
  },
  {
    "sphamba/smear-cursor.nvim",

    opts = {
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      scroll_buffer_space = true,
      legacy_computing_symbols_support = false,
    },
  },
  "mg979/vim-visual-multi",

  "Mofiqul/dracula.nvim",
  -- adding github nvim theme
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({})
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  --hex color render
  "norcalli/nvim-colorizer.lua",
  --color buddy
  "tjdevries/colorbuddy.nvim",
  "AndrewRadev/tagalong.vim",
  "lewis6991/gitsigns.nvim",
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  "kevinhwang91/promise-async",
  "kevinhwang91/nvim-ufo",
  { "akinsho/toggleterm.nvim", version = "*", config = true },
  "github/copilot.vim",
  { "folke/neodev.nvim", opts = {} },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  },
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
    "numToStr/Comment.nvim",
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  "wakatime/vim-wakatime",
  "axelvc/template-string.nvim",
  -- "windwp/nvim-ts-autotag",
  "neanias/everforest-nvim",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  --- this is formatter
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
    tag = "0.1.6",
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

  { "hrsh7th/nvim-cmp", dependencies = { "mlaursen/vim-react-snippets" } },
  -- auto completion from each lsp
  "hrsh7th/cmp-nvim-lsp",
  -- auto completion of current buffer block
  "hrsh7th/cmp-buffer",
  -- auto completion of file
  "hrsh7th/cmp-path",
  -- lua api completion
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-cmdline",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",

  -- "hrsh7th/cmp-vsnip",
  -- "hrsh7th/vim-vsnip",
  "nvim-treesitter/nvim-treesitter",
})

require("theme-dracula")
-- colorscheme init
vim.cmd("colorscheme dracula")

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
require("lsp-sh")
require("lsp-c")
require("p-tmux-manager")
require("p-symbols-outline")
require("p-nvim-toggler")
require("p-lualine")
require("p-neodev")
require("p-dap")
require("p-term")
-- require("p-ufo")
require("p-comment")
require("p-gitsigns")
require("p-colorizer")
require("trouble").setup()
require("p-theme")
