return {
  "projekt0n/github-nvim-theme",
  lazy = false,
  priority = 1000,
  config = function()
    local groups = {
      all = {
        StatusLine = { bg = "bg0" },
        Whitespace = { fg = "#444444" },
      },
    }
    local specs = {
      all = {
        syntax = {
          -- type = "red",
        },
        bg1 = "#000000"
      },
    }
    require("github-theme").setup({ groups = groups, specs = specs })

    vim.cmd("colorscheme github_dark_colorblind")
  end,
}
