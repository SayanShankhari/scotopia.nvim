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
  keyword  = palette.orange,
  string   = palette.green,
  func     = palette.blue,
  type     = palette.cyan,
  constant = palette.orange,
  comment  = palette.fg0,
  number   = palette.purple,
}

-- TODO: do this
-- FIXME: fix this
-- NOTE: read this

--[[
  paint ("Comment", { fg = colors.comment, italic = true })
  paint ("Constant", { fg = colors.magenta })
  paint ("Identifier", { fg = colors.cyan })
  paint ("Statement", { fg = colors.purple })
  paint ("Conditional", { fg = colors.purple })
  paint ("Repeat", { fg = colors.purple })
  paint ("Operator", { fg = colors.cyan })
  paint ("PreProc", { fg = colors.yellow })
  paint ("Special", { fg = colors.magenta })
  paint ("Underlined", { underline = true })
  paint ("Error", { fg = colors.red, bold = true })
  paint ("Todo", { fg = colors.bg, bg = colors.yellow, bold = true })
--]]

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


-- 1. Full Default Palette Spec (Fallback Base)
S.default_specs = {
  ui = {
    fg            = "#c0caf5",
    bg            = "#1a1b26",
    fg_dim        = "#565f89",
    fg_gutter     = "#3b4261",
    fg_subtle     = "#565f89",
    bg_dim        = "#16161e",
    bg_subtle     = "#292e42",
    bg_cursorline = "#292e42",
    bg_float      = "#1f2335",
    bg_statusline = "#1f2335",
    cursor        = "#c0caf5",
    selection     = "#28344e",
    border        = "#27a1a9",
    border_float  = "#27a1a9",
    accent        = "#7aa2f7",
    search_bg     = "#3d59a1",
    search_match  = "#ff9e64",
  },
  diag = {
    error    = "#f7768e",
    warn     = "#e0af68",
    info     = "#0db9d7",
    hint     = "#1abc9c",
    ok       = "#9ece6a",
    error_bg = "#2d202a",
    warn_bg  = "#2e2a2d",
    info_bg  = "#1a2b32",
    hint_bg  = "#1c2c2f",
    ok_bg    = "#1a2b2a",
  },
  diff = {
    add_bg    = "#283b4d",
    add_fg    = "#b8db87",
    change_bg = "#272d43",
    change_fg = "#7ca1f7",
    delete_bg = "#3f2d3d",
    delete_fg = "#e26a75",
    text_bg   = "#394b70",
    text_fg   = "#c0caf5",
  },
  syntax = {
    comment         = "#565f89",
    special_comment = "#737aa2",
    constant        = "#ff9e64",
    string          = "#9ece6a",
    character       = "#9ece6a",
    number          = "#ff9e64",
    boolean         = "#ff9e64",
    variable        = "#c0caf5",
    builtin         = "#0db9d7",
    parameter       = "#e0af68",
    property        = "#7dcfff",
    fn              = "#7aa2f7",
    keyword         = "#bb9af7",
    operator        = "#89ddff",
    type            = "#2ac3de",
    preproc         = "#7dcfff",
    macro           = "#bb9af7",
    special         = "#7dcfff",
    tag             = "#f7768e",
    delimiter       = "#89ddff",
  },
  popupmenu = {
    fg       = "#c0caf5",
    bg       = "#1f2335",
    fg_sel   = "#ffffff",
    bg_sel   = "#364a82",
    kind     = "#7aa2f7",
    extra    = "#565f89",
    bg_sbar  = "#292e42",
    bg_thumb = "#3b4261",
  },
  completion = {
    item       = "#c0caf5",
    match      = "#7dcfff",
    detail     = "#565f89",
    snippet    = "#bb9af7",
    deprecated = "#565f89",
  },
  treeview = {
    fg          = "#c0caf5",
    bg          = "#1f2335",
    title       = "#7aa2f7",
    icon        = "#7aa2f7",
    folder      = "#7aa2f7",
    folder_open = "#7dcfff",
  },
  keymap = {
    key   = "#7aa2f7",
    group = "#0db9d7",
    desc  = "#c0caf5",
  },
}

-- Create Level 2 (Section proxy for keys like S.ui.bg)
local function create_section_proxy (user_section, default_section)
  return setmetatable ({}, {
    __index = function (_, key)
      local default_val = default_section [key];
      -- Reject unknown property keys
      if default_val == nil then return nil end;

      local user_val = user_section and user_section [key];
      if user_val ~= nil then return user_val end;

      return default_val;
    end,
  })
end

-- Create Level 1 (Top proxy for sections like S.ui)
local function create_spec_proxy (user_specs)
  return setmetatable ({}, {
    __index = function (_, section_key)
      local default_section = S.default_specs [section_key];

      -- Reject unknown section keys (e.g. S.invalid_section)
      if default_section == nil then return nil end;

      local user_section = user_specs and user_specs [section_key];
      return create_section_proxy (user_section, default_section);
    end,
  })
end

-- 3. Main Constructor API
function S.sanitize (user_specs)
  if not user_specs or type (user_specs) ~= "table" then
    return S.default_specs;
  end;
  return create_spec_proxy (user_specs);
end


return S;
