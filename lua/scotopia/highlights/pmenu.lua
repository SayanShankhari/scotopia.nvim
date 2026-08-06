-- Controls built-in popup menus and command line completion (wildmenu).
return function (specs, _)
  return {
    -- Native Popup Menu
    Pmenu         = { fg = specs.popupmenu.fg    , bg = specs.popupmenu.bg },
    PmenuSel      = { fg = specs.popupmenu.fg_sel, bg = specs.popupmenu.bg_sel, bold = true },
    PmenuKind     = { fg = specs.popupmenu.kind  , bg = specs.popupmenu.bg },
    PmenuKindSel  = { fg = specs.popupmenu.kind  , bg = specs.popupmenu.bg_sel },
    PmenuExtra    = { fg = specs.popupmenu.extra , bg = specs.popupmenu.bg },
    PmenuExtraSel = { fg = specs.popupmenu.extra , bg = specs.popupmenu.bg_sel },
    PmenuSbar     = { bg = specs.popupmenu.bg_sbar },
    PmenuThumb    = { bg = specs.popupmenu.bg_thumb },

    -- Native WildMenu
    WildMenu = { fg = specs.popupmenu.fg_sel, bg = specs.popupmenu.bg_sel },
  };
end
