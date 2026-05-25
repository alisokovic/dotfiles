-- vim ui2
require("vim._core.ui2").enable({
    enable = true,
    msg = {
        target = "cmd",
        pager  = { height = 0.5 },
        dialog = { height = 0.5 },
        cmd    = { height = 0.5 },
        msg    = { height = 0.5, timeout = 4500 },
    },
})

vim.g.alistheme_cursor_underline = true
vim.cmd.colorscheme "alistheme"

require("alisvim.core")
require("alisvim.plugins")
