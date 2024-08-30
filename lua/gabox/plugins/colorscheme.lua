return {
  "zenbones-theme/zenbones.nvim",
  lazy = false,
  dependencies = "rktjmp/lush.nvim",
  priority = 1000,
  config = function()
    vim.g.zenbones = { darkness = "stark" }
    vim.cmd("colorscheme zenbones")
  end
}
