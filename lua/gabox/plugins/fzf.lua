return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  dependencies = { "echasnovski/mini.icons" },
  opts = {},
  config = function()
    local fzf = require("fzf-lua")
    vim.keymap.set("n", "<leader>sf", fzf.files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>sw", fzf.live_grep, { desc = "[S]earch by [G]rep" })
    -- FIXME: mover a lspconfig?
    vim.keymap.set("n", "gd", fzf.lsp_definitions, { desc = "[G]oto [D]efinition" })
    vim.keymap.set("n", "gs", fzf.lsp_document_symbols)
  end
}
