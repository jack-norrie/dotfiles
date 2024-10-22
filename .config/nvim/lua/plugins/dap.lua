local dap = require("dap")

dap.adapters.python = {
  type = "executable",
  command = "python",
  args = { "-m", "debugpy.adapter" },
}

local configs = dap.configurations.python or {}
dap.configurations.python = configs
table.insert(configs, {
  type = "python",
  request = "launch",
  name = "My custom launch configuration",
  program = "${file}",
  cwd = "${workspaceFolder}",
  env = {
    PYTHONPATH = "${workspaceFolder}:${env:PYTHONPATH}",
  },
  justMyCode = false,
})

return {}
