return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      provider_selector = function(_, _, _)
        return { "treesitter", "indent" }
      end,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      auto_install = true,
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
    })
  end,
}
