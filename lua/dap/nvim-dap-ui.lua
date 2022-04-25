-- https://github.com/rcarriga/nvim-dap-ui
local dap = require("dap")
local dapui = require("dapui")

-- 初始化调试界面
dapui.setup(
    {
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
            -- Use a table to apply multiple mappings
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
            toggle = "t",
        },
        sidebar = {
            -- You can change the order of elements in the sidebar
            elements = {
                -- Provide as ID strings or tables with "id" and "size" keys
                { id = "scopes",size = 0.5 },
                --{ id = "breakpoints", size = 0},
                --{ id = "stacks", size = 0},
                { id = "watches", size = 0.5 },
            },
            size = 40,
            -- dapui 的窗口设置在右边
            position = "left"
        },
        tray = {
            elements = { "repl" },
            size = 5,
            position = "bottom", -- Can be "left", "right", "top", "bottom"
        },
        floating = {
            max_height = nil, -- These can be integers or a float between 0 and 1.
            max_width = nil, -- Floats will be treated as percentage of your screen.
            border = "single", -- Border style. Can be "single", "double" or "rounded"
            mappings = { close = { "q", "<Esc>" } },
        },
        windows = { indent = 1 },
        -- render = { max_type_length = nil}
    }
)

-- 如果开启或关闭调试，则自动打开或关闭调试界面
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
    vim.api.nvim_command("DapVirtualTextEnable")
    -- dapui.close("tray")
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    vim.api.nvim_command("DapVirtualTextDisable")
    dapui.close()
end  
dap.listeners.before.event_exited["dapui_config"] = function()
    vim.api.nvim_command("DapVirtualTextDisable")
    dapui.close()
end
  -- for some debug adapter, terminate or exit events will no fire, use disconnect reuest instead
dap.listeners.before.disconnect["dapui_config"] = function()
    vim.api.nvim_command("DapVirtualTextDisable")
    dapui.close()
end

dap.defaults.fallback.terminal_win_cmd = '30vsplit new'    -- 右边生成终端

