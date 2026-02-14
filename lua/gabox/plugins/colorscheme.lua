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
    -- Treesitter context fix
    local bg = "#1a1a1a"

    vim.api.nvim_set_hl(0, "TreesitterContext", {
      bg = bg,
      underline = false,
    })

     vim.api.nvim_set_hl(0, "TreesitterContextBottom", {
       underline = true,
     })

    -- vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", {
    --   bg = bg,
    --   fg = "#6f8f7f",
    --   underline = false,
    -- })

    -- vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", {
    --   bg = bg,
    --   fg = "#6f8f7f",
    --   underline = false,
    -- })
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
