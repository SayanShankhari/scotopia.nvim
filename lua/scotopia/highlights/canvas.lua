-- Controls the physical buffer editor area, line numbers, cursor, active lines, and window split separators.
return function (specs, _)
  return {
    -- Normal Text & Canvas
    Normal      = { fg = specs.ui.fg, bg = specs.ui.bg },
    NormalNC    = { fg = specs.ui.fg_dim, bg = specs.ui.bg_dim },
    ColorColumn = { bg = specs.ui.bg_subtle },
    Conceal     = { fg = specs.ui.fg_subtle },
    Directory   = { fg = specs.ui.accent, bold = true },
    EndOfBuffer = { fg = specs.ui.bg_dim },
    NonText     = { fg = specs.ui.fg_gutter },
    SpecialKey  = { fg = specs.ui.fg_gutter },
    Whitespace  = { fg = specs.ui.fg_gutter },

    -- Cursor & Line Highlighting
    Cursor       = { fg = specs.ui.bg, bg = specs.ui.cursor },
    lCursor      = { fg = specs.ui.bg, bg = specs.ui.cursor },
    CursorIM     = { fg = specs.ui.bg, bg = specs.ui.cursor },
    TermCursor   = { fg = specs.ui.bg, bg = specs.ui.cursor },
    CursorLine   = { bg = specs.ui.bg_cursorline },
    CursorColumn = { bg = specs.ui.bg_cursorline },

    -- Line Numbers & Gutters
    LineNr       = { fg = specs.ui.fg_gutter },
    LineNrAbove  = { fg = specs.ui.fg_gutter },
    LineNrBelow  = { fg = specs.ui.fg_gutter },
    CursorLineNr = { fg = specs.ui.accent, bold = true },
    SignColumn   = { bg = specs.ui.bg },
    FoldColumn   = { fg = specs.ui.fg_gutter },
    Folded       = { fg = specs.ui.fg_subtle, bg = specs.ui.bg_subtle },

    -- Visual Selection
    Visual    = { bg = specs.ui.selection },
    VisualNOS = { bg = specs.ui.selection },

    -- Windows Separators & Borders
    WinSeparator = { fg = specs.ui.border },
    VertSplit    = { fg = specs.ui.border },
  };
end
