-- Lualine expects a structured theme object rather than standard highlight group definitions. You can create a lualine theme directly from color_specs:
return function (specs, _)
  return {
    normal = {
      a = { bg = specs.ui.accent       , fg = specs.ui.bg_dim, gui = "bold" },
      b = { bg = specs.ui.bg_subtle    , fg = specs.ui.fg },
      c = { bg = specs.ui.bg_statusline, fg = specs.ui.fg_dim },
    },
    insert = {
      a = { bg = specs.diag.ok, fg = specs.ui.bg_dim, gui = "bold" },
    },
    visual = {
      a = { bg = specs.syntax.constant, fg = specs.ui.bg_dim, gui = "bold" },
    },
    replace = {
      a = { bg = specs.diag.error, fg = specs.ui.bg_dim, gui = "bold" },
    },
    command = {
      a = { bg = specs.diag.warn, fg = specs.ui.bg_dim, gui = "bold" },
    },
    inactive = {
      a = { bg = specs.ui.bg_statusline, fg = specs.ui.fg_dim },
      b = { bg = specs.ui.bg_statusline, fg = specs.ui.fg_dim },
      c = { bg = specs.ui.bg_statusline, fg = specs.ui.fg_dim },
    },
  }
end
