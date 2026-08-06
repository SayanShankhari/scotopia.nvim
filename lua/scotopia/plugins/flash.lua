-- Fast leap/motion plugins that need high-contrast highlight markers.
return function (specs, _)
  return {
    FlashMatch   = { bg = specs.ui.search_bg   , fg = specs.ui.fg },
    FlashCurrent = { bg = specs.ui.search_match, fg = specs.ui.bg_dim },
    FlashLabel   = { bg = specs.diag.error     , fg = specs.ui.bg_dim, bold = true },
  };
end
