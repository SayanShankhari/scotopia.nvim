local specs = require ("scotopia.specs");

return function ()
  return {
    Comment    = { fg = specs.syntax.comment, italic = true },
    Keyword    = { fg = specs.syntax.keyword },
    Function   = { fg = specs.syntax.func },
    String     = { fg = specs.syntax.string },
    Type       = { fg = specs.syntax.type },
    Constant   = { fg = specs.syntax.constant },
--[[
  paint ("Comment", { fg = colors.comment, italic = true })
  paint ("Constant", { fg = colors.magenta })
  paint ("String", { fg = colors.green })
  paint ("Identifier", { fg = colors.cyan })
  paint ("Function", { fg = colors.yellow, bold = true, italic = true })
  paint ("Statement", { fg = colors.purple })
  paint ("Conditional", { fg = colors.purple })
  paint ("Repeat", { fg = colors.purple })
  paint ("Operator", { fg = colors.cyan })
  paint ("Keyword", { fg = colors.orange, bold = true })
  paint ("PreProc", { fg = colors.yellow })
  paint ("Type", { fg = colors.cyan })
  paint ("Special", { fg = colors.magenta })
  paint ("Underlined", { underline = true })
  paint ("Error", { fg = colors.red, bold = true })
  paint ("Todo", { fg = colors.bg, bg = colors.yellow, bold = true })
--]]
  }
end
