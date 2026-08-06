return function (specs, _)
  return {
    CmpItemAbbr           = { fg = specs.completion.item },
    CmpItemAbbrDeprecated = { fg = specs.completion.deprecated, strikethrough = true },
    CmpItemAbbrMatch      = { fg = specs.completion.match     , bold = true },
    CmpItemAbbrMatchFuzzy = { fg = specs.completion.match     , bold = true },
    CmpItemMenu           = { fg = specs.completion.detail    , italic = true },

    -- Kind Icons
    CmpItemKind         = { fg = specs.popupmenu.kind },
    CmpItemKindFunction = { fg = specs.syntax.fn },
    CmpItemKindMethod   = { fg = specs.syntax.fn },
    CmpItemKindVariable = { fg = specs.syntax.variable },
    CmpItemKindKeyword  = { fg = specs.syntax.keyword },
    CmpItemKindSnippet  = { fg = specs.completion.snippet },
  };
end
