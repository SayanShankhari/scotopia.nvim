return function (specs, _)
  return {
    WhichKey          = { fg = specs.keymap.key, bold = true },
    WhichKeyGroup     = { fg = specs.keymap.group },
    WhichKeyDesc      = { fg = specs.keymap.desc },
    WhichKeySeparator = { fg = specs.ui.fg_dim },
    WhichKeyFloat     = { bg = specs.ui.bg_float },
    WhichKeyBorder    = { fg = specs.ui.border_float, bg = specs.ui.bg_float },
  };
end
