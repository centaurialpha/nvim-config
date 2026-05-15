return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  -- opts = {},
  config = function()
    local fzf = require("fzf-lua")
    fzf.setup({
      defaults = {
        git_icons = false,
        file_icons = false,
        color_icons = false,
      },
    })
    -- Buffers
    vim.keymap.set("n", "<leader>b", fzf.buffers)
    vim.keymap.set("n", "<leader>sf", fzf.files, { desc = "[S]earch [F]iles" })
    -- Search
    vim.keymap.set("n", "<leader>sw", fzf.live_grep_native, { desc = "[S]earch by [G]rep" })
    -- Git
    vim.keymap.set("n", "<leader>gf", fzf.git_files)
    vim.keymap.set("n", "<leader>gs", fzf.git_status)
    vim.keymap.set("n", "<leader>gc", fzf.git_bcommits)
    vim.keymap.set("n", "<leader>ge", fzf.git_stash)

    vim.keymap.set("n", "<leader>sr", fzf.registers)
    vim.keymap.set("n", "<leader>ss", fzf.spell_suggest, { desc = "[S]pell [S]uggest" })

    vim.keymap.set("n", "<leader>sk", fzf.keymaps, { desc = "[S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>sh", fzf.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>s:", fzf.command_history, { desc = "[S]earch command history" })
  end,
}
