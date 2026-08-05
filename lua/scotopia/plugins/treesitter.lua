local specs = require ("scotopia.specs");

return {
  ["@comment"]  = { fg = specs.syntax.comment },
  ["@keyword"]  = { fg = specs.syntax.keyword },
  ["@string"]   = { fg = specs.syntax.string },
  ["@number"]   = { fg = specs.syntax.number },
  ["@function"] = { fg = specs.syntax.func },
}
