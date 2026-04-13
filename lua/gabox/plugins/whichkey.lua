return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    delay = 500,
    icons = { mappings = false },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- Grupos para que el menú sea legible
    wk.add({
      { "<leader>s", group = "Search" },
      { "<leader>g", group = "Git" },
      { "<leader>d", group = "Document" },
      { "<leader>w", group = "Workspace" },
      { "<leader>l", group = "LSP/Format" },
      { "<leader>n", group = "Notifications" },
      { "<leader>t", group = "Terminal" },
      { "<leader>t", group = "Terminal/Translate" },
      { "<leader>x", group = "Trouble" },
      { "<leader>ss", desc = "Spell suggest" },
    })
  end,
}
