return function (specs, _)
  return {
    Normal       = { fg = specs.ui.fg     , bg = specs.ui.bg },
    NormalFloat  = { fg = specs.foreground, bg = specs.background },
    Visual       = { bg = specs.ui.bg_highlight },
    CursorLine   = { bg = specs.ui.bg_highlight },
    CursorLineNr = { fg = specs.orange, bold = true },
    StatusLine   = { fg = specs.ui.fg     , bg = specs.ui.bg_alt },
    StatusLineNC = { fg = specs.comment   , bg = specs.selection },
    FloatBorder  = { fg = specs.ui.border , bg = specs.ui.bg_alt },
    Search       = { fg = specs.background, bg = specs.orange },
    IncSearch    = { fg = specs.background, bg = specs.orange },
    WinSeparator = { fg = specs.border },
    VertSplit    = { fg = specs.ui.border },
    LineNr       = { fg = specs.blue },
    SignColumn   = { bg = specs.background },
    Folded       = { fg = specs.comment, bg = specs.selection },
  };
end
