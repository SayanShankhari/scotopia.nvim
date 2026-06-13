local M = {}

function M.load()
  -- Clear existing highlights and reset syntax engine
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end

  -- Register the theme identity
  vim.g.colors_name = "scopia"

  -- Pull in components and execute theme setup
  local palette = require("scopia.palette")
  local highlights = require("scopia.highlights")
  
  highlights.setup(palette.colors)
end

-- Fallback setup invocation
function M.setup(opts)
  -- You can expand this later to let users pass custom configuration options
end

return M
