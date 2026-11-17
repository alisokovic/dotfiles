-- Helper function to create augroup
local function augroup(name)
    return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Highlight selection on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    pattern = "*",
    callback = function()
        vim.hl.on_yank({ timeout = 250, visual = true })
    end,
})

-- Open help pages in vertical split
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("vertical_help"),
    pattern = "help",
    command = "wincmd L",
})

-- Auto resize splits when terminal window is resized
vim.api.nvim_create_autocmd("VimResized", {
    group = augroup("resize_splits"),
    callback = function()
        local tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. tab)
    end,
})

-- No auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("no_auto_comment"),
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- syntax highlighting for dotenv files
vim.api.nvim_create_autocmd("BufRead", {
    group = augroup("dotenv_ft"),
    pattern = { ".env", ".env.*" },
    callback = function()
        vim.bo.filetype = "dosini"
    end,
})

-- Show cursorline only in active window
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter"}, {
    group = augroup("active_cursorLine"),
    callback = function()
        vim.opt_local.cursorline = true
    end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave"}, {
    group = "user_active_cursorLine",
    callback = function()
        vim.opt_local.cursorline = false
    end,
})

-- Reload file changes outside nvim (git checkout, formatters)
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})

-- Close throwaway windows with `q`
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = { "help", "qf", "man", "checkhealth", "query", "startuptime" },
    callback = function(ev)
        vim.bo[ev.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true })
    end,
})

-- Custom command to clear caches
vim.api.nvim_create_user_command("ClearCaches", function ()
    vim.cmd("clearjumps")
    vim.cmd("delmarks! | delmarks A-Z0-9")
    vim.fn.setqflist({}, "f")
    for _, w in ipairs(vim.api.nvim_list_wins()) do
        vim.fn.setloclist(w, {}, "f")
    end
    vim.fn.histdel(":"); vim.fn.histdel("/"); vim.fn.setreg("/", "")
    vim.v.oldfiles = {}
    vim.cmd("wshada!")  -- overwrite the shada file instead of merging it
end, {})
