return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function ()
        local toggleterm = require("toggleterm")

        toggleterm.setup({
            direction = "float",
            size = function (term)
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

        vim.keymap.set(
            "n",
            "<leader>tt",
            "<cmd>ToggleTerm<CR>",
            { desc = "toggle terminal" }
        )
    end
}
