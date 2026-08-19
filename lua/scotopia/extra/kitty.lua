local palette = require ("scotopia.palette");

return string.format ([[
# vim:ft=kitty

## name: ${_style_name}
## license: MIT
## author: Sayan Shankhari
## upstream: ${_upstream_url}


foreground            %s
background            %s
selection_foreground  %s
selection_background  %s
cursor                %s
cursor_text_color     %s

# Black
color0  %s
color8  %s

# Red
color1  %s
color9  %s

# Green
color2  %s
color10 %s

# Yellow
color3  %s
color11 %s

# Blue
color4  %s
color12 %s

# Magenta
color5  %s
color13 %s

# Cyan
color6  %s
color14 %s

# White
color7  %s
color15 %s
]],
  palette.fg, palette.bg,
  palette.bg, palette.fg,
  palette.fg, palette.bg,
  palette.black, palette.bright_black or palette.black,
  palette.red, palette.bright_red or palette.red,
  palette.green, palette.bright_green or palette.green,
  palette.yellow, palette.bright_yellow or palette.yellow,
  palette.blue, palette.bright_blue or palette.blue,
  palette.magenta, palette.bright_magenta or palette.magenta,
  palette.cyan, palette.bright_cyan or palette.cyan,
  palette.white, palette.bright_white or palette.white
);
