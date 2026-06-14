local navic = require 'nvim-navic'

_G.NavicLocation = function() return navic.get_location() end

vim.o.winbar = '%{%v:lua.NavicLocation()%}'

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client and client:supports_method 'textDocument/documentSymbol' then navic.attach(client, ev.buf) end
  end,
})

local function apply_highlights()
  vim.api.nvim_set_hl(0, 'WinBar', { link = 'Normal' })
  vim.api.nvim_set_hl(0, 'WinBarNC', { link = 'Normal' })
end

apply_highlights()

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = apply_highlights,
})
