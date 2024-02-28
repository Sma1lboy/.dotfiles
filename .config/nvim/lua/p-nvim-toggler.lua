require("nvim-toggler").setup({
  inverses = {
    ["true"] = "false",
    ["True"] = "False",
    ["yes"] = "no",
    ["on"] = "off",
    ["left"] = "right",
    ["up"] = "down",
    ["enable"] = "disable",
    ["!="] = "==",
    ["public"] = "private",
    ["0"] = "1",
  },
  remove_default_keybinds = true,
  remove_default_inverses = true,
})
vim.keymap.set({ "n", "v" }, "<leader>F", require("nvim-toggler").toggle)
