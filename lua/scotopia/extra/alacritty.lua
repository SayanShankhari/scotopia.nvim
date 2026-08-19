local palette = require ("scotopia.palette");

return string.format ([[
# Scotopia theme for Alacritty Terminal

[colors.primary]
background = "%s"
foreground = "%s"

[colors.cursor]
text   = "%s"
cursor = "%s"

[colors.normal]
black   = "%s"
red     = "%s"
green   = "%s"
yellow  = "%s"
blue    = "%s"
magenta = "%s"
cyan    = "%s"
white   = "%s"

[colors.bright]
black   = "%s"
red     = "%s"
green   = "%s"
yellow  = "%s"
blue    = "%s"
magenta = "%s"
cyan    = "%s"
white   = "%s"
]],
  palette.bg, palette.fg,
  palette.bg, palette.fg,
  palette.black, palette.red, palette.green, palette.yellow, palette.blue, palette.magenta, palette.cyan, palette.white,
  palette.bright_black or palette.black, palette.bright_red or palette.red, palette.bright_green or palette.green,
  palette.bright_yellow or palette.yellow, palette.bright_blue or palette.blue, palette.bright_magenta or palette.magenta,
  palette.bright_cyan or palette.cyan, palette.bright_white or palette.white
);
