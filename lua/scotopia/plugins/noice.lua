-- Cmdline & Notifications, it is used by distributions like LazyVim for floating command-line inputs and popups.
return function (specs, _)
  return {
    NoiceCmdlinePopupBorder = { fg = specs.ui.accent },
    NoiceCmdlineIcon        = { fg = specs.ui.accent },
    NotifyERRORBorder       = { fg = specs.diag.error },
    NotifyWARNBorder        = { fg = specs.diag.warn },
    NotifyINFOBorder        = { fg = specs.diag.info },
    NotifyDEBUGBorder       = { fg = specs.ui.fg_dim },
    NotifyTRACEBorder       = { fg = specs.syntax.keyword },
  };
end
