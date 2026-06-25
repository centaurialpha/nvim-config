require('conform').setup {
  formatters_by_ft = {
    python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
    javascript = { 'prettierd' },
    typescript = { 'prettierd' },
    javascriptreact = { 'prettierd' },
    typescriptreact = { 'prettierd' },
    json = { 'prettierd' },
    css = { 'prettierd' },
    html = { 'prettierd' },
  },
}

vim.keymap.set(
  { 'n', 'v' },
  '<leader>f',
  function()
    require('conform').format {
      async = true,
      lsp_format = 'fallback',
    }
  end,
  { desc = 'Format buffer' }
)
