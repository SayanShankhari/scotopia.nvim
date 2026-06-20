local palette = require ("scotopia.palette");
local config = require ("scotopia.config");
local highlights = require ("scotopia.highlights");

local M = {}

-- module attached config
-- preset config
M.config = {
  transparent = false,
  italic_comments = true,
}

-- configurable setup function
function M.setup (user_choices)
  -- merge user configs
  M.config = vim.tbl_deep_extend ("force", M.config, user_choices or {});
  -- trigger to run colors/scopia.lua
  -- vim.cmd.colorscheme ("scotopia")
end

-- fallback default load function
function M.load()
  -- 1. reset existing...
  -- clear existing highlights
  if vim.g.colors_name then
    vim.cmd ("hi clear")
  end
  -- reset syntax engine
  if vim.fn.exists ("syntax_on") == 1 then
    vim.cmd ("syntax reset")
  end

  -- register the new theme identity
  vim.g.colors_name = "scotopia"

  -- Pull in components
--  local palette = require ("scotopia.palette");
--  local highlights = require ("scotopia.highlights");
  -- setup theme
  highlights.setup (palette.colors);

  local bg_color = config.transparent and "NONE" or "#1a1b26";

  -- paint the screen using final config
  vim.api.nvim_set_hl (0, "Normal", { fg = "#a9b1d6", bg = bg_color });
end



return M
