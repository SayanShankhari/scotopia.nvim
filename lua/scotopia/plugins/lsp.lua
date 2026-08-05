local p = require ("scotopia.palette");

return {
  DiagnosticError = { fg = p.error },
  DiagnosticWarn = { fg = p.warning },
  DiagnosticInfo = { fg = p.info },
  DiagnosticHint = { fg = p.hint },

  LspReferenceText = { bg = p.selection },
  LspReferenceRead = { bg = p.selection },
  LspReferenceWrite = { bg = p.selection },
}
