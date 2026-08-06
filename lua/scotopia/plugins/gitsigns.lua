return function (specs, _)
  return {
    GitSignsAdd              = { fg = specs.diff.add },
    GitSignsChange           = { fg = specs.diff.modify },
    GitSignsDelete           = { fg = specs.diff.delete },
    GitSignsCurrentLineBlame = { fg = specs.ui.fg_dim, italic = true },
  };
end
