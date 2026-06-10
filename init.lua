require('vim._core.ui2').enable {}
vim.loader.enable()

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'

require 'pack'

require 'plugins.oil'
require 'plugins.treesitter'
require 'plugins.gitsigns'
require 'plugins.todo'
require 'plugins.mini'
require 'plugins.fzf'
require 'plugins.which-key'

require 'blink'
require 'lsp'

require 'statusline'

vim.cmd.colorscheme 'moonfly'
