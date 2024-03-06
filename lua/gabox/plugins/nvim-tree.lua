return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    local nvimtree = require("nvim-tree")
    nvimtree.setup({})
    vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>")
  end,
}
