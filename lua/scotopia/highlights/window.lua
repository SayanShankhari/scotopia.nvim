-- Controls statuslines, winbars, tablines, floating windows, and command-line message areas.
return function (specs, _)
  return {
    -- Floating Windows
    NormalFloat = { fg = specs.ui.fg          , bg = specs.ui.bg_float },
    FloatBorder = { fg = specs.ui.border_float, bg = specs.ui.bg_float },
    FloatTitle  = { fg = specs.ui.accent      , bg = specs.ui.bg_float, bold = true },
    FloatFooter = { fg = specs.ui.fg_subtle   , bg = specs.ui.bg_float },

    -- StatusLine
    StatusLine   = { fg = specs.ui.fg    , bg = specs.ui.bg_statusline },
    StatusLineNC = { fg = specs.ui.fg_dim, bg = specs.ui.bg_dim },

    -- WinBar (Buffer-level statusline)
    WinBar   = { fg = specs.ui.fg    , bg = specs.ui.bg },
    WinBarNC = { fg = specs.ui.fg_dim, bg = specs.ui.bg },

    -- TabLine
    TabLine     = { fg = specs.ui.fg_dim, bg = specs.ui.bg_dim },
    TabLineSel  = { fg = specs.ui.fg    , bg = specs.ui.bg, bold = true },
    TabLineFill = { bg = specs.ui.bg_dim },

    -- Message & Command Line Area
    MsgArea      = { fg = specs.ui.fg },
    MsgSeparator = { fg = specs.ui.border, bg = specs.ui.bg },
    Title        = { fg = specs.ui.accent, bold = true },
  };
end
