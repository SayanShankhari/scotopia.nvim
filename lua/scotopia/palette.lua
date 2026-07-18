local hsl_to_xrgb = require ("scotopia.color_spaces").hsl_to_xrgb;
local obj_dump = require ("scotopia.utils.obj_dump");

local P = {};


P.defaults = {
  red = hsl_to_xrgb (0, 100, 50),
  orange = hsl_to_xrgb (30, 100, 50),
  yellow = hsl_to_xrgb (60, 100, 50),
  chartreuse_green = hsl_to_xrgb (90, 100, 50),
  green = hsl_to_xrgb (120, 100, 50),
  spring_green = hsl_to_xrgb (150, 100, 50),
  cyan = hsl_to_xrgb (180, 100, 50),
  azure = hsl_to_xrgb (210, 100, 50),
  blue = hsl_to_xrgb (240, 100, 50),
  violet = hsl_to_xrgb (270, 100, 50),
  indigo = hsl_to_xrgb (275, 100, 50),
  magenta = hsl_to_xrgb (300, 100, 50),
  rose = hsl_to_xrgb (330, 100, 50),
}

-- Scopia Eye-Comfort Color Palette
P.colors = {
  -- Backgrounds (Ultra-dark room optimization, no pure blacks)
  -- bg             = "#0f0f0f", -- dark background
  -- bg             = "#2f2f2f", -- dark background
  -- bg             = color_spaces.hsl_to_xrgb (0, 0, 18.4), -- dark background
  bg             = hsl_to_xrgb (358, 35, 15.7),-- hsl_to_xrgb (200, 5.9, 10), -- dark background
  bg_dark        = "#000000", -- "#16161e", -- Darker slate for statuslines/trees
  bg_highlight   = "#2f334d", -- Subtle visual selection highlight

  -- Text & Foregrounds
  fg             = "#a9b1d6", -- Soft gray-white (reduces retina glare)
  fg_dark        = "#787c99", -- Muted text
  comment        = "#565f89", -- Low-contrast text for long-reading comfort

  -- Syntax Elements
  red            = "#f38ba8",-- "#f7768e", -- Error / Alert
  orange         = "#fe8019", -- Warm Orange (Keywords)
  yellow         = "#f9e2af", -- "#e0af68", -- Soft Warning Yellow
  green          = hsl_to_xrgb (120, 100, 50), --"#00ff00", -- "#a6e3a1", -- "#9ece6a", -- Earthy Green (Strings - easiest on the eyes)
  blue           = "#89b4fa", -- calm blue - Functions
  purple         = "#bb9af7", -- smooth purple - conditionals
  cyan           = "#94e2d5", -- sharp cyan - identifiers
  magenta        = "#f5c2e7", -- magenta - status messages
  gray           = "#6c7086", -- defaults
}


obj_dump (P);

return P;
