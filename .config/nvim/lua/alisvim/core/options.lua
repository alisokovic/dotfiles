-- Options
local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 4           -- 4 spaces for tabs (prettier default)
opt.shiftwidth = 4        -- 4 spaces for indent width
opt.expandtab = true      -- expand tab to spaces
opt.autoindent = true     -- copy indent from current line when starting new one
opt.smartindent = true    -- smart auto-indent

opt.wrap = false          -- disable autowrapping

-- search settings
opt.ignorecase = true     -- ignore case when searching
opt.smartcase = true      -- if you include mixed case in your search, assumes you want case-sensitive
opt.hlsearch = true       -- highlight search matches
opt.incsearch = true      -- show matches as you type

opt.cursorline = true     -- highlight the row where cursor is

-- Aesthetics
opt.termguicolors = true  -- use terminal colors if exists
opt.background = "dark"   -- use the dark version of colorscheme
opt.signcolumn = "yes"    -- show signcolumn so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start"  -- allow backspace on indent, end of line, or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true     -- split vertical window to the right
opt.splitbelow = true     -- split horizontal window to the bottom

-- scrolloff
opt.scrolloff = 4
opt.sidescrolloff = 4

-- additional settings
opt.showmatch = true      -- show matching brackets
opt.encoding = "UTF-8"    -- set encoding
opt.fillchars = { eob = " " }   -- hide '~' on empty lines
