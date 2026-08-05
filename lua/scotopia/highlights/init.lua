local modules = {
  require ("scotopia.highlights.editor"),
  require ("scotopia.highlights.syntax"),
  require ("scotopia.highlights.diag"),
  require ("scotopia.highlights.pmenu"),
}

return function ()
  local H = {};

  for _, module in ipairs (modules) do
    vim.tbl_extend ("force", H, module());
  end

  return H;
end
