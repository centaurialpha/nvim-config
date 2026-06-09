local M = {}

vim.api.nvim_set_hl(0, 'StatuslineBase', { fg = '#ffffff', bg = 'NONE' })



local mode_colors = {
  n = '#ffb300',
  i = '#33ff00',
  v = '#ff6600',
  V = '#ff6600',
  R = '#ff0000',
  c = '#33ff00',
  t = '#ffb300',
}
local mode_labels = {
  n = 'N',
  i = 'I',
  v = 'V',
  V = 'V',
  R = 'R',
  c = 'C',
  t = 'T',
}

function M.mode()
  local m = vim.api.nvim_get_mode().mode:sub(1, 1)
  local color = mode_colors[m] or '#ffffff'
  local label = mode_labels[m] or m

  vim.api.nvim_set_hl(0, 'StatuslineMode', { fg = color, bold = true, bg = 'NONE' })

  return '%#StatuslineMode#[' .. label .. ']%#StatuslineBase#'
end

function M.file()
  local name = vim.fn.expand('%:t')
  if name == '' then name = '[No Name]' end

  local modified = vim.bo.modified and ' m' or ''
  vim.api.nvim_set_hl(0, 'StatuslineModified', { fg = '#f07178', bold = false, bg = 'NONE' })

  if vim.bo.modified then
    return name .. '%#StatuslineModified#' .. modified .. '%#StatuslineBase#'
  end

  return name
end

function M.git()
  local ok, signs = pcall(require, 'gitsigns')
  if not ok then return '' end

  local buf = vim.b.gitsigns_status_dict
  if not buf then return '' end

  local branch  = buf.head or ''
  local added   = buf.added and buf.added > 0 and ('%#StatuslineGitAdd#+' .. buf.added .. '%#StatuslineBase#') or ''
  local changed = buf.changed and buf.changed > 0 and ('%#StatuslineGitChange#~' .. buf.changed .. '%#StatuslineBase#') or
      ''
  local removed = buf.removed and buf.removed > 0 and ('%#StatuslineGitRemove#-' .. buf.removed .. '%#StatuslineBase#') or
      ''

  vim.api.nvim_set_hl(0, 'StatuslineGitBranch', { fg = '#ffcb6b', bold = true, bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'StatuslineGitAdd', { fg = '#c3e88d', bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'StatuslineGitChange', { fg = '#82aaff', bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'StatuslineGitRemove', { fg = '#f07178', bg = 'NONE' })

  local branch_str = branch ~= '' and ('%#StatuslineGitBranch# ' .. branch .. '%#StatuslineBase#') or ''
  local diff_str = table.concat({ added, changed, removed }, ' ')
  if diff_str ~= '' then diff_str = ' ' .. diff_str end

  return branch_str .. diff_str
end

function M.diagnostics()
  local errors   = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local hints    = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })

  vim.api.nvim_set_hl(0, 'StatuslineDiagError', { fg = '#f07178', bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'StatuslineDiagWarn', { fg = '#ffcb6b', bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'StatuslineDiagHint', { fg = '#82aaff', bg = 'NONE' })

  local parts = {}
  if errors > 0 then table.insert(parts, '%#StatuslineDiagError#E:' .. errors .. '%#StatuslineBase#') end
  if warnings > 0 then table.insert(parts, '%#StatuslineDiagWarn#W:' .. warnings .. '%#StatuslineBase#') end
  if hints > 0 then table.insert(parts, '%#StatuslineDiagHint#H:' .. hints .. '%#StatuslineBase#') end

  return table.concat(parts, ' ')
end

function M.lsp()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then return '' end

  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end

  vim.api.nvim_set_hl(0, 'StatuslineLsp', { fg = '#89ddff', bg = 'NONE' })

  return '%#StatuslineLsp#' .. table.concat(names, ' ') .. '%#StatuslineBase#'
end

function M.filetype()
  local ft = vim.bo.filetype
  if ft == '' then return '' end
  return ft
end

function M.cursor()
  return '%l:%c'
end

function M.cap()
  local m = vim.api.nvim_get_mode().mode:sub(1, 1)
  local color = mode_colors[m] or '#ffffff'
  vim.api.nvim_set_hl(0, 'StatuslineCap', { fg = color, bg = 'NONE', bold = true })
  return '%#StatuslineCap#█%#StatuslineBase# '
end

vim.o.statusline = table.concat({
  "%{%v:lua.require('statusline').cap()%}",
  -- izquierda
  "%{%v:lua.require('statusline').mode()%}",
  " ",
  "%{%v:lua.require('statusline').file()%}",
  " ",
  "%{%v:lua.require('statusline').git()%}",
  -- centro
  "%=",
  "%{%v:lua.require('statusline').lsp()%}",
  "%=",
  -- derecha
  "%{%v:lua.require('statusline').diagnostics()%}",
  " ",
  "%{%v:lua.require('statusline').filetype()%}",
  " ",
  "%{%v:lua.require('statusline').cursor()%}",
  " %#StatuslineCap#█%#StatuslineBase#",
}, "")

return M
