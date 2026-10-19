-- Enable soft wrapping
vim.opt_local.wrap = true

-- Break lines at word boundaries instead of mid-word
vim.opt_local.linebreak = true

-- Wrap visually at 80 colums
vim.opt_local.textwidth = 80
vim.opt_local.wrapmargin = 0
vim.opt_local.formatoptions:remove({ "t", "a" })  -- Prevent hard wrapping while typing

-- Maintain indentation on wrapped lines
vim.opt_local.breakindent = true
