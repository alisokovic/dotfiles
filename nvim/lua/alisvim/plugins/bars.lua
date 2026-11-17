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
-- true  => see-through bar
-- false => solid bar, mirroring the statusline at the bottom
local transparent_bar = true

local bar_bg    = transparent_bar and palette.none or palette.mantle
local active_bg = palette.surface0

local diag_icons = {
    error   = "",
    warning = "",
    hint    = "",
    info    = "",
}

-- Every group is styled explicitly. Anything left out falls
-- back to shades that bufferline derives from Normal's background.
local hl = {
    fill             = { fg = palette.overlay1, bg = bar_bg },
    trunc_marker     = { fg = palette.overlay1, bg = bar_bg },
    offset_separator = { fg = palette.surface1, bg = bar_bg },

    -- Tab text
    background       = { fg = palette.overlay1, bg = bar_bg },
    buffer_visible   = { fg = palette.subtext0, bg = bar_bg },
    buffer_selected  = { fg = palette.text, bg = active_bg, bold = true },

    -- Separators
    separator              = { fg = palette.surface1, bg = bar_bg },
    separator_visible      = { fg = palette.surface1, bg = bar_bg },
    separator_selected     = { fg = active_bg, bg = active_bg },
    tab_separator          = { fg = palette.surface1, bg = bar_bg },
    tab_separator_selected = { fg = active_bg, bg = active_bg },

    -- Accent marker on the active tab
    indicator_visible  = { fg = bar_bg, bg = bar_bg },
    indicator_selected = { fg = palette.mauve, bg = active_bg },

    -- Tab-page indicators (only used when mode = "buffers")
    tab          = { fg = palette.overlay1, bg = bar_bg },
    tab_selected = { fg = palette.text, bg = active_bg, bold = true },
    tab_close    = { fg = palette.red, bg = bar_bg },
}

-- Groups that come in three flavours: inactive / visible / selected
local function states(name, inactive, visible, selected, selected_extra)
    hl[name]                = { fg = inactive, bg = bar_bg }
    hl[name .. "_visible"]  = { fg = visible, bg = bar_bg }
    hl[name .. "_selected"] = vim.tbl_extend("force", { fg = selected, bg = active_bg }, selected_extra or {})
end

states("numbers",      palette.overlay0, palette.overlay1, palette.mauve)
states("close_button", palette.overlay0, palette.overlay1, palette.red)
states("modified",     palette.peach,    palette.peach,    palette.peach)
states("duplicate",    palette.overlay0, palette.overlay0, palette.overlay1)
states("pick",         palette.red,      palette.red,      palette.red, { bold = true })

-- Tab names tinted by diagnostics (errors / warnings only); info / hint keep normal text colours
states("error",   palette.red,    palette.red,    palette.red,    { bold = true })
states("warning", palette.yellow, palette.yellow, palette.yellow, { bold = true })
states("info",    palette.overlay1, palette.subtext0, palette.text, { bold = true })
states("hint",    palette.overlay1, palette.subtext0, palette.text, { bold = true })

-- The "<icon> <count>" badge, coloured by severity
states("diagnostic",         palette.overlay1, palette.subtext0, palette.text)
states("error_diagnostic",   palette.red,      palette.red,      palette.red)
states("warning_diagnostic", palette.yellow,   palette.yellow,   palette.yellow)
states("info_diagnostic",    palette.sky,      palette.sky,      palette.sky)
states("hint_diagnostic",    palette.teal,     palette.teal,     palette.teal)

require("bufferline").setup({
    options = {
        mode = "tabs",
        numbers = "ordinal",
        separator_style = "thin",
        indicator = { style = "icon", icon = "▎" },
        show_buffer_close_icons = true,
        show_close_icon = false,
        always_show_bufferline = false,
        diagnostics = "nvim_lsp",

        diagnostics_indicator = function(count, level)
            return (diag_icons[level] or "") .. " " .. count
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
    highlights = hl,
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
        local mode_hl = vim.api.nvim_get_hl(0, { name = "lualine_a_" .. lualine_mode, link = false })

        if mode_hl and mode_hl.bg then
            vim.api.nvim_set_hl(0, "CursorLineNr", { fg = mode_hl.bg, bold = true })
            vim.api.nvim_set_hl(0, "CursorLine", { underline = true, sp = mode_hl.bg, bg = "NONE" })
        end
    end,
})
