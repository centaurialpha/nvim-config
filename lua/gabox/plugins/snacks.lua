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
    dashboard = {
      enabled = true,
      preset = {
        keys = {},
        footer = function() return {} end,
        header = [[
qué onda
        ]]
      },
    },
    indent = { enabled = false },
    zen = {},
    scroll = {},
  }
}
