vim.g.mapleader = " "

-- delete text without saving to any register
-- vim.keymap.set({ "n", "x" }, "<leader>d", [["_d]], { desc = "delete without yanking" })

vim.keymap.set("n", "<leader>nh", ":nohl<cr>", { desc = "clear search highlights" })

-- window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<CR>")
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<CR>")
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

vim.keymap.set({"n", "t"}, "<C-h>", "<cmd>wincmd h<CR>", { desc = "Move to the left window" })
vim.keymap.set({"n", "t"}, "<C-l>", "<cmd>wincmd l<CR>", { desc = "Move to the right window" })
vim.keymap.set({"n", "t"}, "<C-k>", "<cmd>wincmd k<CR>", { desc = "Move to the upper window" })
vim.keymap.set({"n", "t"}, "<C-j>", "<cmd>wincmd j<CR>", { desc = "Move to the lower window" })

vim.keymap.set("n", "<leader>wo", "<cmd>tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>wx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>wn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
vim.keymap.set("n", "<leader>wp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
vim.keymap.set("n", "<leader>wf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

---- Node Selection (Increment/Decrement) ----
vim.keymap.set("n", "<Tab>", "van", { remap = true, desc = "Init TS selection" })
vim.keymap.set("x", "<Tab>", "an", { remap = true, desc  = "Expand TS selection" })
vim.keymap.set("x", "<bs>", "in", { remap = true, desc = "Shrink TS selection" })

-- I use mini.move for this from now on
-- vim.keymap.set("v", "<M-Down>", ":m '>+1<cr>gv=gv", { desc = "move selected lines down" })
-- vim.keymap.set("v", "<M-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

vim.keymap.set("x", "<", "<gv", { desc = "Unindent and keep selection" })
vim.keymap.set("x", ">", ">gv", { desc = "Indent and keep selection" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving the cursor" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move up in buffer with cursor centered" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result is cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result is cursor centered" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor is on globally" })

-- Clear qflist and loclist
vim.keymap.set("n", "<leader>qc", function()
    vim.fn.setqflist({})
    vim.notify("Quickfix list cleared", vim.log.levels.INFO)
end, { desc = "Clear quickfix list"})

vim.keymap.set("n", "<leader>lc", function()
    vim.fn.setloclist(0, {})
    vim.notify("location list cleared", vim.log.levels.INFO)
end, { desc = "Clear loclist"})

-- native undotree
vim.keymap.set("n", "<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    require("undotree").open()
end, { desc = "Toggle built-in undotree" })
