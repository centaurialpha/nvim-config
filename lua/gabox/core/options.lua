-- NOTE: Must happen before plugin are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

opt.number = true
opt.relativenumber = true

-- Don't show mode, since it's already in the status line
opt.showmode = false

opt.cmdheight = 0

-- Sync clipboard between OS and neovim
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)

opt.breakindent = true
opt.expandtab = true
opt.autoindent = true

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.undofile = true

opt.splitright = true
opt.splitbelow = true

opt.updatetime = 250

opt.swapfile = false

opt.completeopt = { "menu", "menuone", "noselect" }

-- Minimal number of screen lines to keep above and below the cursor
opt.scrolloff = 10

opt.foldlevel = 99
opt.foldlevelstart = -1
opt.foldenable = true
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- TODO: Cambio a 0 porque con 1 se muestra  el foldlevel y es feo
opt.foldcolumn = "0"

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
