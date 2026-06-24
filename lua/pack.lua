local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'bluz71/vim-moonfly-colors',
  gh 'stevearc/oil.nvim',
  gh 'lewis6991/gitsigns.nvim',
  gh 'ibhagwan/fzf-lua',
  gh 'NMAC427/guess-indent.nvim',
  gh 'folke/todo-comments.nvim',
  gh 'nvim-mini/mini.nvim',
  { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' },
  -- LSP
  gh 'mason-org/mason.nvim',
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',

  gh 'saghen/blink.lib',
  gh 'saghen/blink.cmp',

  gh 'folke/which-key.nvim',

  gh 'SmiteshP/nvim-navic',

  gh 'stevearc/conform.nvim',
}

require('guess-indent').setup {}
