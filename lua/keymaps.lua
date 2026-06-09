vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Replace selected text without losing what you yanked
vim.keymap.set("x", "p", [["_dP]], { desc = "Paste over selection without losing yanked text" })
-- Delete text without saving it to any register
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], { desc = "Delete without yanking" })

vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- FZF
vim.keymap.set("n", "<leader>ff", function()
    require("fzf-lua").files()
end, { desc = "[F]ind [f]iles" })

vim.keymap.set("n", "<leader>sw", function()
    require("fzf-lua").live_grep()
end, { desc = "[S]earch [w]ord" })

-- vim.api.nvim_create_autocmd("LspAttach", {
--     callback = function(args)
--         local bufnr = args.buf
--         local map = function(mode, lhs, rhs, desc)
--             vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
--         end
--         
--         map("n", "<leader>k", vim.lsp.buf.hover, "LSP Hover")
--     end,
-- })

vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, { desc = "LSP hover" })
