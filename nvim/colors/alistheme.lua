-- Clear existing highlights
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end

vim.g.colors_name = "alistheme"

-- Catppuccin Mocha Palette
local palette = {
    text      = "#cdd6f4",
    subtext0  = "#a6adc8",
    overlay2  = "#9399b2",
    overlay1  = "#7f849c",
    overlay0  = "#6c7086",
    surface1  = "#45475a",
    surface0  = "#313244",

    flamingo  = "#f2cdcd",
    pink      = "#f5c2e7",
    mauve     = "#cba6f7",
    red       = "#f38ba8",
    dark_red  = "#c9476c",
    peach     = "#fab387",
    yellow    = "#f9e2af",
    green     = "#a6e3a1",
    teal      = "#94e2d5",
    sky       = "#89dceb",
    blue      = "#89b4fa",
    lavender  = "#b4befe",

    none      = "NONE",
}

local highlights = {
    -- Core Editor (Fully Transparent)
    Normal       = { fg = palette.text, bg = palette.none },
    NormalNC     = { fg = palette.text, bg = palette.none },
    SignColumn   = { fg = palette.subtext0, bg = palette.none },
    FoldColumn   = { fg = palette.overlay0, bg = palette.none },
    EndOfBuffer  = { fg = palette.surface1, bg = palette.none },
    LineNr       = { fg = palette.overlay0, bg = palette.none },
    CursorLineNr = { fg = palette.peach, bold = true},

    -- WinBar & Window Headers
    WinBar          = { fg = palette.text, bg = palette.none },
    WinBarNC        = { fg = palette.subtext0, bg = palette.none },
    StatusLine      = { fg = palette.text, bg = palette.none },
    StatusLineNC    = { fg = palette.surface0, bg = palette.none },
    WinSeparator    = { fg = palette.surface0, bg = palette.none },
    VertSplit       = { fg = palette.surface0, bg = palette.none },

    -- Selections & Cursor line
    CursorLine   = { bg = palette.none, underline = true, sp = palette.peach },
    ColorColumn  = { bg = palette.surface0 },
    Visual       = { bg = palette.surface1, bold = true },
    Search       = { fg = palette.surface0, bg = palette.yellow },
    IncSearch    = { fg = palette.surface0, bg = palette.peach },

    -- Floating Windows
    NormalFloat  = { fg = palette.text, bg = palette.none },
    FloatBorder  = { fg = palette.blue, bg = palette.none },
    FloatTitle   = { fg = palette.mauve, bg = palette.none, bold = true },

    -- Completition Popup Menu
    Pmenu         = { fg = palette.text, bg = palette.surface0 },
    PmenuSel      = { fg = palette.mauve, bg = palette.surface1, bold = true },
    PmenuSbar     = { bg = palette.surface1 },
    PmenuThumb    = { bg = palette.overlay0 },

    -- Autocomplete Matches & Details
    PmenuMatch    = { fg = palette.peach, bg = palette.surface0, bold = true },
    PmenuMatchSel = { fg = palette.peach, bg = palette.surface1, bold = true },
    PmenuKind     = { fg = palette.lavender, bg = palette.surface0 },
    PmenuKindSel  = { fg = palette.lavender, bg = palette.surface1 },
    PmenuExtra    = { fg = palette.overlay1, bg = palette.surface0 },
    PmenuExtraSel = { fg = palette.overlay1, bg = palette.surface1 },

    -- Standard Syntax Highlighting
    Comment      = { fg = palette.overlay1, italic = true },
    Constant     = { fg = palette.peach },
    String       = { fg = palette.green },
    Character    = { fg = palette.teal },
    Number       = { fg = palette.peach },
    Boolean      = { fg = palette.peach },
    Float        = { fg = palette.peach },
    Identifier   = { fg = palette.flamingo },
    Function     = { fg = palette.blue, italic = true },
    Statement    = { fg = palette.mauve },
    Keyword      = { fg = palette.mauve },
    Conditional  = { fg = palette.mauve, italic = true },
    Repeat       = { fg = palette.mauve, italic = true },
    Delimiter    = { fg = palette.overlay2 },
    Operator     = { fg = palette.sky },
    PreProc      = { fg = palette.pink },
    Type         = { fg = palette.yellow },
    Special      = { fg = palette.pink },
    Underlined   = { underline = true },

    -- ===================================================================
    -- Conditionals & Loops (Italicized across all languages)
    -- ===================================================================
    ["@keyword.conditional"]       = { fg = palette.mauve, italic = true },
    ["@keyword.repeat"]            = { fg = palette.mauve, italic = true },

    -- ===================================================================
    -- Punctuation & Bracket Differentiation
    -- ===================================================================
    ["@punctuation.delimiter"]     = { fg = palette.overlay2 },
    ["@punctuation.bracket"]       = { fg = palette.lavender },

    -- ==========================================
    -- C / C++ Specific Highlights
    -- ==========================================
    ["@keyword.directive.cpp"]        = { fg = palette.pink, italic = true },
    ["@keyword.directive.define.cpp"] = { fg = palette.pink, italic = true },
    ["@keyword.import.cpp"]           = { fg = palette.pink, italic = true },
    ["@lsp.type.parameter.cpp"]       = { fg = palette.lavender },
    ["@type.builtin.cpp"]             = { fg = palette.red },
    ["@constant.macro.cpp"]           = { fg = palette.mauve, bold = true },
    ["@operator.cpp"]                 = { fg = palette.sky },
    ["@punctuation.bracket.cpp"]      = { fg = palette.red },

    -- ==========================================
    -- Python Specific Highlights
    -- ==========================================
    ["@attribute.python"]             = { fg = palette.blue, italic = true },
    ["@variable.builtin.python"]      = { fg = palette.red, italic = true },
    ["@function.builtin.python"]      = { fg = palette.teal },
    ["@keyword.import.python"]        = { fg = palette.mauve, bold = true },
    ["@string.documentation.python"]  = { fg = palette.overlay2, italic = true },

    -- ===================================================================
    -- Messages, Command Output & UI2 Pager
    -- ===================================================================
    -- Command Line & Message Area
    MsgArea         = { fg = palette.text, bg = palette.none },
    MsgSeparator    = { fg = palette.surface0, bg = palette.none },
    ModeMsg         = { fg = palette.subtext0, bold = true },
    MoreMsg         = { fg = palette.blue },
    WarningMsg      = { fg = palette.yellow, bold = true },
    ErrorMsg        = { fg = palette.red, bold = true },

    -- Output Titles & Command Headers
    Title           = { fg = palette.mauve, bold = true },
    Question        = { fg = palette.lavender, bold = true },

    -- Shell Output & Special Text Formatting
    Directory       = { fg = palette.blue },
    SpecialKey      = { fg = palette.overlay0 },
    QuickFixLine    = { fg = palette.mauve, bg = palette.surface0, bold = true },

    -- ==========================================
    -- Diagnostics
    -- ==========================================
    -- LSP Diagnostics (Base Groups)
    DiagnosticError              = { fg = palette.dark_red },
    DiagnosticWarn               = { fg = palette.yellow },
    DiagnosticInfo               = { fg = palette.sky },
    DiagnosticHint               = { fg = palette.teal },

    -- Virtual Text (Inline messages on the right)
    DiagnosticVirtualTextError   = { fg = palette.dark_red, bg = palette.none, bold = true },
    DiagnosticVirtualTextWarn    = { fg = palette.yellow, bg = palette.none, bold = true },
    DiagnosticVirtualTextInfo    = { fg = palette.sky, bg = palette.none },
    DiagnosticVirtualTextHint    = { fg = palette.teal, bg = palette.none },

    -- Underlines / Undercurls under problematic code
    DiagnosticUnderlineError     = { underline = true, sp = palette.dark_red },
    DiagnosticUnderlineWarn      = { underline = true, sp = palette.yellow },
    DiagnosticUnderlineInfo      = { underline = true, sp = palette.sky },
    DiagnosticUnderlineHint      = { underline = true, sp = palette.teal },

    -- Gutter Signs (Gutter icons on line numbers)
    DiagnosticSignError          = { fg = palette.dark_red, bg = palette.none },
    DiagnosticSignWarn           = { fg = palette.yellow, bg = palette.none },
    DiagnosticSignInfo           = { fg = palette.sky, bg = palette.none },
    DiagnosticSignHint           = { fg = palette.teal, bg = palette.none },

    -- Diagnostic Hover Popups
    DiagnosticFloatingError      = { fg = palette.dark_red },
    DiagnosticFloatingWarn       = { fg = palette.yellow },
    DiagnosticFloatingInfo       = { fg = palette.sky },
    DiagnosticFloatingHint       = { fg = palette.teal },

    -- Standard Vim Diff Groups
    DiffAdd                      = { fg = palette.green, bg = palette.none },
    DiffChange                   = { fg = palette.blue, bg = palette.none },
    DiffDelete                   = { fg = palette.red, bg = palette.none },
    DiffText                     = { fg = palette.yellow, bg = palette.none },

    -- ==========================================
    -- Plugins
    -- ==========================================
    -- Which-Key UI
    WhichKey                 = { fg = palette.blue, bold = true },
    WhichKeyGroup            = { fg = palette.pink },
    WhichKeySeparator        = { fg = palette.overlay0 },
    WhichKeyDesc             = { fg = palette.text },
    WhichKeyNormal           = { fg = palette.text, bg = palette.none },
    WhichKeyBorder           = { fg = palette.blue, bg = palette.none },
    WhichKeyTitle            = { fg = palette.mauve, bg = palette.none, bold = true },
    WhichKeyIcon             = { fg = palette.teal },
    WhichKeyValue            = { fg = palette.subtext0 },

    -- Telescope UI
    TelescopeNormal          = { fg = palette.text, bg = palette.none },
    TelescopeBorder          = { fg = palette.blue, bg = palette.none },
    TelescopePromptBorder    = { fg = palette.blue, bg = palette.none },
    TelescopeResultsBorder   = { fg = palette.blue, bg = palette.none },
    TelescopePreviewBorder   = { fg = palette.blue, bg = palette.none },

    -- Indent-Blankline
    IblIndent                = { link = "LineNr" },
    IblWhiteSpace            = { link = "LineNr" },

    -- Mini.completion Signature Hint
    MiniCompletionActiveParameter  = { underline = true, sp = palette.peach },

    -- Gitsigns SignColumn Highlights
    GitSignsAdd                    = { fg = palette.green, bg = palette.none },
    GitSignsChange                 = { fg = palette.blue, bg = palette.none },
    GitSignsDelete                 = { fg = palette.red, bg = palette.none },
    GitSignsChangedelete           = { fg = palette.peach, bg = palette.none },
    GitSignsTopdelete              = { fg = palette.red, bg = palette.none },
    GitSignsUntracked              = { fg = palette.teal, bg = palette.none },

    -- ===========================================
    -- NvimTree Sidebar Integration
    -- ===========================================
    -- Window & Background (Fully Transparent)
    NvimTreeNormal         = { fg = palette.text, bg = palette.none },
    NvimTreeNormalNC       = { fg = palette.text, bg = palette.none },
    NvimTreeWinSeparator   = { fg = palette.surface0, bg = palette.none },
    NvimTreeEndOfBuffer    = { fg = palette.none, bg = palette.none },

    -- Sidebar Cursor Bar
    -- Overrides the code editor's underline style with a clean selection bar in the tree
    NvimTreeCursorLine     = { fg = palette.mauve, bg = palette.surface0, bold = true },

    -- Root Header & Folders
    NvimTreeRootFolder     = { fg = palette.mauve, bold = true },
    NvimTreeFolderName     = { fg = palette.blue },
    NvimTreeFolderIcon     = { fg = palette.blue },
    NvimTreeOpenedFolderName = { fg = palette.lavender, bold = true },
    NvimTreeOpenedFolderIcon = { fg = palette.lavender },
    NvimTreeEmptyFolderName = { fg = palette.overlay0 },

    -- Tree Structure & Indentation Markers
    NvimTreeIndentMarker   = { fg = palette.surface2 },

    -- Special Files (e.g. Makefile, compile_commands.json)
    NvimTreeSpecialFile    = { fg = palette.yellow, bold = true },
    NvimTreeImageFile      = { fg = palette.pink },
    NvimTreeExecFile       = { fg = palette.green, bold = true },

    -- Git Status Indicators in File Tree
    NvimTreeGitDirty       = { fg = palette.peach },
    NvimTreeGitNew         = { fg = palette.green },
    NvimTreeGitDeleted     = { fg = palette.red },
    NvimTreeGitStaged      = { fg = palette.teal },
    NvimTreeGitMerge       = { fg = palette.flamingo },
    NvimTreeGitRenamed     = { fg = palette.mauve },

    -- ===========================
    -- LazyGit
    -- ===========================
    LazyGitFloat   = { fg = palette.text, bg = palette.none },
    LazyGitBorder  = { fg = palette.blue, bg = palette.none },
}

-- Apply highlights immediately when sourced
for group, settings in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, settings)
end
