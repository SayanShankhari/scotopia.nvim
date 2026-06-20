local P = {};

-- Scopia Eye-Comfort Color Palette
P.colors = {
  -- Backgrounds (Ultra-dark room optimization, no pure blacks)
  bg             = "#0f0f0f", -- dark background
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
  green          = "#00ff00", -- "#a6e3a1", -- "#9ece6a", -- Earthy Green (Strings - easiest on the eyes)
  blue           = "#89b4fa", -- calm blue - Functions
  purple         = "#bb9af7", -- smooth purple - conditionals
  cyan           = "#94e2d5", -- sharp cyan - identifiers
  magenta        = "#f5c2e7", -- magenta - status messages
  gray           = "#6c7086", -- defaults
}

return P;
