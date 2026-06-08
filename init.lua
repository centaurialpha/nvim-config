require("vim._core.ui2").enable({})

vim.loader.enable()

require("options")
require("pack")

-- All plugins
require("plugins.oil")
require("plugins.treesitter")
require("plugins.gitsigns")
require("plugins.todo")
require("plugins.mini")
require("plugins.slimline")

require("keymaps")

vim.cmd.colorscheme("moonfly")
