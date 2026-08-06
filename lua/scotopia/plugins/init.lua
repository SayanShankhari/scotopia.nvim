return function (specs, opts)
  local plugin_modules = {
    -- core
    require ("scotopia.plugins.treesitter"),
    require ("scotopia.plugins.lsp"),
    require ("scotopia.plugins.telescope"),
    require ("scotopia.plugins.cmp"),
    require ("scotopia.plugins.gitsigns"),
    require ("scotopia.plugins.whichkey"),
    require ("scotopia.plugins.neotree"),

    -- extras
    require ("scotopia.plugins.indent_blankline"),
    require ("scotopia.plugins.flash"),
    require ("scotopia.plugins.todo_comments"),
    require ("scotopia.plugins.diffview"),
    require ("scotopia.plugins.nvim_tree"),
    require ("scotopia.plugins.noice"),
  };

  local highlight_groups = {};
  for _, hl_factory in ipairs (plugin_modules) do
    highlight_groups = vim.tbl_deep_extend ("force", highlight_groups, hl_factory (specs, opts));
  end
  return highlight_groups;
end
