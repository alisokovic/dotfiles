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
        local hl = vim.api.nvim_get_hl(0, { name = "lualine_a_" .. lualine_mode, link = false})

        if hl and hl.bg then
            vim.api.nvim_set_hl(0, "CursorLineNr", { fg = hl.bg, bold = true })
            vim.api.nvim_set_hl(0, "CursorLine", { underline = true, sp = hl.bg, bg = "NONE" })
        end
    end,
})
