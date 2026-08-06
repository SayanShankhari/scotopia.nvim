-- Highlights keywords like TODO, FIXME, HACK, NOTE.
return function (specs, _)
  return {
    TodoFix  = { fg = specs.ui.bg_dim, bg = specs.diag.error    , bold = true },
    TodoTodo = { fg = specs.ui.bg_dim, bg = specs.diag.info     , bold = true },
    TodoNote = { fg = specs.ui.bg_dim, bg = specs.diag.hint     , bold = true },
    TodoWarn = { fg = specs.ui.bg_dim, bg = specs.diag.warn     , bold = true },
    TodoPerf = { fg = specs.ui.bg_dim, bg = specs.syntax.special, bold = true },
  };
end
