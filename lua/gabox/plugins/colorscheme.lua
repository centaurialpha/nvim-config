return {
  "projekt0n/github-nvim-theme",
  lazy = false,
  priority = 1000,
  config = function()
    local groups = {
      all = {
        StatusLine = { bg = "bg0" },
      },
    }
    require("github-theme").setup({ groups = groups })
    vim.cmd("colorscheme github_dark_colorblind")
  end,
}
