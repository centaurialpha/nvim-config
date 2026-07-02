require('mason').setup()

require('mason-tool-installer').setup {
  ensure_installed = {
    'lua_ls',
    'ruff',
    'dockerls',
    'docker_compose_language_service',
    'bashls',
    'yamlls',

    'stylua',
    'shfmt',
    'shellcheck',

    'vtsls',
    'eslint',
    'html',
    'cssls',
    'tailwindcss',
    'prettierd',

    'jsonls',
    'emmet_language_server',
    'marksman',
  },
}

require('mason-lspconfig').setup {
  automatic_enable = {
    exclude = { 'ty', 'ruff' },
  },
}

vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

-- capabilities globales (cuando agregues autocomplete va acá)
-- vim.lsp.config('*', {
--   capabilities = vim.lsp.protocol.make_client_capabilities(),
-- })

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          '${3rd}/luv/library',
        },
      },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config('ruff', {
  settings = {
    ruff = {
      lint = {
        select = { 'E', 'F', 'I', 'N', 'W' },
      },
    },
  },
})
vim.lsp.enable 'ruff'

-- ty: type checker de Astral (reemplaza pyright)
-- no está en mason-lspconfig todavía, config manual completa
vim.lsp.config('ty', {
  cmd = { 'ty', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'uv.lock', 'setup.py', '.git' },
})
vim.lsp.enable 'ty'

-- Keymaps al adjuntar el servidor
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local buf = args.buf
    vim.lsp.inlay_hint.enable(true, { bufnr = buf })
    local map = function(m, lhs, rhs, desc) vim.keymap.set(m, lhs, rhs, { buffer = buf, desc = desc }) end
    map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
    map('n', 'K', vim.lsp.buf.hover, 'LSP Hover')
    map('n', 'gl', vim.diagnostic.open_float, 'Diagnostics float')
    map('n', '<leader>r', vim.lsp.buf.rename, 'Rename')
    -- map('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, 'Format')
  end,
})

-- Diagnósticos
vim.diagnostic.config {
  severity_sort = true,
  update_in_insert = false,
  float = { border = 'rounded', source = 'if_many', wrap = true },
  underline = true,
  virtual_text = { spacing = 2, source = 'if_many' },
  virtual_lines = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = 'E',
      [vim.diagnostic.severity.WARN] = 'W',
      [vim.diagnostic.severity.INFO] = 'I',
      [vim.diagnostic.severity.HINT] = 'H',
    },
  },
}
