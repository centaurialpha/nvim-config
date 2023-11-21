vim.api.nvim_set_hl(0, "IndentBlanklineIndent", { fg = "#2c2c39" })

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    require("ibl").setup({
      scope = { enabled = false },
      indent = {
        highlight = {
          "IndentBlanklineIndent",
        },
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
    })
  end,
}
