return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = {
        "lua",
        "astro",
        "tsx",
        "typescript",
        "html",
        "python",
        "c",
        "cpp",
        "yaml",
        "json",
        "dockerfile",
        "bash",
        "markdown",
        "rust",
        "toml",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      auto_install = true,
    })
  end,
}
