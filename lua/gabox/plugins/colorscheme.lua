return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors)
        return {
          CursorLine = { bg = "#242430" },
        }
      end
    })
    vim.cmd("colorscheme kanagawa-wave")
  end,
}
