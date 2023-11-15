return {
  "mvllow/modes.nvim",
  config = function()
    require("modes").setup({
      colors = {
        delete = "#E82424",
        insert = "#FF9E3B",
      }
    })
  end
}
