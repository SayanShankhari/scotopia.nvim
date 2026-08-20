local M = {}

local template = [[
# ------------------------------------------------
# Alacritty Colors
# Theme: Scotopia
# Source: https://github.com/alacritty/alacritty
# ------------------------------------------------

[colors.primary]
background = "${bg}"
foreground = "${fg}"

[colors.cursor]
text   = "${bg}"
cursor = "${fg}"

[colors.normal]
black   = "${black}"
red     = "${red}"
green   = "${green}"
yellow  = "${yellow}"
blue    = "${blue}"
magenta = "${magenta}"
cyan    = "${cyan}"
white   = "${white}"

[colors.bright]
black   = "${bright_black}"
red     = "${bright_red}"
green   = "${bright_green}"
yellow  = "${bright_yellow}"
blue    = "${bright_blue}"
magenta = "${magenta}"
cyan    = "${cyan}"
white   = "${white}"
]];

function M.generate (colors)
  return (template:gsub ("%${([%w_]+)}", function(key) return colors[key] or "" end));
end

return M;
