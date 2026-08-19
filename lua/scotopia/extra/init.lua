local M = {}

-- Helper to write string content to a file in the extras/ directory
local function write_file (path, content)
  local file = io.open (path, "w");
  if not file then error ("Error writing file: " .. path) end;
  file:write (content);
  file:close();
end

local function get_project_root()
  -- 1. Gets the path of this current init.lua file
  local current_file = debug.getinfo (1, "S").source:sub(2);

  -- 2. Clean path if Neovim prefixes it
  current_file = vim.fn.fnamemodify (current_file, ":p");

  -- 3. Navigate up 4 levels to get out of: lua/theme/extra/init.lua -> project root
  -- (init.lua [1] -> extra [2] -> theme [3] -> lua [4] -> root)
  local project_root = vim.fn.fnamemodify (current_file, ":h:h:h:h");

  return project_root;
end

local extras = {
  alacritty = {
    ext = "toml",
    url = "https://github.com/alacritty/alacritty",
    label = "Alacritty",
    content = require ("lua.scotopia.extra.alacritty"),
  },
  kitty = {
    ext = "conf",
    url = "https://sw.kovidgoyal.net/kitty/conf.html",
    label = "Kitty",
    content = require ("lua.scotopia.extra.kitty"),
  },
--[[
  konsole = {
    ext = "colorscheme",
    url = "https://konsole.kde.org/",
    label = "Konsole",
    content = nil,
  },
--]]
};

function M.build()
  local root_dir = get_project_root();
  for extra_name, extra_info in pairs (extras) do
    if extra_info.content then
      local extra_file = extra_name .. "." .. extra_info.ext;
      vim.fn.mkdir ("extras", "p");
      write_file (root_dir .. "/extras/" .. extra_file, extra_info.content);
      print ("Generated extra: " .. extra_file);
    end
  end
end

--[[
local Util = require("tokyonight.util")

local M = {}

-- map of plugin name to plugin extension
--- @type table<string, {ext:string, url:string, label:string, subdir?: string, sep?:string}>
-- stylua: ignore
M.extras = {
  aerc             = { ext = "ini", url = "https://git.sr.ht/~rjarry/aerc/", label = "Aerc" },
  aider            = { ext = "yml", url = "https://aider.chat", label = "Aider" },
  alacritty        = { ext = "toml", url = "https://github.com/alacritty/alacritty", label = "Alacritty" },
  btop             = { ext = "theme", url = "https://github.com/aristocratos/btop", label = "Btop++" },
  delta            = { ext = "gitconfig", url = "https://github.com/dandavison/delta", label = "Delta" },
  discord          = { ext = "css", url ="https://betterdiscord.app/", label = "(Better-)Discord"},
  dunst            = { ext = "dunstrc", url = "https://dunst-project.org/", label = "Dunst" },
  eza              = { ext = "yml", url = "https://eza.rocks", label = "eza" },
  fish             = { ext = "fish", url = "https://fishshell.com/docs/current/index.html", label = "Fish" },
  fish_themes      = { ext = "theme", url = "https://fishshell.com/docs/current/interactive.html#syntax-highlighting", label = "Fish Themes" },
  foot             = { ext = "ini", url = "https://codeberg.org/dnkl/foot", label = "Foot" },
  fuzzel           = { ext = "ini", url = "https://codeberg.org/dnkl/fuzzel", label = "Fuzzel" },
  fzf              = { ext = "sh", url = "https://github.com/junegunn/fzf", label = "Fzf" },
  gemini_cli       = { ext = "json", url = "https://github.com/google-gemini/gemini-cli", label = "Gemini CLI" },
  ghostty          = { ext = "", url = "https://github.com/ghostty-org/ghostty", label = "Ghostty" },
  gitui            = { ext = "ron", url = "https://github.com/extrawurst/gitui", label = "GitUI" },
  gnome_terminal   = { ext = "dconf", url = "https://gitlab.gnome.org/GNOME/gnome-terminal", label = "GNOME Terminal" },
  helix            = { ext = "toml", url = "https://helix-editor.com/", label = "Helix" },
  iterm            = { ext = "itermcolors", url = "https://iterm2.com/", label = "iTerm" },
  ish              = { ext = "json", url = "https://ish.app", label = "iSH "},
  kitty            = { ext = "conf", url = "https://sw.kovidgoyal.net/kitty/conf.html", label = "Kitty" },
  konsole          = { ext = "colorscheme", url = "https://konsole.kde.org/", label = "Konsole" },
  lazygit          = { ext = "yml", url = "https://github.com/jesseduffield/lazygit", label = "Lazygit" },
  lua              = { ext = "lua", url = "https://www.lua.org", label = "Lua Table for testing" },
  opencode         = { ext = "json", url = "https://github.com/sst/opencode", label = "opencode" },
  pi               = { ext = "json", url = "https://github.com/badlogic/pi-mono", label = "pi" },
  prism            = { ext = "js", url = "https://prismjs.com", label = "Prism" },
  process_compose  = { ext = "yaml", url = "https://f1bonacc1.github.io/process-compose/", label = "process-compose" },
  qterminal        = { ext = "colorscheme", url = "https://github.com/lxqt/qterminal", label = "QTerminal" },
  slack            = { ext = "txt", url = "https://slack.com", label = "Slack" },
  sublime          = { ext = "tmTheme", url = "https://www.sublimetext.com/docs/themes", label = "Sublime Text" },
  spotify_player   = { ext = "toml", url = "https://github.com/aome510/spotify-player", label = "Spotify Player" },
  tailwindv4       = { ext = "css", url = "https://tailwindcss.com", label = "Tailwind CSS (v4)" },
  terminator       = { ext = "conf", url = "https://gnome-terminator.readthedocs.io/en/latest/config.html", label = "Terminator" },
  termux           = { ext = "properties", url = "https://termux.dev/", label = "Termux" },
  tilix            = { ext = "json", url = "https://github.com/gnunn1/tilix", label = "Tilix" },
  tmux             = { ext = "tmux", url = "https://github.com/tmux/tmux/wiki", label = "Tmux" },
  wezterm          = { ext = "toml", url = "https://wezfurlong.org/wezterm/config/files.html", label = "WezTerm" },
  windows_terminal = { ext = "json", url = "https://aka.ms/terminal-documentation", label = "Windows Terminal" },
  xfceterm         = { ext = "theme", url = "https://docs.xfce.org/apps/terminal/advanced", label = "Xfce Terminal" },
  xresources       = { ext = "Xresources", url = "https://wiki.archlinux.org/title/X_resources", label = "Xresources" },
  yazi             = { ext = "toml", url = "https://github.com/sxyazi/yazi", label = "Yazi" },
  vim              = { ext = "vim", url = "https://vimhelp.org/", label = "Vim", subdir = "colors", sep = "-" },
  vimium           = { ext = "css", url = "https://vimium.github.io/", label = "Vimium" },
  vivaldi          = { ext = "json", url = "https://vivaldi.com", label = "Vivaldi" },
  zathura          = { ext = "zathurarc", url = "https://pwmt.org/projects/zathura/", label = "Zathura" },
  zellij           = { ext = "kdl", url = "https://zellij.dev/", label = "Zellij" },
}
--]]


return M;
