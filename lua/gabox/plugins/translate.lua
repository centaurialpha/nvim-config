return {
  "uga-rosa/translate.nvim",
  config = function()
    require("translate").setup({
      default = {
        output = "replace",
      },
    })
    vim.keymap.set("n", "<leader>tr", "<cmd>Translate EN<cr>", { desc = "[T]ranslate to English" })
    vim.keymap.set("v", "<leader>tr", "<cmd>Translate EN<cr>", { desc = "[T]ranslate to English" })
    vim.keymap.set("n", "<leader>tR", "<cmd>Translate ES<cr>", { desc = "[T]ranslate to Spanish" })
    vim.keymap.set("v", "<leader>tR", "<cmd>Translate ES<cr>", { desc = "[T]ranslate to Spanish" })
  end,
}
