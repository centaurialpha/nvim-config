return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "williamboman/mason.nvim",
      config = true
    },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
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
        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map("gd", telescope_builtin.lsp_definitions, "[G]oto [D]efinition")
        -- Find references for the word under cursor.
        map("gr", telescope_builtin.lsp_references, "[G]oto [R]eferences")
        -- Jump to implementation of the word under cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map("gI", telescope_builtin.lsp_implementations, "[G]oto [I]mplementation")
        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map("<leader>D", telescope_builtin.lsp_type_definitions, "Type [D]efinition")
        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map("<leader>ds", telescope_builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map("<leader>ws", telescope_builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
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
