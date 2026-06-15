require('mini.ai').setup {
  mappings = {
    around_next = 'aa',
    inside_next = 'ii',
  },
  n_lines = 500,
}

require('mini.surround').setup()
require('mini.pairs').setup()
require('mini.comment').setup()

require('mini.git').setup()

require('mini.indentscope').setup()
