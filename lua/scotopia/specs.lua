local palette = require ("scotopia.palette");

local S = {};

S.ui = {
  bg        = palette.bg0,
  bg_float  = palette.bg1,
--bg_popup  = utils.darken (palette.bg1, 0.08),
--bg_popup  = ,
  fg        = palette.fg0,
  fg_float  = palette.fg2,
  fg_dim    = palette.fg2,
  border    = palette.bg2,
  cursor    = palette.fg0,
  selection = palette.fg2,
}

S.diag = {
  error = palette.red,
  warn  = palette.yellow,
  info  = palette.blue,
  hint  = palette.cyan,
}

S.diff = {
  add      = palette.green,
  delete   = palette.red,
  modify   = palette.yellow,
  conflict = palette.orange,
  untrack  = palette.comment,
  ignore   = palette.comment,
  stage    = palette.green,
}

S.syntax = {
  keyword  = palette.purple,
  string   = palette.green,
  func     = palette.blue,
  type     = palette.yellow,
  constant = palette.orange,
  comment  = palette.fg2,
  number   = palette.red,
}

S.popupmenu = {
  foreground = palette.fg1,
  background = palette.bg1,
}

S.completion = {
  fg      = palette.fg2,
  accent  = palette.cyan,
  comment = palette.bg2,
}

S.treeview = {
  dir_name      = palette.blue,
  dir_icon      = palette.blue,
  file_name     = palette.yellow,
  file_icon     = palette.foreground,
  file_opened   = palette.green,
  indent_marker = palette.bg0,
  expander      = palette.comment,
  root_name     = palette.blue,
}

S.keymap = {
  accent  = palette.brown,
  keyword = palette.orange,
  fg      = palette.magenta,
  border  = palette.white,
}


return S;
