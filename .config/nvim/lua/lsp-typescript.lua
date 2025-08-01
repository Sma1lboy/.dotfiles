local wk = require("which-key")
wk.register({
  ["<leader>"] = {
    m = { "<cmd>TSToolsOrganizeImports<cr>", "Organize imports" },
    a = { "<cmd>TSToolsAddMissingImports<cr>", "Add missing imports" },
    --remove unused imports
    z = { "<cmd>TSToolsRemoveUnusedImports<cr>", "Remove unused imports" },
  },
})
local api = require("typescript-tools.api")

local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
require("typescript-tools").setup({
  handlers = {
    ["textDocument/publishDiagnostics"] = api.filter_diagnostics({ 6133 }),
  },

  capabilities = cmp_capabilities,
})
--
require("lspconfig").ts_ls.setup({
  capabilities = cmp_capabilities,
  on_attach = function(client)
    -- Disable rename
    client.resolved_capabilities.rename = false
  end,
})
