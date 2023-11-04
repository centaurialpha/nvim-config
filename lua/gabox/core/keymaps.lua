local toggle_diagnostics = function()
  vim.diagnostic.config({
    virtual_text = false,
    underline = true,
  })
end

vim.keymap.set("n", "ud", toggle_diagnostics)
