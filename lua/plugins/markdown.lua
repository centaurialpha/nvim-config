require('render-markdown').setup {
  heading = {
    width = 'block',
    border_prefix = true,
  },
  pipe_table = {
    preset = 'round',
    cell = 'trimmed',
  },
  latex = { enabled = false },
}

-- Con wrap activo las tablas anchas se cortan (limitación de Neovim con conceal).
-- Toggle para leer tablas sin wrap y scrollear horizontal con zl/zh.
vim.o.sidescroll = 1
vim.keymap.set('n', '<leader>mw', function() vim.wo.wrap = not vim.wo.wrap end, { desc = '[M]arkdown toggle [w]rap' })
