local ng = require("neogit")
ng.setup()
local keymap = vim.keymap
keymap.set("n", "ng", "<cmd>Neogit<cr>")
