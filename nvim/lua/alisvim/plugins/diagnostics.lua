vim.pack.add({
    "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
    "https://github.com/folke/trouble.nvim",
    "https://github.com/stevearc/quicker.nvim",
})

---- Diagnostics ----
local severity = vim.diagnostic.severity

vim.diagnostic.config({
    virtual_text = false,
    signs = {
        text = {
            [severity.ERROR] = "",
            [severity.WARN] = "",
            [severity.HINT] = "",
            [severity.INFO] = "",
        },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
})

---- Tiny-Inline-Diagnostic ----
require("tiny-inline-diagnostic").setup({
    signs = {
        left = "",
        right = "",
        arrow = "  ",
        up_arrow = "  ",
        vertical = " │",
        vertical_end = " └",
    },
    options = {
        use_icons_from_diagnostic = true,
        multilines = {
            enabled = true,
            always_show = false,
        },
    },
})

---- Trouble ----
require("trouble").setup({
    focus = true,
})

-- Global keymaps
vim.keymap.set(
    "n", "<leader>xq",
    "<cmd>Trouble qflist toggle<CR>",
    { desc = "Quickfix list" }
)
vim.keymap.set(
    "n", "<leader>xL",
    "<cmd>Trouble loclist toggle<CR>",
    { desc = "Location list" }
)
vim.keymap.set(
    "n", "<leader>xt",
    "<cmd>Trouble todo toggle<CR>",
    { desc = "Todos in trouble" }
)

-- Keymaps attached only when an LSP connects to buffer
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local map = function(mode, lfs, rhs, desc)
            vim.keymap.set(mode, lfs, rhs, { buffer = ev.buf, desc = desc })
        end

        map( "n", "<leader>xx",
            "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
            "Buffer diagnostics"
        )
        map( "n", "<leader>xX",
            "<cmd>Trouble diagnostics toggle<CR>",
            "Workspace diagnostics"
        )
        map( "n", "<leader>xs",
            "<cmd>Trouble symbols toggle focus=false<CR>",
            "Symbols"
        )
        map( "n", "<leader>xl",
            "<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
            "LSP references"
        )
    end
})

---- Quicker ----
local quicker = require("quicker")
quicker.setup({
    keys = {
        {
            ">",
            function()
                quicker.expand({ before = 2, after = 2, add_to_existing = true })
            end,
            desc = "Expand quickfix context",
        },
        {
            "<",
            function()
                quicker.collapse()
            end,
            desc = "Collapse quickfix context",
        },
    },
})

vim.keymap.set("n", "<leader>qq", function()
    quicker.toggle()
end, { desc = "Toggle quickfix", })

vim.keymap.set("n", "<leader>ll", function()
    quicker.toggle({ loclist = true })
end, { desc = "Toggle loclist", })

---- Lsp Progress ----
local ui = require("vim._core.ui2")
local api = vim.api

ui.enable({
    msg = {
        targets = {
            progress = "msg",
        },
    },
})

local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local i_frame = 0

local message_id = nil
local function progress(percent, title, is_running)
    local status = "success"
    if is_running then
        status = "running"
    end

    if i_frame == #frames then
        i_frame = 0
    end
    i_frame = i_frame + 1

    message_id = api.nvim_echo({ { title } }, false, {
        id = message_id,
        percent = percent,
        source = "lsp-progress",
        status = status,
        title = frames[i_frame] .. " LSP",
        kind = "progress",
    })
end

api.nvim_create_autocmd("LspProgress", {
    callback = function(args)
        local value = args.data.params.value
        if not value then return end

        local title = value.title or "LSP"
        local is_running = value.kind ~= "end"
        local percent = value.percentage or (is_running and 0 or 100)

        progress(percent, title, is_running)
    end
})
