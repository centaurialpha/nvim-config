return {
  "SmiteshP/nvim-navic",
  config = function()
    vim.o.statusline = "%{%v:lua.require'nvim-navic'.get_location()%}"
    vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
  end,
}
