return {
  'ribru17/bamboo.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('bamboo').setup {
      -- optional configuration here
      style = "vulgaris",
      colors = {
        bg0 = "#111111"
      }
    }
    require('bamboo').load()
  end,
  -- 'projekt0n/github-nvim-theme',
  -- name = 'github-theme',
  -- lazy = false,
  -- priority = 1000,
  -- config = function()
  --   require("github-theme").setup({
  --     groups = {
  --       all = {
  --         StatusLine = { bg = "#000000" },
  --         CursorLine = { bg = "#191919" },
  --       }
  --     }
  --   })
  --   vim.cmd("colorscheme github_dark_default")
  -- end
}
