local dap = require "dap"
local dapui = require "dapui"
local dap_python = require "dap-python"

-- Use the debugpy installed by mason
local mason_path = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python"
dap_python.setup(mason_path)

-- DAP UI auto-open/close
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
