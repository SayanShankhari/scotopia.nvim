local specs = require ("scotopia.specs");

return function ()
  return {
    Normal       = { fg = specs.ui.fg, bg = specs.ui.bg },
    CursorLine   = { bg = specs.ui.bg_highlight },
    Visual       = { bg = specs.ui.bg_highlight },
    StatusLine   = { fg = specs.ui.fg, bg = specs.ui.bg_alt },
    VertSplit    = { fg = specs.ui.border },
    FloatBorder  = { fg = specs.ui.border, bg = specs.ui.bg_alt },
--[[
  paint ("Normal", { fg = colors.foreground, bg = colors.background })
  paint ("NormalFloat", { fg = colors.foreground, bg = colors.background })
  paint ("FloatBorder", { fg = colors.border, bg = colors.background })
  paint ("CursorLine", { bg = colors.selection })
  paint ("Visual", { bg = "#3b3f55" })
  paint ("Search", { fg = colors.background, bg = colors.orange })
  paint ("IncSearch", { fg = colors.background, bg = colors.orange })
  paint ("StatusLine", { fg = colors.foreground, bg = colors.selection })
  paint ("StatusLineNC", { fg = colors.comment, bg = colors.selection })
  paint ("VertSplit", { fg = colors.border })
  paint ("WinSeparator", { fg = colors.border })
  paint ("LineNr", { fg = colors.blue })
  paint ("CursorLineNr", { fg = colors.orange, bold = true })
  paint ("SignColumn", { bg = colors.background })
  paint ("Folded", { fg = colors.comment, bg = colors.selection })
--]]
  }
end
