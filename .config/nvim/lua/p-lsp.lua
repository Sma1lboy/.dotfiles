local lspconfig = require("lspconfig")
local wk = require("which-key")
local builtin = require("telescope.builtin")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    wk.register({
      ["gD"] = { builtin.lsp_definitions, "LSP Definitions" },
      ["gr"] = { builtin.lsp_references, "LSP References" },
      ["gI"] = { builtin.lsp_implementations, "LSP Implementations" },
      ["gY"] = { builtin.lsp_type_definitions, "LSP Type Definitions" },
      ["<space>r"] = { vim.lsp.buf.rename, "LSP Rename" },
      ["<space>ca"] = { vim.lsp.buf.code_action, "LSP Code Actions" },
    }, { buffer = ev.buf })
  end,
})
