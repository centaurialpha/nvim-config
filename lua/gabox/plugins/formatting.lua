return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black", "usort", "ruff" },
        json = { "prettier" },
        rust = { "rustfmt" },
        astro = { "prettier" },
        javascriptreact = { "prettier" },
        javascript = { "prettier" },
        c = { "clang-format", "ast-grep" },
        cpp = { "clang-format" },
        go = { "gofmt" }
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>lf", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end)
  end,
}
