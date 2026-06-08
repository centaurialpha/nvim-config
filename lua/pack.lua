local function gh(repo) return "https://github.com/" .. repo end

vim.pack.add {
    gh "bluz71/vim-moonfly-colors",
    gh "stevearc/oil.nvim",
    gh "lewis6991/gitsigns.nvim",
    gh "ibhagwan/fzf-lua",
    gh "NMAC427/guess-indent.nvim",
    gh "folke/todo-comments.nvim",
    gh "nvim-mini/mini.nvim",
    gh "sschleemilch/slimline.nvim",
    { src = gh "nvim-treesitter/nvim-treesitter", version = "main" },
}

require("guess-indent").setup {}
