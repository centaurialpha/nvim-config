require('fzf-lua').setup {
  winopts = { border = 'rounded', preview = { border = 'rounded' } },
}

vim.keymap.set('n', '<leader>ff', require('fzf-lua').files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>sw', require('fzf-lua').live_grep, { desc = 'Search word' })
vim.keymap.set('n', '<leader>fb', require('fzf-lua').buffers, { desc = 'Find buffers' })
