vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

local api = require("nvim-tree.api")
-- Looked up on each press: functions taken from the api before setup() are
-- placeholders that only report "setup not called".
vim.keymap.set("n", "<c-e>", function() api.tree.toggle() end)
local function my_on_attach(bufnr)
  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end
  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set("n", "<C-e>", api.tree.toggle, opts("Toggle"))
  vim.keymap.set("n", "<ESC>", api.tree.toggle, opts("Toggle"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

require("nvim-tree").setup({
  on_attach = my_on_attach,
  filters = {
    custom = { "^.git$" },
  },
  actions = {
    open_file = { quit_on_open = true },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  git = {
    enable = false,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
})
vim.cmd([[
    :hi      NvimTreeExecFile    guifg=#ffa0a0
    :hi      NvimTreeSpecialFile guifg=#ff80ff gui=underline
    :hi      NvimTreeSymlink     guifg=Yellow  gui=italic
    :hi link NvimTreeImageFile   Title
]])
