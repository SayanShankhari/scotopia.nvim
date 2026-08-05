return function()
  return vim.tbl_extend (
    "force",
    {},
    require ("scotopia.plugins.treesitter"),
    require ("scotopia.plugins.lsp"),
    require ("scotopia.plugins.telescope"),
    require ("scotopia.plugins.cmp"),
    require ("scotopia.plugins.gitsigns"),
    require ("scotopia.plugins.whichkey"),
    require ("scotopia.plugins.neotree")
  );
end
