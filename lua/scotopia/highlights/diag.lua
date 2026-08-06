-- Controls Neovim's native diagnostic groups (vim.diagnostic.*).
return function (specs, opts)
  return {
    -- Base Diagnostic Groups
    DiagnosticError = { fg = specs.diag.error },
    DiagnosticWarn  = { fg = specs.diag.warn },
    DiagnosticInfo  = { fg = specs.diag.info },
    DiagnosticHint  = { fg = specs.diag.hint },
    DiagnosticOk    = { fg = specs.diag.ok },

    -- Virtual Text
    DiagnosticVirtualTextError = { fg = specs.diag.error, bg = specs.diag.error_bg },
    DiagnosticVirtualTextWarn  = { fg = specs.diag.warn , bg = specs.diag.warn_bg },
    DiagnosticVirtualTextInfo  = { fg = specs.diag.info , bg = specs.diag.info_bg },
    DiagnosticVirtualTextHint  = { fg = specs.diag.hint , bg = specs.diag.hint_bg },
    DiagnosticVirtualTextOk    = { fg = specs.diag.ok   , bg = specs.diag.ok_bg },

    -- Underlines / Undercurls
    DiagnosticUnderlineError = { sp = specs.diag.error, undercurl = true },
    DiagnosticUnderlineWarn  = { sp = specs.diag.warn , undercurl = true },
    DiagnosticUnderlineInfo  = { sp = specs.diag.info , undercurl = true },
    DiagnosticUnderlineHint  = { sp = specs.diag.hint , undercurl = true },
    DiagnosticUnderlineOk    = { sp = specs.diag.ok   , undercurl = true },
    DiagnosticUnderline      = { sp = specs.diag.hint , undercurl = true },

    -- Floating Diagnostics
    DiagnosticFloatingError = { fg = specs.diag.error },
    DiagnosticFloatingWarn  = { fg = specs.diag.warn },
    DiagnosticFloatingInfo  = { fg = specs.diag.info },
    DiagnosticFloatingHint  = { fg = specs.diag.hint },
    DiagnosticFloatingOk    = { fg = specs.diag.ok },

    -- Gutter Signs
    DiagnosticSignError = { fg = specs.diag.error },
    DiagnosticSignWarn  = { fg = specs.diag.warn },
    DiagnosticSignInfo  = { fg = specs.diag.info },
    DiagnosticSignHint  = { fg = specs.diag.hint },
    DiagnosticSignOk    = { fg = specs.diag.ok },

    -- Deprecated / Unused
    DiagnosticUnnecessary = { fg = specs.ui.fg_subtle, underline = true },
    DiagnosticDeprecated  = { fg = specs.ui.fg_subtle, strikethrough = true },
  };
end
