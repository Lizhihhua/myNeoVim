-- python3 -m pip install debugpy
local dap = require('dap')
dap.adapters.python = {
    type = "executable",
    command = "D:/ProgramFiles/Python/python.exe",
    args = {"-m", "debugpy.adapter"}
}
dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
            return vim.g.python_path
        end
    }
}
