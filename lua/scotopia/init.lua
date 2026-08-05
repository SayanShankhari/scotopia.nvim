-- set up editor tab whitespace size
-- Force 2-space indentation automatically for all Lua files in this project
vim.api.nvim_create_autocmd ("FileType", {
  pattern = "lua",
  callback = function()
    vim.bo.tabstop = 2;      -- Width of a hard tab
    vim.bo.shiftwidth = 2;   -- Width of auto-indentation
    vim.bo.expandtab = true; -- Convert tabs into spaces
  end,
})


local highlights = require ("scotopia.highlights");
local plugins = require ("scotopia.plugins");

local M = {};

-- Default plugin configuration
M.config = require ("scotopia.config");

-- Merge user options and initialize the plugin
---@param opts table|nil User configuration "options"
function M.setup (opts, spec)
  local opts_tbl = type(opts) == "function" and opts (spec) or (opts or {});
  M.config = vim.tbl_deep_extend ("force", M.config, opts_tbl);
  -- trigger to run colors/scopia.lua
  -- vim.cmd.colorscheme ("scotopia")
--  require("scotopia.config").setup(opts);
end

-- default load function
-- :colorscheme ("scotopia")
function M.load()
  -- 1. reset existing...
  -- clear existing highlights
  if vim.g.colors_name then
    vim.cmd ("hi clear");
  end
  -- reset syntax engine
  if vim.fn.exists ("syntax_on") == 1 then
    vim.cmd ("syntax reset");
  end

  -- register the new theme identity
  vim.g.colors_name = "scotopia";
  vim.o.termguicolors = true;

  local groups = {};
  vim.tbl_extend ("force", groups, highlights(), plugins());
  -- apply all the final highlight groups
  for group, spec in pairs (groups) do
    vim.api.nvim_set_hl (0, group, spec);
  end
end

-- :lua require('scotopia').inspect_group('Normal')
function M.inspect_group (naam)
  print (vim.inspect (vim.api.nvim_get_hl (0, { name = naam })));
end

return M;
