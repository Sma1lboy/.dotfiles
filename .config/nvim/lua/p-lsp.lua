local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({})
local keymap = vim.keymap

keymap.set("n", "[d", vim.diagnostic.goto_prev)
keymap.set("n", "]d", vim.diagnostic.goto_next)

local builtin = require("telescope.builtin")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = ev.buf }
    keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    keymap.set("n", "<leader>k", vim.lsp.buf.definition, opts)
    keymap.set("n", "<space>r", vim.lsp.buf.rename, opts)
    keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    keymap.set("n", "gr", builtin.lsp_references, opts)
  end,
})
