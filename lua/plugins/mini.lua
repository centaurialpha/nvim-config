require('mini.ai').setup {
  mappings = {
    around_next = 'aa',
    inside_next = 'ii',
  },
  n_lines = 500,
}

require('mini.surround').setup {}

-- require('mini.completion').setup {
--   delay = { completion = 100, info = 99999, signature = 99999 },
--     window = {
--     info      = { height = 10, width = 40, border = 'rounded' },
--     signature = { height = 6,  width = 40, border = 'rounded' },
--   },
--   lsk_completion = {
--     source_func = 'omnifunc',
--     auto_setup = true,
--   },
-- }
