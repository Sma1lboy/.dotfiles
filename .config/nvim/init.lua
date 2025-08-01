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

-- Disable startup warnings and WakaTime messages
local original_notify = vim.notify
vim.notify = function(msg, level, opts)
  -- Skip warning messages
  if level == vim.log.levels.WARN then
    return
  end
  -- Skip WakaTime version check messages
  if type(msg) == "string" and msg:match("WakaTime") and msg:match("version") then
    return
  end
  -- Let the original notify handle it (will be replaced by noice.nvim when loaded)
  original_notify(msg, level, opts)
end

-- Override echo for WakaTime messages during startup
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    vim.defer_fn(function()
      local original_echo = vim.api.nvim_echo
      vim.api.nvim_echo = function(chunks, history, opts)
        if type(chunks) == "table" and chunks[1] and type(chunks[1][1]) == "string" then
          if chunks[1][1]:match("WakaTime.*Install") or chunks[1][1]:match("WakaTime.*version") then
            return
          end
        end
        return original_echo(chunks, history, opts)
      end
    end, 0)
  end,
})

-- Disable diagnostics virtual text warnings
vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.ERROR }
  },
  signs = true,
  underline = true,
  update_in_insert = false,
})

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
      statuscolumn = { enabled = false },
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

  "echasnovski/mini.icons",

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
  { "folke/neodev.nvim",       opts = {} },
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
  {
    "wakatime/vim-wakatime",
    config = function()
      -- Silence WakaTime startup messages
      vim.g.wakatime_CLIPath = vim.fn.expand("~/.wakatime/wakatime-cli")
      vim.cmd([[
        silent! command! -nargs=0 WakaTimeCliVersion echo ""
      ]])
    end,
  },
  "axelvc/template-string.nvim",
  -- "windwp/nvim-ts-autotag",
  "neanias/everforest-nvim",
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
  {
    "yetone/avante.nvim",
    build = vim.fn.has("win32") ~= 0
        and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
        or "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      -- add any opts here
      -- for example
      provider = "openai",
      providers = {
        openai = {
          endpoint = "https://openrouter.ai/api/v1",
          model = "anthropic/claude-sonnet-4",
          api_key_name = "OPENROUTER_API_KEY",
          timeout = 30000,
          context_window = 200000,
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 50000,
            transforms = { "middle-out" },
          },
        },
      },
      mappings = {
        ask = "<leader>aa",
        new_ask = "<leader>an",
        edit = "<leader>ae",
        refresh = "<leader>ar",
        focus = "<leader>af",
        toggle = {
          default = "<leader>l",
        },
        submit = {
          normal = "<CR>", -- Enter in normal mode
          insert = "<CR>", -- Enter in insert mode
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick",         -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua",              -- for file_selector provider fzf
      "stevearc/dressing.nvim",        -- for input provider dressing
      "folke/snacks.nvim",             -- for input provider snacks
      "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",        -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
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
