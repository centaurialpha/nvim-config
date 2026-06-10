local cmp = require 'blink.cmp'
cmp.build():pwait()
cmp.setup {
  keymap = { preset = 'default' },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 200 },
    menu = { border = 'rounded' },
  },
  signature = { enabled = true },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
}
