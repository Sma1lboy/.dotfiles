local dap, dapui = require("dap"), require("dapui")

dapui.setup()

-- keymaps
local wk = require("which-key")
wk.register({
  D = {
    "<Cmd>lua require('dapui').toggle()<Cr>",
    "Debugger",
  },
}, { prefix = "<leader>" })
wk.register({
  n = {
    n = {
      "<Cmd>lua require('dap').toggle_breakpoint()<Cr>",
      "Toggle Breakpoints",
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
