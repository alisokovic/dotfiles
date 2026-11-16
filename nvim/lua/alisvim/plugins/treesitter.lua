vim.pack.add({
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/windwp/nvim-ts-autotag",
})

local treesitter = require("nvim-treesitter")

local ensure_installed = {
    "html",
    "json",
    "css",
    "make",
    "markdown",
    "markdown_inline",
    "yaml",
    "latex",
    "lua",
    "vim",
    "git_config",
    "gitcommit",
    "gitignore",
    "vimdoc",
    "bash",
    "c",
    "cpp",
    "doxygen",
    "python",
    "rust",
    "dockerfile",
}

local installed = require("nvim-treesitter.config").get_installed()
local to_install = vim.tbl_filter(function(lang)
    return not vim.tbl_contains(installed, lang)
end, ensure_installed)

if #to_install > 0 then
    treesitter.install(to_install)
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(args)
		local buf = args.buf
		local ft = vim.bo[buf].filetype

		local lang = vim.treesitter.language.get_lang(ft)
		if not lang then
			return
		end

		local ok_add = pcall(vim.treesitter.language.add, lang)
		if not ok_add then
			return
		end

		pcall(vim.treesitter.start, buf, lang)
	end,
})

require("nvim-ts-autotag").setup({
    opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
    },
})
