-- Standard Vim fallback syntax groups (:help group-name).
return function (specs, _)
  return {
    Comment        = { fg = specs.syntax.comment, italic = true },
    SpecialComment = { fg = specs.syntax.special_comment or specs.syntax.comment },

    Constant  = { fg = specs.syntax.constant },
    String    = { fg = specs.syntax.string },
    Character = { fg = specs.syntax.character or specs.syntax.string },
    Number    = { fg = specs.syntax.number },
    Boolean   = { fg = specs.syntax.boolean or specs.syntax.constant },
    Float     = { fg = specs.syntax.number },

    Identifier = { fg = specs.syntax.variable },
    Function   = { fg = specs.syntax.fn },

    Statement   = { fg = specs.syntax.keyword },
    Conditional = { fg = specs.syntax.keyword },
    Repeat      = { fg = specs.syntax.keyword },
    Label       = { fg = specs.syntax.keyword },
    Operator    = { fg = specs.syntax.operator },
    Keyword     = { fg = specs.syntax.keyword },
    Exception   = { fg = specs.syntax.keyword },

    PreProc   = { fg = specs.syntax.preproc },
    Include   = { fg = specs.syntax.preproc },
    Define    = { fg = specs.syntax.preproc },
    Macro     = { fg = specs.syntax.macro },
    PreCondit = { fg = specs.syntax.preproc },

    Type         = { fg = specs.syntax.type },
    StorageClass = { fg = specs.syntax.type },
    Structure    = { fg = specs.syntax.type },
    Typedef      = { fg = specs.syntax.type },

    Special     = { fg = specs.syntax.special },
    SpecialChar = { fg = specs.syntax.special },
    Tag         = { fg = specs.syntax.tag },
    Delimiter   = { fg = specs.syntax.delimiter },
    Debug       = { fg = specs.syntax.special },

    Underlined = { underline = true },
    Ignore     = { fg = specs.ui.bg_dim },
    Error      = { fg = specs.diag.error, bold = true },
    Todo       = { fg = specs.ui.bg, bg = specs.diag.info, bold = true },
  };
end
