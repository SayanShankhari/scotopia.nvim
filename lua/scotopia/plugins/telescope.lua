return function (specs)
  return {
    TelescopeTitle        = { fg = specs.ui.accent      , bold = true },
    TelescopeNormal       = { fg = specs.ui.fg          , bg = specs.ui.bg_float },
    TelescopeBorder       = { fg = specs.ui.border_float, bg = specs.ui.bg_float },
    TelescopePromptNormal = { fg = specs.ui.fg          , bg = specs.ui.bg_dim },
    TelescopePromptBorder = { fg = specs.ui.border      , bg = specs.ui.bg_dim },
    TelescopePromptPrefix = { fg = specs.ui.accent },
    TelescopeSelection    = { bg = specs.ui.selection   , fg = specs.ui.fg },
    TelescopeMatching     = { fg = specs.ui.search_match, bold = true },
  };
end
