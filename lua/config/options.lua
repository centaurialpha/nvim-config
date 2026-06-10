vim.g.netrw_banner = 0

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.inccommand = "split"

vim.opt.splitbelow = true
vim.opt.splitright = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.laststatus = 3

vim.opt.swapfile = false
vim.opt.backup = false
 vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
-- Enable undo/redo changes even after closing and reopening a file
vim.opt.undofile = true

-- Sync clipboard between OS and Neovim
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)
vim.opt.isfname:append("@-@")
-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

vim.opt.colorcolumn = ""
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 0
vim.opt.termguicolors = true

vim.opt.cursorline = true

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    callback = function()
        vim.hl.on_yank()
    end,
})
