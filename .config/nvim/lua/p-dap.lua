local dap, dapui = require("dap"), require("dapui")

dapui.setup()

-- keymaps
local wk = require("which-key")
wk.register({

  D = {
    D = {
      "<Cmd>lua require('dapui').toggle()<Cr>",
      "Debugger",
    },
  },
}, { prefix = "<leader>" })
wk.register({
  D = {
    b = {
      "<Cmd>lua require('dap').toggle_breakpoint()<Cr>",
      "Toggle Breakpoints",
      mode = "n",
    },
  },
})

--event
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

---breakpoint style
local set_namespace = vim.api.nvim__set_hl_ns or vim.api.nvim_set_hl_ns
local namespace = vim.api.nvim_create_namespace("dap-hlng")
vim.api.nvim_set_hl(
  namespace,
  "DapBreakpoint",
  { fg = "#eaeaeb", bg = "#ffffff" }
)
vim.api.nvim_set_hl(
  namespace,
  "DapLogPoint",
  { fg = "#eaeaeb", bg = "#ffffff" }
)
vim.api.nvim_set_hl(namespace, "DapStopped", { fg = "#eaeaeb", bg = "#ffffff" })

vim.fn.sign_define("DapBreakpoint", {
  text = "🔴",
  texthl = "DapBreakpoint",
  linehl = "DapBreakpoint",
  numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapBreakpointCondition", {
  text = "ﳁ",
  texthl = "DapBreakpoint",
  linehl = "DapBreakpoint",
  numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapBreakpointRejected", {
  text = "",
  texthl = "DapBreakpoint",
  linehl = "DapBreakpoint",
  numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapLogPoint", {
  text = "",
  texthl = "DapLogPoint",
  linehl = "DapLogPoint",
  numhl = "DapLogPoint",
})
vim.fn.sign_define("DapStopped", {
  text = "",
  texthl = "DapStopped",
  linehl = "DapStopped",
  numhl = "DapStopped",
})
