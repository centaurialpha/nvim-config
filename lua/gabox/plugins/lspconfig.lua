return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")

    local on_attach = function(_, bufnr)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
      vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, { buffer = bufnr })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })
      vim.keymap.set("n", "<leader>df", vim.diagnostic.goto_next, { buffer = bufnr })
    end

    require("mason").setup()
    require("mason-lspconfig").setup()

    lspconfig.pyright.setup({
      on_attach = on_attach,
    })

    lspconfig.lua_ls.setup({
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
  end
}
