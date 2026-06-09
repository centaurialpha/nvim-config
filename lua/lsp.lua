require("mason").setup()

require("mason-tool-installer").setup({
  ensure_installed = {
    "lua_ls",
    "pyright",
  },
})

require("mason-lspconfig").setup({
  automatic_enable = false,
})

vim.lsp.config("lua_ls", {
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

vim.lsp.config('pyright', {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = 'basic',
      },
    },
  },
})

vim.lsp.enable({ 'lua_ls', 'pyright' })

vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = false,
  float = { border = 'rounded', source = 'if_many' },
  underline = true,
  virtual_text = false,
  virtual_lines = { current_line = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = 'E',
      [vim.diagnostic.severity.WARN]  = 'W',
      [vim.diagnostic.severity.INFO]  = 'I',
      [vim.diagnostic.severity.HINT]  = 'H',
    },
  },
})

-- Keymaps al adjuntar el servidor
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local buf = args.buf
    local map = function(m, lhs, rhs, desc)
      vim.keymap.set(m, lhs, rhs, { buffer = buf, desc = desc })
    end
    map('n', 'K', vim.lsp.buf.hover, 'LSP Hover')
    map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
    map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
    map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
    map('n', 'gr', vim.lsp.buf.references, 'References')
    map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename')
    map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
    map('n', 'gl', vim.diagnostic.open_float)
    map('n', '<leader>f', function()
      vim.lsp.buf.format({ async = true })
    end, 'Format')
  end,
})

-- Diagnósticos
vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = false,
  float = { border = 'rounded', source = 'if_many', wrap = true },
  underline = true,
  virtual_text = false,
  virtual_lines = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = 'E',
      [vim.diagnostic.severity.WARN]  = 'W',
      [vim.diagnostic.severity.INFO]  = 'I',
      [vim.diagnostic.severity.HINT]  = 'H',
    },
  },
})
