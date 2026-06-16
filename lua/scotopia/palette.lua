local M = {}

-- Scopia Eye-Comfort Color Palette
M.colors = {
  -- Backgrounds (Ultra-dark room optimization, no pure blacks)
  bg             = "#0f0f0f" --"#1a1b26", -- Deep Tokyo Night base
  bg_dark        = "#000000" -- "#16161e", -- Darker slate for statuslines/trees
  bg_highlight   = "#2f334d", -- Subtle visual selection highlight

  -- Text & Foregrounds
  fg             = "#a9b1d6", -- Soft gray-white (reduces retina glare)
  fg_dark        = "#787c99", -- Muted text
  comment        = "#565f89", -- Low-contrast text for long-reading comfort

  -- Syntax Elements (Desaturated Gruvbox & Tokyo Night hybrids)
  red            = "#f7768e", -- Error / Alert
  orange         = "#fe8019", -- Warm Gruvbox Orange (Keywords)
  yellow         = "#e0af68", -- Soft Warning Yellow
  green          = "#9ece6a", -- Earthy Green (Strings - easiest on the eyes)
  blue           = "#7aa2f7", -- Calm Functions Blue
  purple         = "#bb9af7", -- Smooth Conditionals Purple
  cyan           = "#7dcfff", -- Sharp Identifiers Cyan
}

return M
