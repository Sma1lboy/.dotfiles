-- the default terminal looks like
require("toggleterm").setup({
  size = 15,
  open_mapping = [[<c-j>]],
  hide_numbers = true,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "horizontal",
  close_on_exit = true,
  shell = vim.o.shell,
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  hidden = true,
  direction = "float",
  float_opts = { border = "curved", width = 120, height = 28, winblend = 3 },
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap(
  "n",
  "lg",
  "<cmd>lua _lazygit_toggle()<CR>",
  { noremap = true, silent = true }
)
