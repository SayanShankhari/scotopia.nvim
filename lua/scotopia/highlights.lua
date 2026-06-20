local colors = require ("scotopia.palette").colors;
local config = require ("scotopia.config"); -- read the final config
local paint = require ("scotopia.utils").paint; -- grab the paint function

local M = {}

function M.setup ()
  -- base UI components
  paint ("Normal", { fg = colors.foreground, bg = colors.background })
  paint ("NormalFloat", { fg = colors.foreground, bg = colors.background })
  paint ("FloatBorder", { fg = colors.border, bg = colors.background })
  paint ("CursorLine", { bg = colors.selection })
  paint ("Visual", { bg = "#3b3f55" })
  paint ("Search", { fg = colors.background, bg = colors.orange })
  paint ("IncSearch", { fg = colors.background, bg = colors.orange })
  paint ("StatusLine", { fg = colors.foreground, bg = colors.selection })
  paint ("StatusLineNC", { fg = colors.comment, bg = colors.selection })
  paint ("VertSplit", { fg = colors.border })
  paint ("WinSeparator", { fg = colors.border })
  paint ("LineNr", { fg = colors.blue })
  paint ("CursorLineNr", { fg = colors.orange, bold = true })
  paint ("SignColumn", { bg = colors.background })
  paint ("Folded", { fg = colors.comment, bg = colors.selection })

  -- popup menu
  paint ("Pmenu", { fg = colors.foreground, bg = colors.background })
  paint ("PmenuSel", { fg = colors.background, bg = colors.orange })
  paint ("PmenuSbar", { bg = colors.selection })
  paint ("PmenuThumb", { bg = colors.orange })

  -- standard Syntax-highlights
  paint ("Comment", { fg = colors.comment, italic = true })
  paint ("Constant", { fg = colors.magenta })
  paint ("String", { fg = colors.green })
  paint ("Identifier", { fg = colors.cyan })
  paint ("Function", { fg = colors.yellow, bold = true, italic = true })
  paint ("Statement", { fg = colors.purple })
  paint ("Conditional", { fg = colors.purple })
  paint ("Repeat", { fg = colors.purple })
  paint ("Operator", { fg = colors.cyan })
  paint ("Keyword", { fg = colors.orange, bold = true })
  paint ("PreProc", { fg = colors.yellow })
  paint ("Type", { fg = colors.cyan })
  paint ("Special", { fg = colors.magenta })
  paint ("Underlined", { underline = true })
  paint ("Error", { fg = colors.red, bold = true })
  paint ("Todo", { fg = colors.bg, bg = colors.yellow, bold = true })

  paint ("TSKeyword", { fg = colors.red })
  paint ("TSFunction", { fg = colors.yellow })
  paint ("TSVariable", { fg = colors.foreground })
  paint ("TSType", { fg = colors.cyan })

  -- Diagnostics
  paint ("DiagnosticError", { fg = colors.red })
  paint ("DiagnosticWarn", { fg = colors.warning })
  paint ("DiagnosticInfo", { fg = colors.green })
  paint ("DiagnosticHint", { fg = colors.hint })
  paint ("DiagnosticUnderlineError", { undercurl = true, sp = colors.red })
  paint ("DiagnosticUnderlineWarn", { undercurl = true, sp = colors.warning })
  paint ("DiagnosticUnderlineInfo", { undercurl = true, sp = colors.green })
  paint ("DiagnosticUnderlineHint", { undercurl = true, sp = colors.hint })
  paint ("DiagnosticUnderline", { undercurl = true, sp = colors.hint })

  -- Neo-tree
  paint ("NeoTreeNormal", { fg = colors.foreground, bg = colors.bakground })
  paint ("NeoTreeNormalNC", { fg = colors.foreground, bg = colors.background })
  paint ("NeoTreeDirectoryName", { fg = colors.blue })
  paint ("NeoTreeDirectoryIcon", { fg = colors.blue })
  paint ("NeoTreeFileName", { fg = colors.foreground })
  paint ("NeoTreeFileIcon", { fg = colors.foreground })
  paint ("NeoTreeFileNameOpened", { fg = colors.green })
  paint ("NeoTreeIndentMarker", { fg = colors.comment })
  paint ("NeoTreeExpander", { fg = colors.comment })
  paint ("NeoTreeRootName", { fg = colors.blue, bold = true })
  paint ("NeoTreeGitAdded", { fg = colors.green })
  paint ("NeoTreeGitDeleted", { fg = colors.red })
  paint ("NeoTreeGitModified", { fg = colors.yellow })
  paint ("NeoTreeGitConflict", { fg = colors.orange })
  paint ("NeoTreeGitUntracked", { fg = colors.comment })
  paint ("NeoTreeGitIgnored", { fg = colors.comment })
  paint ("NeoTreeGitStaged", { fg = colors.green })

  -- --- Treesitter Standard Captures (Modern Neovim parsing) ---
  paint ("@variable", { fg = colors.fg })
  paint ("@keyword", { fg = colors.orange, bold = true })
  paint ("@function", { fg = colors.blue })
  paint ("@string", { fg = colors.green })
  paint ("@comment", { fg = colors.comment, italic = true })
end

return M
