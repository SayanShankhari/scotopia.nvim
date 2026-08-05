local specs = require ("scotopia.specs");

return function ()
  return {
    DiagnosticError = { fg = specs.diag.error },
    DiagnosticWarn  = { fg = specs.diag.warning },
    DiagnosticInfo  = { fg = specs.diag.info },
    DiagnosticHint  = { fg = specs.diag.hint },
    DiagnosticUnderlineError = { undercurl = true, sp = specs.diag.error },
    DiagnosticUnderlineWarn  = { undercurl = true, sp = specs.diag.warning },
    DiagnosticUnderlineInfo  = { undercurl = true, sp = specs.diag.green },
    DiagnosticUnderlineHint  = { undercurl = true, sp = specs.diag.hint },
    DiagnosticUnderline      = { undercurl = true, sp = specs.diag.hint },
  }
end
