return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    local nvimtree = require("nvim-tree")
    nvimtree.setup({})
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
  end
}
