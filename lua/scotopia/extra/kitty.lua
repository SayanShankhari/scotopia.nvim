local M = {};

local template = [[
# vim:ft=kitty

## Name: Kitty Colors
## Theme: Scotopia
## Source: https://sw.kovidgoyal.net/kitty/conf.html

foreground            ${fg}
background            ${bg}
selection_foreground  ${bg}
selection_background  ${fg}
cursor                ${fg}
cursor_text_color     ${bg}

# Normal & Bright Colors
color0  ${black}
color8  ${bright_black}
color1  ${red}
color9  ${bright_red}
color2  ${green}
color10 ${bright_green}
color3  ${yellow}
color11 ${bright_yellow}
color4  ${blue}
color12 ${bright_blue}
color5  ${magenta}
color13 ${bright_magenta}
color6  ${cyan}
color14 ${bright_cyan}
color7  ${white}
color15 ${bright_white}
]];

function M.generate(colors)
  return (template:gsub ("%${([%w_]+)}", function(key) return colors[key] or "" end));
end

return M;
