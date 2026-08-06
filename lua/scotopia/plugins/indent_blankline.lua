-- for visual scope tracking (ibl / indent-blankline).
return function (specs, _)
  return {
    IblIndent     = { fg = specs.ui.bg_subtle },
    IblWhitespace = { fg = specs.ui.bg_subtle },
    IblScope      = { fg = specs.ui.border },

    -- Legacy support for indent-blankline v2
    IndentBlanklineChar        = { fg = specs.ui.bg_subtle },
    IndentBlanklineContextChar = { fg = specs.ui.border },
  };
end
