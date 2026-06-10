require('which-key').setup {
  delay = 800,
  icons = { mappings = false }, -- true si tenés Nerd Font
  spec = {
    { '<leader>s', group = '[S]earch' },
    { '<leader>f', group = '[F]ind' },
    { '<leader>d', group = '[D]elete' },
  },
}
