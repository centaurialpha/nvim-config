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

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        local telescope_builtin = require("telescope.builtin")
        map("gd", telescope_builtin.lsp_definitions, "[G]oto [D]efinition")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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
      ruff_lsp = {},
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
        "ruff_lsp",
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
