return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    vim.diagnostic.config({
      virtual_text = false,
    })
    local lspconfig = require("lspconfig")
    local navic = require("nvim-navic")

    local on_attach = function(client, bufnr)

      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end

      vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
      vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, { buffer = bufnr })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })
      vim.keymap.set("n", "<leader>df", vim.diagnostic.goto_next, { buffer = bufnr })
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    require("mason").setup()
    require("mason-lspconfig").setup()

    lspconfig.pyright.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.ruff_lsp.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            checkThirdParty = false,
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
          telemetry = { enable = false },
        },
      },
    })
  end,
}
