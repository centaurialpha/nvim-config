-- Statusline
-- MIT License Copyright (c) 2024 Gabriel Acosta

local Statusline = {}
local H = {}

-- Show the mode in my custom component instead.
vim.o.showmode = false
-- Global status line
vim.o.laststatus = 3

local colors = {
  -- bg = "#201F30",
  -- fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
}

local modes = {
  ["n"] = "NO",
  ["no"] = "OP",
  ["nov"] = "OC",
  ["noV"] = "OL",
  ["no\x16"] = "OB",
  ["\x16"] = "VB",
  ["niI"] = "IN",
  ["niR"] = "RE",
  ["niV"] = "RV",
  ["nt"] = "NT",
  ["ntT"] = "TM",
  ["v"] = "VI",
  ["vs"] = "VI",
  ["V"] = "VL",
  ["Vs"] = "VL",
  ["\x16s"] = "VB",
  ["s"] = "SE",
  ["S"] = "SL",
  ["\x13"] = "SB",
  ["i"] = "IN",
  ["ic"] = "IC",
  ["ix"] = "IX",
  ["R"] = "RE",
  ["Rc"] = "RC",
  ["Rx"] = "RX",
  ["Rv"] = "RV",
  ["Rvc"] = "RC",
  ["Rvx"] = "RX",
  ["c"] = "CO",
  ["cv"] = "CV",
  ["r"] = "PR",
  ["rm"] = "PM",
  ["r?"] = "P?",
  ["!"] = "SH",
  ["t"] = "TE",
}

local colors_mode = {
  ["NO"] = colors.red,
  ["IN"] = colors.green,
  ["IC"] = colors.green,
  ["VI"] = colors.orange,
}

Statusline.setup = function(config)
  _G.Statusline = Statusline

  H.apply_config(config)
  H.setup_hl()
end

Statusline.mode = function()
  local current_mode = vim.fn.mode()
  return string.format(" [%%#Statusline_BlockMode#%s%%*] ", modes[current_mode])
end

Statusline.blocks = function()
  local color = colors_mode[modes[vim.fn.mode()]]
  vim.api.nvim_set_hl(0, "Statusline_BlockMode", { fg = color })
  return "%#Statusline_BlockMode#█%*"
end

Statusline.filename = function()
  local fname = vim.fn.expand("%:t")
  if fname == "" then
    return ""
  end
  return fname .. " %m%r "
end

Statusline.file_info = function()
  local filetype = vim.bo.filetype:upper()
  local encoding = vim.bo.fileencoding or vim.bo.encoding
  local format = vim.bo.fileformat
  return string.format(" %s %s[%s] ", filetype, encoding, format)
end

Statusline.location = function()
  return ' %l|%L│%2v|%-2{virtcol("$") - 1} '
end

Statusline.render = function()
  return table.concat({
    Statusline.blocks(),
    Statusline.mode(),
    Statusline.filename(),
    "%=%#StatusLineExtra#",
    Statusline.file_info(),
    Statusline.location(),
    Statusline.blocks(),
  })
end

H.apply_config = function(config) end

H.setup_hl = function() end
vim.go.statusline = "%!v:lua.Statusline.render()"
return Statusline
