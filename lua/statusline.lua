local M = {}
_G.Statusline = M

local mode_labels = {
  n = 'NOR',
  i = 'INS',
  v = 'VIS',
  V = 'VLN',
  R = 'REP',
  c = 'CMD',
  t = 'TER',
}
local has_gitsigns = pcall(require, 'gitsigns')

function M.mode()
  local m = vim.api.nvim_get_mode().mode:sub(1, 1)
  local label = mode_labels[m] or m
  return '[' .. label .. ']'
end

function M.file()
  local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':~:.')
  if name == '' then name = '[NN]' end

  local flags = {}

  if vim.bo.modified then table.insert(flags, 'mod') end

  if vim.bo.readonly then table.insert(flags, 'ro') end

  if #flags > 0 then name = name .. ' [' .. table.concat(flags, ',') .. ']' end

  return name
end

function M.diagnostics()
  local counts = { 0, 0, 0 }
  for _, d in ipairs(vim.diagnostic.get(0)) do
    if d.severity == vim.diagnostic.severity.ERROR then
      counts[1] = counts[1] + 1
    elseif d.severity == vim.diagnostic.severity.WARN then
      counts[2] = counts[2] + 1
    elseif d.severity == vim.diagnostic.severity.HINT then
      counts[3] = counts[3] + 1
    end
  end

  local parts = {}
  if counts[1] > 0 then table.insert(parts, 'E:' .. counts[1]) end
  if counts[2] > 0 then table.insert(parts, 'W:' .. counts[2]) end
  if counts[3] > 0 then table.insert(parts, 'H:' .. counts[3]) end

  return table.concat(parts, ' ')
end

function M.git()
  if not has_gitsigns then return '' end

  local buf = vim.b.gitsigns_status_dict
  if not buf then return '' end

  local branch = buf.head or ''
  local added = buf.added and buf.added > 0 and ('%#StatuslineGitAdd#+' .. buf.added .. '%#StatuslineBase#') or ''
  local changed = buf.changed and buf.changed > 0 and ('%#StatuslineGitChanged#~' .. buf.changed .. '%#StatuslineBase#') or ''
  local removed = buf.removed and buf.removed > 0 and ('%#StatuslineGitRemoved#-' .. buf.removed .. '%#StatuslineBase#') or ''

  local branch_str = branch ~= '' and branch or ''
  local diff_str = table.concat({ added, changed, removed }, ' ')
  if diff_str ~= '' then diff_str = ' ' .. diff_str end
  return '[' .. branch_str .. ']' .. diff_str
end

function M.cursor() return '%l:%c %P' end

vim.go.statusline = table.concat({
  '%{%v:lua.Statusline.mode()%}',
  ' ',
  '%{%v:lua.Statusline.file()%}',
  '%=',
  '%{%v:lua.Statusline.git()%}',
  '%=',
  '%{%v:lua.Statusline.diagnostics()%}',
  ' ',
  '%{%v:lua.Statusline.cursor()%}',
  ' ',
}, '')

return M
