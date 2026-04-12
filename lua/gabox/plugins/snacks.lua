return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Zen mode",
    },
    {
      "<leader>Z",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Toggle zoom",
    },
    {
      "<leader>lg",
      function()
        Snacks.lazygit()
      end,
      desc = "LazyGit",
    },
    {
      "<leader>tf",
      function()
        Snacks.terminal.toggle()
      end,
      desc = "Toggle terminal",
    },
  },
  ---@type snacks.Config
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        keys = {},
        footer = function()
          return {}
        end,
        header = [[
qué onda
        ]],
      },
    },
    indent = { enabled = false },
    zen = {},
    scroll = {},
    words = { enabled = true },
    terminal = {},
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    input = { enabled = true },
    picker = { enabled = true },
  },
}
