return {
  "zenbones-theme/zenbones.nvim",
  lazy = false,
  dependencies = "rktjmp/lush.nvim",
  priority = 1000,
  config = function()
    vim.g.zenbones = { darkness = "stark" }

    vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#171717" })
    vim.cmd("colorscheme zenbones")

    -- local lush = require "lush"
    -- local base = require "zenbones"

    -- -- Create some specs
    -- local specs = lush.parse(function()
    --   return {
    --     Normal { bg = "#171210" },
    --     CursorLine { bg = "#171717"}
    --   }
    -- end)
    -- -- Apply specs using lush tool-chain
    -- lush.apply(lush.compile(specs))
  end
}
