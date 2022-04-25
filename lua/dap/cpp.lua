local dap = require('dap')
dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = "executable",
    command = 'D:/ProgramFiles/cpptools/extension/debugAdapters/bin/OpenDebugAD7.exe',
    options = {detached = false},
}
dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
            return "${fileBasenameNoExtension}.exe"
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
        setupCommands = {  
            { 
                text = '-enable-pretty-printing',
                description =  'enable pretty printing',
                ignoreFailures = false 
            },
        },
    } 
}
dap.configurations.c = dap.configurations.cpp
