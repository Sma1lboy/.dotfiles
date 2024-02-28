vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("n", "<c-a>", "ggVG")

keymap.set({ "n", "x" }, "<leader>p", '"0p')

keymap.set("n", "<leader>q", "<cmd>q<cr>")
keymap.set("n", "<leader>w", "<cmd>w<cr>")
keymap.set("n", "<leader>x", "<cmd>x<cr>")

keymap.set("n", "j", [[v:count?'j':'gj']], { noremap = true, expr = true })
keymap.set("n", "k", [[v:count?'j':'gk']], { noremap = true, expr = true })

keymap.set(
  "i",
  "<S-Tab>",
  "<C-d>",
  { desc = "Shift + Tab to unindent in insert mode" }
)

function ToggleAccessModifierInVisual()
  -- 获取选中文本的范围
  local _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
  local _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
  if csrow ~= cerow then
    print("Multi-line selection is not supported.")
    return
  end

  -- 获取当前行内容
  local line = vim.api.nvim_get_current_line()
  local selection = line:sub(cscol, cecol)
  local newSelection

  -- 检查并替换选中的关键字
  if selection:find("private") then
    newSelection = selection:gsub("private", "public")
  elseif selection:find("public") then
    newSelection = selection:gsub("public", "private")
  end

  if newSelection then
    -- 替换当前行的选中内容
    local newLine = line:sub(1, cscol - 1)
      .. newSelection
      .. line:sub(cecol + 1)
    vim.api.nvim_set_current_line(newLine)
  end
end

vim.keymap.set(
  "x",
  "<leader>uw",
  ":<C-u>lua ToggleAccessModifierInVisual()<CR>",
  { desc = "Toggle private/public in visual mode" }
)
