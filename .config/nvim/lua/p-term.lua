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
