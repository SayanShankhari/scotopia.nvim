-- Essential if users do heavy Git code reviews inside Neovim.
return function (specs, _)
  return {
    DiffviewFilePanelTitle    = { fg = specs.ui.accent     , bold = true },
    DiffviewFilePanelCounter  = { fg = specs.syntax.keyword, bold = true },
    DiffviewFilePanelFileName = { fg = specs.ui.fg },
    DiffviewNormal            = { bg = specs.ui.bg_dim },
    DiffviewFolderSign        = { fg = specs.treeview.folder },
  };
end
