local cmp = require 'blink.cmp'
-- Build async: tras cada update de blink.cmp el build con cargo tarda minutos.
-- Mientras compila se usa el fuzzy en Lua; al reiniciar ya carga el de Rust.
cmp.build()
cmp.setup {
  keymap = { preset = 'default' },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 200 },
    menu = { border = 'none' },
  },
  signature = { enabled = true },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
}
