-- alistheme.lua
-- Palette: Duskfox (EdenEast/nightfox)
-- Style: Transparent Main BG + Soft Purple Float BG + Andromeda Fonts

-- 1. Configuration Options
local config = {
    -- Font Styles
    italic_comments = vim.g.alistheme_italic_comments or true,
    italic_keywords = vim.g.alistheme_italic_keywords or true,
    italic_functions = vim.g.alistheme_italic_functions or false,
    italic_variables = vim.g.alistheme_italic_variables or false,
    italic_types = vim.g.alistheme_italic_types or true,
    bold_functions = vim.g.alistheme_bold_functions or true,
    bold_keywords = vim.g.alistheme_bold_keywords or false,

    -- Cursor Line Options
    cursor_underline = vim.g.alistheme_cursor_underline or false,
    cursor_underline_color = vim.g.alistheme_cursor_underline_color or "#F6C177", -- Peach
}

local colors = {
    none = "NONE",

    -- DUSKFOX PALETTE (EdenEast/nightfox)
    bg_float = "#112638",   -- Soft Purple (Signature Duskfox BG)
    fg = "#e0def4",         -- Text (Soft White)

    comment = "#817c9c",    -- Muted Purple/Grey
    selection = "#1C404F",  -- Selection BG
    seperator = "#191726",   -- windows seperator

    red = "#eb6f92",        -- Errors / Deletions
    orange = "#ea9a97",     -- Peach (Parameters / Numbers)
    yellow = "#f6c177",     -- Gold (types / struct)
    green = "#a3be8c",      -- Strings
    cyan = "#9ccfd8",       -- Foam (Operators / borders)
    blue = "#3e8fb0",       -- Functions
    purple = "#c4a7e7",     -- Iris (Keywords / Includes)
    magenta = "#eb98c3",    -- Preproc / Constants
}

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end

vim.g.colors_name = "alistheme"

local function set_hl(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

-- 2. Editor UI 
-- Main Window: Transparent
set_hl("Normal", { fg = colors.fg, bg = colors.none })
set_hl("SignColumn", { bg = colors.none })
set_hl("LineNr", { fg = colors.comment, bg = colors.none })
set_hl("CursorLineNr", { fg = colors.yellow, bg = colors.none, bold = true })
set_hl("EndOfBuffer", { fg = colors.none, bg = colors.none })

-- Floating Windows & Menus: Soft Purple BG (Not Transparent)
set_hl("NormalFloat", { fg = colors.fg, bg = colors.bg_float })
set_hl("FloatBorder", { fg = colors.purple, bg = colors.bg_float })
set_hl("Pmenu", { fg = colors.fg, bg = colors.bg_float })
set_hl("PmenuSel", { fg = colors.bg_float, bg = colors.purple, bold = true })
set_hl("PmenuSbar", { bg = colors.bg_float })
set_hl("PmenuThumb", { bg = colors.comment })

-- Window Separators
set_hl("WinSeparator", { fg = colors.seperator, bg = colors.none }) 
set_hl("VertSplit", { fg = colors.seperator, bg = colors.none }) 

-- StatusLine (Duskfox Style)
set_hl("StatusLine", { fg = colors.purple, bg = colors.bg_float, bold = true }) 
set_hl("StatusLineNC", { fg = colors.comment, bg = colors.bg_float }) 

-- Command Line Messages
set_hl("MsgArea", { fg = colors.fg, bg = colors.none }) 
set_hl("ModeMsg", { fg = colors.yellow, bold = true }) 
set_hl("MsgSeparator", { fg = colors.cyan, bg = colors.none })
set_hl("MoreMsg", { fg = colors.blue, bold = true })
set_hl("Question", { fg = colors.green, bold = true }) 
set_hl("ErrorMsg", { fg = colors.red, bold = true })
set_hl("WarningMsg", { fg = colors.yellow, bold = true })
set_hl("Title", { fg = colors.blue, bold = true }) 
set_hl("Directory", { fg = colors.blue, bold = true })

-- Cursor & Selection
local cursor_opts = { bg = colors.none } 
if config.cursor_underline then
    cursor_opts.underline = true
    cursor_opts.sp = config.cursor_underline_color
end
set_hl("CursorLine", cursor_opts)
set_hl("Visual", { bg = colors.selection })

-- 3. Standard Syntax
set_hl("Comment", { fg = colors.comment, italic = config.italic_comments })

set_hl("Constant", { fg = colors.orange })
set_hl("String", { fg = colors.green, italic = false }) 
set_hl("Character", { fg = colors.green })
set_hl("Number", { fg = colors.orange })
set_hl("Boolean", { fg = colors.orange, bold = true })
set_hl("Float", { fg = colors.orange })

set_hl("Identifier", { fg = colors.fg, italic = config.italic_variables })
set_hl("Function", { fg = colors.blue, bold = config.bold_functions, italic = config.italic_functions })

-- Keywords: Lavender/Purple (Duskfox style)
set_hl("Statement", { fg = colors.purple, italic = config.italic_keywords, bold = config.bold_keywords }) 
set_hl("Conditional", { fg = colors.purple, italic = config.italic_keywords, bold = config.bold_keywords })
set_hl("Repeat", { fg = colors.purple, italic = config.italic_keywords, bold = config.bold_keywords })
set_hl("Label", { fg = colors.purple, italic = config.italic_keywords })
set_hl("Operator", { fg = colors.cyan })
set_hl("Keyword", { fg = colors.purple, italic = config.italic_keywords, bold = config.bold_keywords })
set_hl("Exception", { fg = colors.purple, italic = config.italic_keywords })

set_hl("PreProc", { fg = colors.magenta }) 
set_hl("Include", { fg = colors.purple, italic = config.italic_keywords }) 
set_hl("Define", { fg = colors.purple })
set_hl("Macro", { fg = colors.purple })

set_hl("Type", { fg = colors.yellow, italic = config.italic_types }) 
set_hl("StorageClass", { fg = colors.yellow, italic = config.italic_types })
set_hl("Structure", { fg = colors.yellow, italic = config.italic_types }) 
set_hl("Typedef", { fg = colors.yellow, italic = config.italic_types })

set_hl("Special", { fg = colors.orange })
set_hl("Error", { fg = colors.fg, bg = colors.red })
set_hl("Todo", { fg = colors.bg_float, bg = colors.yellow, bold = true })

-- 4. Treesitter (C++ & Python Specifics)

-- C++
set_hl("@variable", { fg = colors.fg, italic = config.italic_variables })
set_hl("@variable.builtin", { fg = colors.red, italic = true }) -- this
set_hl("@parameter", { fg = colors.fg, italic = true })       
set_hl("@constructor", { fg = colors.yellow, bold = true }) 

set_hl("@function", { fg = colors.blue, bold = config.bold_functions, italic = config.italic_functions })
set_hl("@function.builtin", { fg = colors.blue, bold = config.bold_functions })
set_hl("@function.macro", { fg = colors.magenta })

set_hl("@keyword", { fg = colors.red, italic = config.italic_keywords, bold = config.bold_keywords })
set_hl("@keyword.function", { fg = colors.purple, italic = config.italic_keywords }) 
set_hl("@keyword.operator", { fg = colors.purple })

set_hl("@type", { fg = colors.yellow, italic = config.italic_types })
set_hl("@type.builtin", { fg = colors.yellow, italic = config.italic_types }) 
set_hl("@namespace", { fg = colors.fg })

-- Python
set_hl("@string.escape", { fg = colors.magenta })
set_hl("@punctuation.delimiter", { fg = colors.fg })
set_hl("@punctuation.bracket", { fg = colors.fg })
set_hl("@variable.parameter", { fg = colors.fg, italic = true }) 

-- 5. LSP & Git
set_hl("DiagnosticError", { fg = colors.red })
set_hl("DiagnosticWarn", { fg = colors.yellow })
set_hl("DiagnosticInfo", { fg = colors.blue })
set_hl("DiagnosticHint", { fg = colors.green })
set_hl("DiagnosticUnderlineError", { sp = colors.red, undercurl = true })

set_hl("DiffAdd", { bg = "#2d3f38" })    -- Muted Green bg
set_hl("DiffChange", { bg = "#2d2a45" }) -- Muted Purple bg
set_hl("DiffDelete", { bg = "#3d2830" }) -- Muted Red bg
