local specs = require ("scotopia.specs");

return {
  GitSignsAdd    = { fg = specs.diff.add },
  GitSignsChange = { fg = specs.diff.modify },
  GitSignsDelete = { fg = specs.diff.delete },
}
