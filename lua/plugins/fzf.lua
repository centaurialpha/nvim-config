require('fzf-lua').setup {
  winopts = { border = 'rounded', preview = { border = 'rounded' } },
}

vim.keymap.set('n', '<leader>ff', require('fzf-lua').files, { desc = '[F]ind [f]iles' })
vim.keymap.set('n', '<leader>sw', require('fzf-lua').live_grep, { desc = '[S]earch [w]ord' })
