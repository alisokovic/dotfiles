vim.pack.add({
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/nvim-neotest/nvim-nio",
    "https://github.com/rcarriga/nvim-dap-ui",
})

local dap = require("dap")
local dapui = require("dapui")

---- Adapter Settings ----
-- Requires GDB 14.1+ for DAP support (--interpreter=dap)
dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}

---- Language Settings ----
local c_cpp_config = {
    {
        name = "Launch Executable (GDB)",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
    {
        name = "Launch Executable with arguments (GDB)",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        args = function()
            local args_str = vim.fn.input("Program arguments: ")
            return vim.split(args_str, " +", { trimempty = true })
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
    {
        name = "Attach to Process (GDB)",
        type = "gdb",
        request = "attach",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
    },
}

dap.configurations.c = c_cpp_config
dap.configurations.cpp = c_cpp_config

---- UI Setup ----
dapui.setup()

-- Automatically open UI panels when a session starts; close when it finishes
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

-- Visual breakpoint indicators (Gutter signs)
vim.fn.sign_define("DapBreakpoint",          { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected",  { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint",            { text = "◆", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped",             { text = "▶", texthl = "DiagnosticOk", linehl = "Visual", numhl = "DiagnosticOk" })

---- Keymaps ----
local map = vim.keymap.set

-- Stepping & flow control
map("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
map("n", "<F10>", dap.step_over, { desc = "Debug: Step over" })
map("n", "<F11>", dap.step_into, { desc = "Debug: Step into" })
map("n", "<F12>", dap.step_out, { desc = "Debug: Step out" })

-- Breakpoint management
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle breakpoint"})
map("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: Set conditional breakpoint"})

-- UI controls
map("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle DAP UI" })
map("n", "<leader>dr", dap.repl.open, { desc = "Debug: Open repl" })
map("n", "<leader>dq", dap.terminate, { desc = "Debug: Terminate session" })
map("n", "<leader>dl", dap.run_last, { desc = "Debug: Run last session"})
