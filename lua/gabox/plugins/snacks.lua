return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    { "<leader>z", function() Snacks.zen() end,      desc = "Zen mode" },
    { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Toggle zoom" },
  },
  ---@type snacks.Config
  opts = {
    indent = { enabled = false },
    zen = {},
    scroll = {},
  }
}
