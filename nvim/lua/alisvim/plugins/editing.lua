vim.pack.add({
    "https://github.com/numtostr/comment.nvim",
    "https://github.com/abecodes/tabout.nvim",
    "https://github.com/wansmer/treesj",
    "https://github.com/folke/todo-comments.nvim",
    "https://github.com/danymat/neogen",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

---- Comment ----
require("Comment").setup()

---- TabOut ----
require("tabout").setup({
    ignore_beginning = false,
})

---- TreeSJ ----
local tsj = require("treesj")
tsj.setup({
    use_default_keymaps = false,
    max_join_length = 100,
})

-- Keymaps attached only when an LSP connects to buffer
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local map = function(mode, lfs, rhs, desc)
            vim.keymap.set(mode, lfs, rhs, { buffer = ev.buf, desc = desc })
        end

        map("n", "<leader>m", tsj.toggle, "Toggle split/join")
        map("n", "<leader>M", function()
            tsj.toggle({ split = { recursive = true } })
        end, "Toggle split/join recursively")
    end
})

---- Todo Comments ----
require("todo-comments").setup()

-- TODO: todo comment
-- HACK: hack comment
-- BUG: bug comment
-- PERF: perf comment
-- NOTE: note comment

---- Neogen ----
local neogen = require("neogen")
neogen.setup({
    enabled = true,
    languages = {
        lua = { template = { annotation_convention = "emmylua" } },
        c = { template = { annotation_convention = "doxygen" } },
        cpp = { template = { annotation_convention = "doxygen" } },
        python = { template = { annotation_convention = "google_docstrings" } },
        sh = { template = { annotation_convention = "google_bash" } },
    },
})

-- Keymap to generate annotation for function/class under cursor
vim.keymap.set("n", "<leader>kc", function()
    neogen.generate()
end, { desc = "Generate neogen documentation" })

-- Keymap to generate full file-level annotation
vim.keymap.set("n", "<leader>kf", function()
    neogen.generate({ type = "file" })
end, { desc = "Generate file doc header" })

---- Render Markdown ----
require("render-markdown").setup({
    completions = {
        lsp = { enabled = true },
    },
})
