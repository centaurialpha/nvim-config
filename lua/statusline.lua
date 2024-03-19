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
  return string.format("[%s] ", current_mode)
end

Statusline.filename = function()
  local fname = vim.fn.expand("%:t")
  if fname == "" then
    return ""
  end
  return fname .. " %m%r "
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
    errors = " E:" .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    warnings = " W:" .. count["warnings"]
  end
  if count["info"] ~= 0 then
    info = " I:" .. count["info"]
  end
  if count["hints"] ~= 0 then
    hints = " H:" .. count["hints"]
  end

  return errors .. warnings .. hints .. info .. " "
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
  local filetype = vim.bo.filetype:upper()
  local size = get_size()
  return string.format("%s (%s) ", filetype, size)
end

Statusline.render = function()
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
