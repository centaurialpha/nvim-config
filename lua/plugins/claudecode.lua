require('claudecode').setup {
  terminal = { split_width_percentage = 0.4 },
}

local map = vim.keymap.set

map('n', '<leader>ac', '<cmd>ClaudeCode<cr>', { desc = '[A]I [c]laude toggle' })
map('n', '<leader>af', '<cmd>ClaudeCodeFocus<cr>', { desc = '[A]I [f]ocus' })
map('n', '<leader>ar', '<cmd>ClaudeCode --resume<cr>', { desc = '[A]I [r]esume session' })
map('n', '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', { desc = '[A]I add [b]uffer' })
map('v', '<leader>as', '<cmd>ClaudeCodeSend<cr>', { desc = '[A]I [s]end selection' })
map('n', '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', { desc = '[A]I [a]ccept diff' })
map('n', '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', { desc = '[A]I [d]eny diff' })
