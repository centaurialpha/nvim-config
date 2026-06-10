require('vim._core.ui2').enable {}
vim.loader.enable()

require 'config.options'
require 'config.keymaps'
require 'pack'
require 'blink'
require 'lsp'

require 'plugins.oil'
require 'plugins.treesitter'
require 'plugins.gitsigns'
require 'plugins.todo'
require 'plugins.mini'
require 'plugins.fzf'

vim.cmd.colorscheme 'moonfly'
