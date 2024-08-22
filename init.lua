-- Options
-- Keymaps
-- Autocmds
require "gabox.core"

-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- My custom status line
require("statusline")

-- Plugins
require("lazy").setup({
  -- tabstop and shiftwidh automático
  "tpope/vim-sleuth",

  "nvim-tree/nvim-web-devicons",

  { import = "gabox.plugins" },
}, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
