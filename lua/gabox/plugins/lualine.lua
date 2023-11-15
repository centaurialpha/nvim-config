local colors = {
  bg = "#202328",
  fg = "#bbc2cf",
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

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local color_mode = function()
  local modes_colors = {
    n = colors.red,
    i = colors.green,
    v = colors.blue,
    [""] = colors.blue,
    V = colors.blue,
    c = colors.magenta,
    no = colors.red,
    s = colors.orange,
    S = colors.orange,
    [""] = colors.orange,
    ic = colors.yellow,
    R = colors.violet,
    Rv = colors.violet,
    cv = colors.red,
    ce = colors.red,
    r = colors.cyan,
    rm = colors.cyan,
    ["r?"] = colors.cyan,
    ["!"] = colors.red,
    t = colors.red,
  }
  return { fg = modes_colors[vim.fn.mode()] }
end

local config = {
  options = {
    disabled_filetypes = { "NvimTree" },
    component_separators = "",
    section_separators = "",
    -- theme = {
    --   -- We are going to use lualine_c an lualine_x as left and
    --   -- right section. Both are highlighted by c theme .  So we
    --   -- are just setting default looks o statusline
    --   normal = { c = { fg = colors.fg, bg = colors.bg } },
    --   inactive = { c = { fg = colors.fg, bg = colors.bg } },
    -- },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local lualine = require("lualine")

    ins_left({
      function()
        return "▊"
      end,
      color = function()
        return color_mode()
      end,
      padding = { left = 0, right = 1 },
    })
    ins_left({
      function()
        return ""
      end,
      color = function()
        return color_mode()
      end,
      padding = { right = 1 },
    })
    ins_right({"location"})
    ins_right({
      "filetype",
      fmt = string.upper,
      color = { fg = colors.orange, gui = "bold" },
    })
    ins_left({
      "filename",
      cond = conditions.buffer_not_empty,
      color = { fg = colors.magenta, gui = "bold" },
    })
    ins_left({
      "branch",
      icon = "",
      color = { fg = colors.violet, gui = "bold" },
    })
    ins_left({
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = { error = " ", warn = " ", info = " " },
      diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
      },
    })

    ins_right({
      "o:encoding",
      fmt = string.upper,
      cond = conditions.hide_in_width,
      color = { fg = colors.green, gui = "bold" },
    })
    ins_right({
      function()
        return "▊"
      end,
      color = function()
        return color_mode()
      end,
      padding = { left = 1, right = 0 },
    })

    lualine.setup(config)
  end,
}
