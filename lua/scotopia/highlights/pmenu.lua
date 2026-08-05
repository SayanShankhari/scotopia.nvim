local specs = require ("scotopia.specs");

return function()
  return {
    Pmenu      = { fg = specs.popupmenu.foreground, bg = specs.popupmenu.background },
--    PmenuSel   = { fg = specs.popupmenu.selection_foreground, bg = specs.selection.background },
--    PmenuSbar  = { bg = specs.popupmenu.selection_bar },
--    PmenuThumb = { bg = specs.popupmenu.thumb },
--[[
  paint ("Pmenu", { fg = colors.foreground, bg = colors.background })
  paint ("PmenuSel", { fg = colors.background, bg = colors.orange })
  paint ("PmenuSbar", { bg = colors.selection })
  paint ("PmenuThumb", { bg = colors.orange })
--]]
  }
end
