vim.g.netwr_banner = 0

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.cursorline = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.inccommand = "split"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.laststatus = 3

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

vim.opt.completeopt = "menuone,noselect,fuzzy,nosort"
vim.opt.shortmess:append("c")
vim.opt.clipboard:append("unnamedplus")
vim.opt.isfname:append("@-@")
vim.opt.guicursor = "n-v-c-i:block"
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4

vim.opt.colorcolumn = "0"
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 0
vim.opt.termguicolors = true
vim.opt.fillchars = { eob = " " }

---- Autocmds ----
-- Highlight selection on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ timeout = 250, visual = true })
    end,
})

-- Open help pages in vertical split
vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    command = "wincmd L",
})

-- Auto resize splits when terminal window is resized
vim.api.nvim_create_autocmd("VimResized", {
    command = "wincmd ="
})

-- No auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("no_auto_comment", {}),
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- syntax highlighting for dotenv files
vim.api.nvim_create_autocmd("BufRead", {
    group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
    pattern = { ".env", ".env.*" },
    callback = function()
        vim.bo.filetype = "dosini"
    end,
})

-- Show cursorline only in active window
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter"}, {
    group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
    callback = function()
        vim.opt_local.cursorline = true
    end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave"}, {
    group = "active_cursorline",
    callback = function()
        vim.opt_local.cursorline = false
    end,
})
