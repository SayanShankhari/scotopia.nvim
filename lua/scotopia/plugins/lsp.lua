return function (specs, opts)
  return {
    -- Diagnostic Groups
    LspDiagnosticsDefaultError       = { fg = specs.diag.error },
    LspDiagnosticsDefaultWarning     = { fg = specs.diag.warn },
    LspDiagnosticsDefaultInformation = { fg = specs.diag.info },
    LspDiagnosticsDefaultHint        = { fg = specs.diag.hint },

    -- Underline / Undercurl diagnostics
    LspDiagnosticsUnderlineError       = { sp = specs.diag.error, undercurl = opts.undercurl, underline = not opts.undercurl },
    LspDiagnosticsUnderlineWarning     = { sp = specs.diag.warn , undercurl = opts.undercurl, underline = not opts.undercurl },
    LspDiagnosticsUnderlineInformation = { sp = specs.diag.info , undercurl = opts.undercurl, underline = not opts.undercurl },
    LspDiagnosticsUnderlineHint        = { sp = specs.diag.hint , undercurl = opts.undercurl, underline = not opts.undercurl },

    -- Modern Neovim standard diagnostic highlights
    DiagnosticError = { fg = specs.diag.error },
    DiagnosticWarn  = { fg = specs.diag.warn },
    DiagnosticInfo  = { fg = specs.diag.info },
    DiagnosticHint  = { fg = specs.diag.hint },
    DiagnosticOk    = { fg = specs.diag.ok },

    DiagnosticVirtualTextError = { fg = specs.diag.error, bg = specs.diag.error_bg },
    DiagnosticVirtualTextWarn  = { fg = specs.diag.warn , bg = specs.diag.warn_bg },
    DiagnosticVirtualTextInfo  = { fg = specs.diag.info , bg = specs.diag.info_bg },
    DiagnosticVirtualTextHint  = { fg = specs.diag.hint , bg = specs.diag.hint_bg },

    DiagnosticUnderlineError = { sp = specs.diag.error, undercurl = opts.undercurl, underline = not opts.undercurl },
    DiagnosticUnderlineWarn  = { sp = specs.diag.warn , undercurl = opts.undercurl, underline = not opts.undercurl },
    DiagnosticUnderlineInfo  = { sp = specs.diag.info , undercurl = opts.undercurl, underline = not opts.undercurl },
    DiagnosticUnderlineHint  = { sp = specs.diag.hint , undercurl = opts.undercurl, underline = not opts.undercurl },

    -- LSP References
    LspReferenceText  = { bg = specs.ui.bg_subtle },
    LspReferenceRead  = { bg = specs.ui.bg_subtle },
    LspReferenceWrite = { bg = specs.ui.bg_subtle },
  };
end
