vim.pack.add({
    "https://github.com/akinsho/toggleterm.nvim",
})

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
            guifg = "#112638",
        },
    },
    --shell = "C:/Users/alist/AppData/Local/Microsoft/WindowsApps/pwsh.exe",
    float_opts = {
        border = "curved",
    }
})

vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>",   { desc = "vertical terminal"})
vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "horizontal terminal" })
vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>",      { desc = "float terminal" })
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=tab<CR>",        { desc = "terminal in new tab" })
