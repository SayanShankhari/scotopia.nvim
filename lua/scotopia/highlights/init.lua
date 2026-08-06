return function (specs, opts)
  local core_modules = {
    require ("scotopia.highlights.canvas"),
    require ("scotopia.highlights.search"),
    require ("scotopia.highlights.window"),
    require ("scotopia.highlights.diff"),
    require ("scotopia.highlights.diag"),
    require ("scotopia.highlights.pmenu"),
    require ("scotopia.highlights.syntax"),
  };

  local highlight_groups = {};
  for _, hl_factory in ipairs (core_modules) do
    highlight_groups = vim.tbl_deep_extend ("force", highlight_groups, hl_factory (specs, opts));
  end
  return highlight_groups;
end
