require("lint").linters_by_ft = {
  javascript = { "eslint" },
  typescript = { "eslint" },
  javascriptreact = { "eslint" },
  typescriptreact = { "eslint" },
  c = { "clangtidy" },
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    -- A project without eslint installed is not an error worth a popup.
    require("lint").try_lint(nil, { ignore_errors = true })
  end,
})
