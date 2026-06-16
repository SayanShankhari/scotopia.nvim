local M = {}

function M.setup(colors)
  -- Helper function to quickly set highlight groups
  local function hl(group, options)
    vim.api.nvim_set_hl(0, group, options)
  end

  -- --- Neovim UI Component Highlights ---
  hl("Normal",       { fg = colors.fg, bg = colors.bg })
  hl("NormalFloat",  { fg = colors.fg, bg = colors.bg_dark })
  hl("CursorLine",   { bg = colors.bg_highlight })
  hl("ColorColumn",  { bg = colors.bg_highlight })
  hl("Visual",       { bg = colors.bg_highlight })
  hl("LineNr",       { fg = colors.comment })
  hl("CursorLineNr", { fg = colors.orange, bold = true })
  hl("SignColumn",   { bg = colors.bg })
  hl("Comment",      { fg = colors.comment, italic = true })

  -- --- Standard Syntax Highlights ---
  hl("Constant",     { fg = colors.cyan })
  hl("String",       { fg = colors.green })
  hl("Identifier",   { fg = colors.fg })
  hl("Function",     { fg = colors.blue, bold = true })
  hl("Statement",    { fg = colors.purple })
  hl("Conditional",  { fg = colors.purple })
  hl("Repeat",       { fg = colors.purple })
  hl("Operator",     { fg = colors.cyan })
  hl("Keyword",      { fg = colors.orange, bold = true })
  hl("PreProc",      { fg = colors.yellow })
  hl("Type",         { fg = colors.yellow })
  hl("Special",      { fg = colors.red })
  hl("Underlined",   { underline = true })
  hl("Error",        { fg = colors.red, bold = true })
  hl("Todo",         { fg = colors.bg, bg = colors.yellow, bold = true })
  
  -- --- Treesitter Standard Captures (Modern Neovim parsing) ---
  hl("@variable",    { fg = colors.fg })
  hl("@keyword",     { fg = colors.orange, bold = true })
  hl("@function",    { fg = colors.blue })
  hl("@string",      { fg = colors.green })
  hl("@comment",     { fg = colors.comment, italic = true })
end

return M
