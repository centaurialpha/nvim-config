return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    scope = { enabled = false },
    indent = {
      char = "│",
      tab_char = "│",
    },
    exclude = {
      filetypes = {
        "help",
        "terminal",
        "lazy",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "mason",
        "nvdash",
        "nvcheatsheet",
        "",
      },
    },
  },
}
