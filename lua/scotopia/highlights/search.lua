-- Controls pattern matching, search highlights, matching parentheses, spellcheck, and quickfix selections
return function (specs, opts)
  return {
    -- Search & Replace
    Search     = { fg = specs.ui.bg, bg = specs.ui.search_bg },
    IncSearch  = { fg = specs.ui.bg, bg = specs.ui.search_match },
    CurSearch  = { fg = specs.ui.bg, bg = specs.ui.search_match, bold = true },
    Substitute = { fg = specs.ui.bg, bg = specs.ui.accent },
    MatchParen = { fg = specs.ui.accent, bold = true, underline = true },

    -- QuickFix & Messages
    QuickFixLine = { bg = specs.ui.bg_cursorline, bold = true },
    ErrorMsg     = { fg = specs.diag.error      , bold = true },
    WarningMsg   = { fg = specs.diag.warn       , bold = true },
    ModeMsg      = { fg = specs.ui.fg           , bold = true },
    MoreMsg      = { fg = specs.ui.accent },
    Question     = { fg = specs.ui.accent },

    -- Spell Checking
    SpellBad   = { sp = specs.diag.error, undercurl = opts.undercurl, underline = not opts.undercurl },
    SpellCap   = { sp = specs.diag.warn , undercurl = opts.undercurl, underline = not opts.undercurl },
    SpellLocal = { sp = specs.diag.info , undercurl = opts.undercurl },
    SpellRare  = { sp = specs.diag.hint , undercurl = opts.undercurl },
  };
end
