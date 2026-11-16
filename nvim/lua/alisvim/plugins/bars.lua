vim.pack.add({
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/akinsho/bufferline.nvim",
})

---- Colors ----
local palette = require("alisvim.palette")

---- LuaLine ----
require("lualine").setup({
    options = {
        theme = "palenight",
    },
    sections = {
        lualine_b = {
            "branch",
            "diff",
            {
                "diagnostics",
                symbols = {
                    error = " ",
                    warn  = " ",
                    info  = " ",
                },
            },
        },
    },
})

---- Bufferline ----
require("bufferline").setup({
    options = {
        mode = "tabs",
        separator_style = "thin",
        show_buffer_close_icons = true,
        show_close_icon = false,
        always_show_bufferline = false,
        diagnostics = "nvim_lsp",

        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and "" or ""
            return icon .. " " .. count
        end,

        -- Align tabline cleanly with NvimTree sidebar
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "center",
                separator = true,
            }
        },
    },
    highlights = {
        -- Transparent Bar Fill
        fill = { bg = palette.none },

        -- Unselected / Inactive Tabs (Floating Text, No Dark Boxes)
        background             = { fg = palette.overlay1, bg = palette.none },
        buffer_visible         = { fg = palette.subtext0, bg = palette.none },
        close_button           = { fg = palette.overlay1, bg = palette.none },
        close_button_visible   = { fg = palette.subtext0, bg = palette.none },
        separator              = { fg = palette.surface0, bg = palette.none },
        separator_visible      = { fg = palette.surface0, bg = palette.none },
        modified               = { fg = palette.peach, bg = palette.none },
        modified_visible       = { fg = palette.peach, bg = palette.none },

        -- Active / Selected Tab
        buffer_selected        = { fg = palette.text, bg = palette.none, bold = true },
        close_button_selected  = { fg = palette.red, bg = palette.none },
        separator_selected     = { fg = palette.surface0, bg = palette.none },
        indicator_selected     = { fg = palette.mauve, bg = palette.none },
        modified_selected      = { fg = palette.peach, bg = palette.none },

        -- Diagnostics inside Tabs
        error             = { fg = palette.red, bg = palette.none },
        error_selected    = { fg = palette.red, bg = palette.none, bold = true },
        warning           = { fg = palette.yellow, bg = palette.none },
        warning_selected  = { fg = palette.yellow, bg = palette.none, bold = true },
    },
})

---- Sync Mode Highlights ----
local mode_map = {
    n = "normal",
    i = "insert",
    v = "visual",
    V = "visual",
    ["\22"] = "visual", -- <C-v>
    c = "command",
    s = "select",
    S = "select",
    ["\19"] = "select", -- <C-s>
    R = "replace",
}

vim.api.nvim_create_autocmd("ModeChanged", {
    group = vim.api.nvim_create_augroup("SyncModeHighlights", { clear = true }),
    callback = function()
        local mode_key = vim.api.nvim_get_mode().mode:sub(1, 1)
        local lualine_mode = mode_map[mode_key] or "normal"
        local hl = vim.api.nvim_get_hl(0, { name = "lualine_a_" .. lualine_mode, link = false })

        if hl and hl.bg then
            vim.api.nvim_set_hl(0, "CursorLineNr", { fg = hl.bg, bold = true })
            vim.api.nvim_set_hl(0, "CursorLine", { underline = true, sp = hl.bg, bg = "NONE" })
        end
    end,
})
