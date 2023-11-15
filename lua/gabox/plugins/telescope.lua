return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
          }
        },
        file_ignore_patterns = {
          "venv",
        },
      },
    })

    telescope.load_extension("fzf")

    vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
    vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<CR>")
  end,
}
