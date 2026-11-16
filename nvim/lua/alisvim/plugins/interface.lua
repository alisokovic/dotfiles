vim.pack.add({
    "https://github.com/sphamba/smear-cursor.nvim",
    "https://github.com/rachartier/tiny-cmdline.nvim",
    "https://github.com/folke/which-key.nvim",
    "https://github.com/rcarriga/nvim-notify",
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    "https://github.com/hiphish/rainbow-delimiters.nvim",
    "https://github.com/stevearc/dressing.nvim",
    "https://github.com/akinsho/toggleterm.nvim",
})

---- Smear Cursor ----
require("smear_cursor").setup({
    cursor_color = "#C4206F",
})

---- Tiny CmdLine ----
local tiny_cmdline = require("tiny-cmdline")
tiny_cmdline.setup({
    on_reposition = tiny_cmdline.adapters.blink,
})

---- Which Key ----
vim.o.timeout = true
vim.o.timeoutlen = 500
require("which-key").setup({
    win = {
        border = "rounded",
    },
})

---- Notify ----
---@type any
local notify = require("notify")
notify.setup({
    timeout = 3000,
    background_colour = "#000000"
})

vim.notify = notify

vim.keymap.set("n", "<leader>nn", function()
    notify.dismiss({ silent = true, pending = true })
end, { desc = "Dismiss all notifications" })

---- Indent Blankline ----
require("ibl").setup({
    indent = {
        char = "┊",
        tab_char = "┊",
        highlight = "IblIndent",
        smart_indent_cap = true,
        priority = 1,
    },
    whitespace = {
        highlight = "IblWhitespace",
        remove_blankline_trail = true,
    },
    scope = { enabled = false },
})

---- Rainbow Delimiters ----
require("rainbow-delimiters.setup").setup({
    strategy = {
        [""] = "rainbow-delimiters.strategy.global",
        vim = "rainbow-delimiters.strategy.local",
    },
    query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
    },
    highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterOrange",
        "RainbowDelimiterYellow",
        "RainbowDelimiterCyan",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterPink",
    },
})

---- Toggle-Term ----
require("toggleterm").setup({
    direction = "float",
    size = function(term)
        if term.direction == "horizontal" then
            return 16
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
    end,
    shade_terminals = false,
    highlights = {
        FloatBorder = {
            guifg = "#89b4fa",
            guibg = "NONE",
        },
    },
    float_opts = {
        border = "curved",
    }
})

vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>",   { desc = "vertical terminal"})
vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "horizontal terminal" })
vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>",      { desc = "float terminal" })
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=tab<CR>",        { desc = "terminal in new tab" })
