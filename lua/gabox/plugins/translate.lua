return {
  "uga-rosa/translate.nvim",
  config = function()
    require("translate").setup({
      default = {
        output = "replace"
      }
    })
  end
}
