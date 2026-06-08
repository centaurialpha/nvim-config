vim.pack.add({
    "https://github.com/bluz71/vim-moonfly-colors",
    "https://github.com/stevearc/oil.nvim",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/NMAC427/guess-indent.nvim",
    "https://github.com/folke/todo-comments.nvim",
    "https://github.com/nvim-mini/mini.nvim",
    "https://github.com/sschleemilch/slimline.nvim",
})

require("guess-indent").setup {}
