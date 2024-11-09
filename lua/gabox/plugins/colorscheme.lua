return {
  'projekt0n/github-nvim-theme',
  name = 'github-theme',
  lazy = false,
  priority = 1000,
  config = function()
    require("github-theme").setup({
      groups = {
        all = {
          StatusLine = { bg = "#000000" },
          CursorLine = { bg = "#191919" },
        }
      }
    })
    vim.cmd("colorscheme github_dark_default")
  end
}
