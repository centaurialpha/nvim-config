-- Statusline
-- MIT License Copyright (c) 2024 Gabriel Acosta

Statusline = {}

-- Show the mode in my custom component instead.
vim.o.showmode = false
-- Global status line
vim.o.laststatus = 3

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

Statusline.mode = function()
  local current_mode = modes[vim.fn.mode()]
  return string.format("[%%#StatuslineMode#%s%%*] ", current_mode)
end

Statusline.filename = function()
  local fname = vim.fn.expand("%:t")
  if fname == "" then
    return ""
  end
  return "%#StatuslineFileName#" .. fname .. "%*" .. " %m%r "
end

Statusline.lsp = function()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ""
  local warnings = ""
  local info = ""
  local hints = ""

  if count["errors"] ~= 0 then
    errors = " %#StatuslineLSPError#E:" .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    warnings = " %#StatuslineLSPWarn#W:" .. count["warnings"]
  end
  if count["info"] ~= 0 then
    info = " %#StatuslineLSPInfo#I:" .. count["info"]
  end
  if count["hints"] ~= 0 then
    hints = " %#StatuslineLSPHint#H:" .. count["hints"]
  end

  return errors .. warnings .. hints .. info .. "%* "
end

Statusline.git = function()
  local head = vim.b.gitsigns_head or "-"
  local signs = vim.b.gitsigns_status or ""
  return string.format("  %s %s ", head, signs)
end

Statusline.location = function()
  return "[%l:%v/%L]"
end

local get_size = function()
  local size = vim.fn.getfsize(vim.fn.getreg("%"))
  if size < 1024 then
    return string.format("%dB", size)
  elseif size < 1048576 then
    return string.format("%.2fKib", size / 1024)
  else
    return string.format("%.2fMiB", size / 1048576)
  end
end

Statusline.filetype = function()
  local filetype = "%#StatuslineFileType#" .. vim.bo.filetype:upper() .. "%*"
  local size = get_size()
  return string.format("%s (%s) ", filetype, size)
end

local colors = {
  blue = "#6495ED",
  light_blue = "#00FFFF",
  light_pink = "#FF69B4",
  strong_pink = "#FF1493",
  light_red = "#FF0000",
  light_green = "#00FF00",
  lime_green = "#32CD32",
  orange = "#FFA500",
}

local color_modes = {
  ["n"] = colors.blue,
  ["no"] = colors.light_blue,
  ["v"] = colors.light_pink,
  ["V"] = colors.strong_pink,
  [""] = colors.light_red,
  ["s"] = colors.light_green,
  ["S"] = colors.lime_green,
  [""] = colors.orange,
  ["i"] = colors.lime_green,
  ["ic"] = colors.lime_green,
  ["R"] = colors.orange,
  ["Rv"] = colors.strong_pink,
  ["c"] = colors.blue,
  ["cv"] = colors.light_pink,
  ["ce"] = colors.light_blue,
  ["r"] = colors.light_pink,
  ["rm"] = colors.light_green,
  ["r?"] = colors.lime_green,
  ["!"] = colors.light_red,
  ["t"] = colors.strong_pink,
}

local get_color_mode = function()
  local mode = vim.fn.mode()
  local color = color_modes[mode]
  return color
end

Statusline.render = function()
  -- Apply hl
  local hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
  vim.api.nvim_set_hl(0, "StatuslineFileType", { bold = true, italic = true, bg = hl.background })
  vim.api.nvim_set_hl(0, "StatuslineFileName", { link = "StatuslineFileType" })
  vim.api.nvim_set_hl(0, "StatuslineMode", { bold = true, fg = get_color_mode(), bg = hl.background })

  vim.api.nvim_set_hl(0, "StatuslineLSPWarn", { fg = "#ffb86c", bg = hl.background })
  vim.api.nvim_set_hl(0, "StatuslineLSPError", { fg = "#ff5555", bg = hl.background })
  vim.api.nvim_set_hl(0, "StatuslineLSPInfo", { fg = "#bd93f9", bg = hl.background })
  vim.api.nvim_set_hl(0, "StatuslineLSPHint", { fg = "#8be9fd", bg = hl.background })

  return table.concat({
    Statusline.mode(),
    Statusline.filename(),
    Statusline.lsp(),
    Statusline.git(),
    " ",
    "%=",
    Statusline.filetype(),
    Statusline.location(),
  })
end
vim.go.statusline = "%!v:lua.Statusline.render()"
return Statusline
