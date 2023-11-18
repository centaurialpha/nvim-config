local opt = vim.opt

opt.relativenumber = true
opt.number = true

opt.expandtab = true
opt.autoindent = true

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

opt.swapfile = false

opt.completeopt = { "menu", "menuone", "noselect" }

opt.foldlevel = 99
opt.foldlevelstart = -1
opt.foldenable = true
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- TODO: Cambio a 0 porque con 1 se muestra  el foldlevel y es feo
opt.foldcolumn = "0"
