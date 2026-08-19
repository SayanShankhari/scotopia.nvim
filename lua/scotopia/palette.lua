--local dump = require ("scotopia.utils.obj_dump");
local colorlib = require ("colorlib");
local catalogue = colorlib.catalogue;

local P = {};

--[[
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
  bg0 = '#0b0f14',
  bg1 = '#11161d',
  bg2 = '#1a2028',

  fg0 = '#d8dee9',
  fg1 = '#c0c8d8',
  fg2 = '#8b93a6',

  red    = '#f07178',
  orange = '#ff9e64',
  yellow = '#e6b450',
  green  = '#aad94c',
  cyan   = '#59c2ff',
  blue   = '#6dcbfa',
  purple = '#d2a6ff',
}
--]]

--[[
P.dark1 = {
  red    = utils.make_palette ("#D05C6B");
  orange = utils.make_palette ("#DD8C38");
  yellow = utils.make_palette ("#C8AA46");
  green  = utils.make_palette ("#54AF70");
  cyan   = utils.make_palette ("#47A8B5");
  blue   = utils.make_palette ("#5E95DE");
  purple = utils.make_palette ("#9074D1");
  pink   = utils.make_palette ("#D67EAE");
}
--]]
--[[
P.dark = {
  red    = color.generate_variants ("#D05C6B");
  orange = color.generate_variants ("#DD8C38");
  yellow = color.generate_variants ("#C8AA46");
  green  = color.generate_variants ("#54AF70");
  cyan   = color.generate_variants ("#47A8B5");
  blue   = color.generate_variants ("#5E95DE");
  purple = color.generate_variants ("#9074D1");
  pink   = color.generate_variants ("#D67EAE");
}
--]]

--[[
P.bg0 = '#0b0f14'
P.bg1 = '#11161d'
P.bg2 = '#1a2028'
P.fg0 = '#d8dee9'
P.fg1 = '#c0c8d8'
P.fg2 = '#8b93a6'
P.bg = "#2f2f2f"; -- dark background
P.fg = "#a9b1d6"; -- dark background
--]]

--[[
P.Color = {
  red          = color.generate_variants (color.hsl_to_xrgb (0, 100, 50)),
  orange       = color.generate_variants (color.hsl_to_xrgb (30, 100, 50)),
  yellow       = color.generate_variants (color.hsl_to_xrgb (60, 100, 50)),
  chartreuse   = color.generate_variants (color.hsl_to_xrgb (90, 100, 50)),
  green        = color.generate_variants (color.hsl_to_xrgb (120, 100, 50)),
  spring_green = color.generate_variants (color.hsl_to_xrgb (150, 100, 50)),
  cyan         = color.generate_variants (color.hsl_to_xrgb (180, 100, 50)),
  azure        = color.generate_variants (color.hsl_to_xrgb (210, 100, 50)),
  blue         = color.generate_variants (color.hsl_to_xrgb (240, 100, 50)),
  violet       = color.generate_variants (color.hsl_to_xrgb (270, 100, 50)),
  indigo       = color.generate_variants (color.hsl_to_xrgb (275, 100, 50)),
  magenta      = color.generate_variants (color.hsl_to_xrgb (300, 100, 50)),
  rose         = color.generate_variants (color.hsl_to_xrgb (330, 100, 50)),
}
--]]

-- background hierarchy
P.bg0 = catalogue.dark_gray
P.bg1 = catalogue.gray_900
P.bg2 = catalogue.gray_800

-- foreground hierarchy
P.fg0 = catalogue.white
P.fg1 = catalogue.gray_200
P.fg2 = catalogue.gray_500

-- accent colors
P.red    = catalogue.red
P.orange = catalogue.orange
P.yellow = catalogue.yellow
P.green  = catalogue.green
P.cyan   = catalogue.cyan
P.blue   = catalogue.blue
P.purple = catalogue.purple
P.pink   = catalogue.pink



P.fg = "#E8DFD8";
P.bg = "#0F1115";

P.black   = "#0F1115";
P.red     = "#F76C6C";
P.green   = "#98C379";
P.yellow  = "#FACC15";
P.blue    = "#8EA0C2";
P.magenta = "#E54888";
P.cyan    = "#38BDF8";
P.white   = "#E8DFD8";

P.bright_black   = nil;
P.bright_red     = nil;
P.bright_green   = nil;
P.bright_yellow  = nil;
P.bright_blue    = nil;
P.bright_magenta = nil;
P.bright_cyan    = nil;
P.bright_white   = nil;



-- TEST:

--local c = color.generate_variants ("#000000", { light_shift=0.5 });
--print (c.dark, c.base, c.light, c.pale);


--local dump = require ("colorlib.catalogue");
--dump (P);


return P;
