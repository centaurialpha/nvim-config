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
      ensure_installed = {
        "lua",
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
