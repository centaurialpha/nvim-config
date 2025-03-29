return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "williamboman/mason.nvim",
      config = true
    },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "saghen/blink.cmp"
  },
  config = function()
    vim.diagnostic.config({
      virtual_text = false,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        local fzf = require("fzf-lua")
        map("gd", fzf.lsp_definitions, "[G]oto [D]efinition")
        map("gr", fzf.lsp_references, "[G]oto [R]eferences")
        map("gI", fzf.lsp_implementations, "[G]oto [I]mplementation")
        map("<leader>D", fzf.lsp_typedefs, "Type [D]efinition")
        map("<leader>ds", fzf.lsp_document_symbols, "[D]ocument [S]ymbols")
        map("<leader>ws", fzf.lsp_workspace_symbols, "[W]orkspace [S]ymbols")
        map("<leader>ca", fzf.lsp_code_actions, "[C]ode [A]ctions")
        map("gD", fzf.lsp_declarations, "[G]oto [D]eclaration")
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      end,
    })

    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- FIXME: Mejorar ésto
    local navic = require("nvim-navic")
    local on_attach_navic = function(client, bufnr)
      navic.attach(client, bufnr)
    end

    local servers = {
      clangd = {
        on_attach = on_attach_navic,
      },
      astro = {},
      rust_analyzer = {
        on_attach = on_attach_navic,
      },
      pyright = {
        on_attach = on_attach_navic,
      },
      gopls = {},
      ruff = {},
      make = {},
      lua_ls = {
        on_attach = on_attach_navic,
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
      },
    }
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "pyright",
        "ruff",
        "dockerls",
        "docker_compose_language_service"
      },
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })
  end,
}
