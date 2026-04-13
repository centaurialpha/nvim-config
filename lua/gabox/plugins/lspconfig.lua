return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "saghen/blink.cmp",
  },
  config = function()
    vim.diagnostic.config({ virtual_text = false })

    -- Capabilities globales para todos los servidores
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    -- Configuraciones específicas por servidor
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
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

    -- ty no está en lspconfig aún, lo definimos manualmente
    vim.lsp.config("ty", {
      cmd = { "ty", "server" },
      filetypes = { "python" },
      root_markers = { "pyproject.toml", "uv.lock", "setup.py", ".git" },
    })
    vim.lsp.enable("ty")

    -- Keymaps en LspAttach
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, event.buf)
        end

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

    require("mason").setup()

    -- mason-tool-installer instala ty (mason-lspconfig no lo reconoce aún)
    require("mason-tool-installer").setup({
      ensure_installed = { "ty", "stylua", "ruff", "taplo", "shfmt", "goimports", "shellcheck" },
    })

    -- mason-lspconfig v2: sin handlers, automatic_enable se encarga solo
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "ruff",
        "dockerls",
        "docker_compose_language_service",
        "gopls",
        "clangd",
        "ts_ls",
        "bashls",
        "yamlls",
        "taplo",
      },
      automatic_enable = {
        exclude = { "ty" }, -- ty lo habilitamos manualmente arriba
      },
    })
  end,
}
