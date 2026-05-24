vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
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
    "lua",
    "vim",
    "git_config",
    "gitcommit",
    "gitignore",
    "vimdoc",
    "bash",
    "c",
    "cpp",
    "python",
    "rust",
    "dockerfile",
}

treesitter.install(ensure_installed)

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
    enable = true,
})
