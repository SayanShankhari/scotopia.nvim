-- local palette = require ("scotopia.palette");

local S = {};


S.defaults = {
  ui = {
    fg             = "#E8DFD8", -- Warm Mountain Mist Text
    fg_dim         = "#A89A90", -- Muted Weathered Stone
    fg_gutter      = "#3E3029", -- Deep Dark Mahogany Gutter
    fg_subtle      = "#6B584C", -- Smoked Timber Ash
    bg             = "#0F1115", -- Dark Steel/Abyss Canvas
    bg_dim         = "#14171E", -- Eerie Black Panel
    bg_subtle      = "#1E1815", -- Deep Mahogany Accent Surface
    bg_cursorline  = "#181311", -- Subtle Line Glow
    bg_float       = "#161210", -- Floating Window Backdrop
    bg_statusline  = "#161210", -- Status Bar Base
    cursor         = "#38BDF8", -- Light Electric Cyan Cursor
    selection      = "#2B1E19", -- Dark Roasted Highlight
    border         = "#6B584C", -- Smoked Timber Border
    border_float   = "#FF9E64", -- Apricot Orange Accent Border
    accent         = "#FF9E64", -- Warm Apricot Orange
    search_bg      = "#3A1E18", -- Deep Wine Highlight
    search_match   = "#F76C6C", -- Coral Red Flash
  },
  diag = {
    error    = "#F76C6C", -- Coral Red
    warn     = "#FF9E64", -- Apricot Orange
    info     = "#38BDF8", -- Electric Cyan
    hint     = "#98C379", -- Meadow Green
    ok       = "#98C379", -- Meadow Green
    error_bg = "#261212", -- Dark Red Tint
    warn_bg  = "#24190E", -- Dark Amber Tint
    info_bg  = "#0E1E22", -- Dark Blue Tint
    hint_bg  = "#121F13", -- Dark Green Tint
    ok_bg    = "#121F13", -- Dark Green Tint
  },
  diff = {
    add       = "#98C379", -- Meadow Green
    delete    = "#F76C6C", -- Coral Red
    modify    = "#FF9E64", -- Apricot Orange
    conflict  = "#B8835A", -- Timber Brown
    untrack   = "#6B584C", -- Timber Ash
    ignore    = "#6B584C", -- Timber Ash
    stage     = "#98C379", -- Meadow Green
    add_bg    = "#142215", -- Dark Meadow Tint
    add_fg    = "#98C379", -- Meadow Green
    change_bg = "#0E1B28", -- Dark Cobalt Tint
    change_fg = "#38BDF8", -- Electric Cyan
    delete_bg = "#281214", -- Dark Berry Tint
    delete_fg = "#F76C6C", -- Coral Red
    text_bg   = "#231628", -- Dark Amethyst Tint
    text_fg   = "#E8DFD8", -- Mountain Mist
  },
  syntax = {
    comment         = "#6B584C", -- Smoked Timber Ash
    special_comment = "#887A74", -- Soft Bark Slate
    constant        = "#C678DD", -- Amethyst Purple
    number          = "#E54888", -- Blossom Magenta
    boolean         = "#E54888", -- Blossom Magenta
    string          = "#98C379", -- Meadow Green
    character       = "#98C379", -- Meadow Green
    variable        = "#E8DFD8", -- Warm Mountain Mist
    builtin         = "#38BDF8", -- Electric Cyan
    parameter       = "#E8DFD8", -- Warm Mountain Mist
    property        = "#8EA0C2", -- Soft Dusk Indigo (Balanced blue-gray for properties)
    preproc         = "#B8835A", -- Timber Brown
    special         = "#A3F853", -- Neon Lime (\n, %d string escapes)
    fn              = "#38BDF8", -- Light Electric Cyan
    keyword         = "#FF9E64", -- Warm Apricot Orange
    macro           = "#B8835A", -- Timber Brown
    operator        = "#F76C6C", -- Coral Red Punctuation & Symbols
    delimiter       = "#F76C6C", -- Coral Red Brackets & Punctuation
    type            = "#FACC15", -- Sunlight Gold / Yellow
    tag             = "#F76C6C", -- Coral Red
    identifier      = "#E8DFD8", -- Warm Mountain Mist
    statement       = "#FF9E64", -- Warm Apricot Orange
    conditional     = "#FF9E64", -- Warm Apricot Orange
    error           = "#F76C6C", -- Coral Red
    todo            = "#FF9E64", -- Warm Apricot Orange
  },
  popupmenu = {
    fg       = "#E8DFD8", -- Mountain Mist
    fg_sel   = "#FFFFFF", -- Pure White
    bg       = "#161210", -- Floating Window Backdrop
    bg_sel   = "#2B1E19", -- Dark Roasted Highlight
    kind     = "#38BDF8", -- Electric Cyan
    extra    = "#6B584C", -- Timber Ash
    bg_sbar  = "#1E1815", -- Dark Mahogany Accent
    bg_thumb = "#3E3029", -- Deep Mahogany Thumb
  },
  completion = {
    item       = "#E8DFD8", -- Mountain Mist
    match      = "#FF9E64", -- Apricot Orange Match
    detail     = "#6B584C", -- Timber Ash
    deprecated = "#6B584C", -- Timber Ash
    snippet    = "#E54888", -- Blossom Magenta
    fg         = "#A89A90", -- Weathered Stone
    accent     = "#FACC15", -- Sunlight Gold
    comment    = "#161210", -- Dark Float Base
  },
  treeview = {
    fg             = "#E8DFD8", -- Mountain Mist
    bg             = "#161210", -- Dark Float Base
    title          = "#FF9E64", -- Apricot Orange
    icon           = "#38BDF8", -- Electric Cyan
    folder         = "#B8835A", -- Timber Brown
    folder_open    = "#FF9E64", -- Apricot Orange Open Folder
    dir_name       = "#8EA0C2", -- Soft Dusk Indigo
    dir_icon       = "#8EA0C2", -- Soft Dusk Indigo
    file_name      = "#E8DFD8", -- Mountain Mist
    file_icon      = "#E8DFD8", -- Mountain Mist
    file_opened    = "#98C379", -- Meadow Green
    indent_marker = "#100C0A", -- Base Dark
    expander      = "#6B584C", -- Timber Ash
    root_name      = "#38BDF8", -- Electric Cyan
  },
  keymap = {
    key    = "#FF9E64", -- Apricot Orange
    group  = "#8EA0C2", -- Soft Dusk Indigo
    desc   = "#E8DFD8", -- Mountain Mist
    accent = "#B8835A", -- Timber Brown
    fg     = "#E54888", -- Blossom Magenta
    border = "#E8DFD8", -- Mountain Mist
  },
};

S.mahogany = {
  ui = {
    fg             = "#E8DFD8", -- Warm Mountain Mist Text
    fg_dim         = "#A89A90", -- Muted Weathered Stone
    fg_gutter      = "#3E3029", -- Deep Dark Mahogany Gutter
    fg_subtle      = "#6B584C", -- Smoked Timber Ash
    bg             = "#100C0A", -- Dark Mahogany Canvas
    bg_dim         = "#161210", -- Dark Roasted Timber Raised Panel
    bg_subtle      = "#1E1815", -- Deep Mahogany Accent Surface
    bg_cursorline  = "#181311", -- Subtle Line Glow
    bg_float       = "#161210", -- Floating Window Backdrop
    bg_statusline  = "#161210", -- Status Bar Base
    cursor         = "#38BDF8", -- Light Electric Cyan Cursor
    selection      = "#2B1E19", -- Dark Roasted Highlight
    border         = "#6B584C", -- Smoked Timber Border
    border_float   = "#FF9E64", -- Apricot Orange Accent Border
    accent         = "#FF9E64", -- Warm Apricot Orange
    search_bg      = "#3A1E18", -- Deep Wine Highlight
    search_match   = "#F76C6C", -- Coral Red Flash
  },
  diag = {
    error    = "#F76C6C", -- Coral Red
    warn     = "#FF9E64", -- Apricot Orange
    info     = "#38BDF8", -- Electric Cyan
    hint     = "#98C379", -- Meadow Green
    ok       = "#98C379", -- Meadow Green
    error_bg = "#261212", -- Dark Red Tint
    warn_bg  = "#24190E", -- Dark Amber Tint
    info_bg  = "#0E1E22", -- Dark Blue Tint
    hint_bg  = "#121F13", -- Dark Green Tint
    ok_bg    = "#121F13", -- Dark Green Tint
  },
  diff = {
    add       = "#98C379", -- Meadow Green
    delete    = "#F76C6C", -- Coral Red
    modify    = "#FF9E64", -- Apricot Orange
    conflict  = "#B8835A", -- Timber Brown
    untrack   = "#6B584C", -- Timber Ash
    ignore    = "#6B584C", -- Timber Ash
    stage     = "#98C379", -- Meadow Green
    add_bg    = "#142215", -- Dark Meadow Tint
    add_fg    = "#98C379", -- Meadow Green
    change_bg = "#0E1B28", -- Dark Cobalt Tint
    change_fg = "#38BDF8", -- Electric Cyan
    delete_bg = "#281214", -- Dark Berry Tint
    delete_fg = "#F76C6C", -- Coral Red
    text_bg   = "#231628", -- Dark Amethyst Tint
    text_fg   = "#E8DFD8", -- Mountain Mist
  },
  syntax = {
    comment         = "#6B584C", -- Smoked Timber Ash
    special_comment = "#887A74", -- Soft Bark Slate
    constant        = "#C678DD", -- Amethyst Purple
    number          = "#E54888", -- Blossom Magenta
    boolean         = "#E54888", -- Blossom Magenta
    string          = "#98C379", -- Meadow Green
    character       = "#98C379", -- Meadow Green
    variable        = "#E8DFD8", -- Warm Mountain Mist
    builtin         = "#38BDF8", -- Electric Cyan
    parameter       = "#E8DFD8", -- Warm Mountain Mist
    property        = "#8EA0C2", -- Soft Dusk Indigo (Balanced blue-gray for properties)
    preproc         = "#B8835A", -- Timber Brown
    special         = "#A3F853", -- Neon Lime (\n, %d string escapes)
    fn              = "#38BDF8", -- Light Electric Cyan
    keyword         = "#FF9E64", -- Warm Apricot Orange
    macro           = "#B8835A", -- Timber Brown
    operator        = "#F76C6C", -- Coral Red Punctuation & Symbols
    delimiter       = "#F76C6C", -- Coral Red Brackets & Punctuation
    type            = "#FACC15", -- Sunlight Gold / Yellow
    tag             = "#F76C6C", -- Coral Red
    identifier      = "#E8DFD8", -- Warm Mountain Mist
    statement       = "#FF9E64", -- Warm Apricot Orange
    conditional     = "#FF9E64", -- Warm Apricot Orange
    error           = "#F76C6C", -- Coral Red
    todo            = "#FF9E64", -- Warm Apricot Orange
  },
  popupmenu = {
    fg       = "#E8DFD8", -- Mountain Mist
    fg_sel   = "#FFFFFF", -- Pure White
    bg       = "#161210", -- Floating Window Backdrop
    bg_sel   = "#2B1E19", -- Dark Roasted Highlight
    kind     = "#38BDF8", -- Electric Cyan
    extra    = "#6B584C", -- Timber Ash
    bg_sbar  = "#1E1815", -- Dark Mahogany Accent
    bg_thumb = "#3E3029", -- Deep Mahogany Thumb
  },
  completion = {
    item       = "#E8DFD8", -- Mountain Mist
    match      = "#FF9E64", -- Apricot Orange Match
    detail     = "#6B584C", -- Timber Ash
    deprecated = "#6B584C", -- Timber Ash
    snippet    = "#E54888", -- Blossom Magenta
    fg         = "#A89A90", -- Weathered Stone
    accent     = "#FACC15", -- Sunlight Gold
    comment    = "#161210", -- Dark Float Base
  },
  treeview = {
    fg             = "#E8DFD8", -- Mountain Mist
    bg             = "#161210", -- Dark Float Base
    title          = "#FF9E64", -- Apricot Orange
    icon           = "#38BDF8", -- Electric Cyan
    folder         = "#B8835A", -- Timber Brown
    folder_open    = "#FF9E64", -- Apricot Orange Open Folder
    dir_name       = "#8EA0C2", -- Soft Dusk Indigo
    dir_icon       = "#8EA0C2", -- Soft Dusk Indigo
    file_name      = "#E8DFD8", -- Mountain Mist
    file_icon      = "#E8DFD8", -- Mountain Mist
    file_opened    = "#98C379", -- Meadow Green
    indent_marker = "#100C0A", -- Base Dark
    expander      = "#6B584C", -- Timber Ash
    root_name      = "#38BDF8", -- Electric Cyan
  },
  keymap = {
    key    = "#FF9E64", -- Apricot Orange
    group  = "#8EA0C2", -- Soft Dusk Indigo
    desc   = "#E8DFD8", -- Mountain Mist
    accent = "#B8835A", -- Timber Brown
    fg     = "#E54888", -- Blossom Magenta
    border = "#E8DFD8", -- Mountain Mist
  },
};

-- =============================================================================

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
      local default_section = S.defaults [section_key];

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
    return S.defaults;
  end;
  return create_spec_proxy (user_specs);
end


return S;
