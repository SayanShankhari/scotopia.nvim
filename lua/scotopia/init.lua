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
local plugins    = require ("scotopia.plugins");
local configs    = require ("scotopia.configs");
local specs      = require ("scotopia.specs");
--local dump     = require ("scotopia.utils.obj_dump");

local M = {};

-- Default plugin configuration
M.config_options = configs.defaults;
M.color_specs = specs.defaults;
M.user_variant = nil;

-- Merge user options and initialize the plugin
--- @param user_configs table|nil User configuration "options"
--- @param user_colors table|nil Optional custom spec overrides
function M.setup (user_configs, user_colors)
  -- set the config user overrides
  local final_configs = type (user_configs) == "function" and user_configs () or (user_configs or {});
  M.config_options = vim.tbl_deep_extend ("force", M.config_options, final_configs);

  -- set the color-specs user overrides
  -- 2. generate safe 2-level sanitized specs proxy
  M.color_specs = specs.sanitize (user_colors);

  -- trigger to run colors/scopia.lua
  -- vim.cmd.colorscheme ("scotopia")
--  require("scotopia.config").setup(opts);
end

-- default load function
-- called by colors/scotopia.lua or :colorscheme scotopia
function M.load (variant_info)
  local variant_name = nil;
  if type (variant_info) == "table" and variant_info.variant == "mahogany" then
    M.color_specs = specs.mahogany;
    variant_name = variant_info.variant;
  end;

  -- 1. reset existing...
  -- clear existing highlights
  if vim.g.colors_name then
    vim.cmd ("hi clear");
  end
  -- reset syntax engine
  if vim.fn.exists ("syntax_on") == 1 then
    vim.cmd ("syntax reset");
  end

  -- register theme identity
  vim.g.colors_name = "scotopia";
  if type (variant_name) == "string" then
    vim.g.colors_name = "scotopia_" .. variant_name;
  end

  -- to enable many color features
  vim.o.termguicolors = true;

  -- dump (M.color_specs, "color_specs");
  -- dump (highlights (M.color_specs), "highlights");
  -- dump (plugins (M.color_specs), "plugins");

  -- combine all the highlight-groups
  local highlight_groups = vim.tbl_deep_extend (
    "force",
    {},
    highlights (M.color_specs, M.config_options) or {},
    plugins (M.color_specs, M.config_options) or {}
  );

  -- apply all the final highlight groups
  for hl_group, hl_spec in pairs (highlight_groups) do
    vim.api.nvim_set_hl (0, hl_group, hl_spec);
  end

-- 3. Set terminal colors if enabled in config
  if M.config_options.terminal_colors then
    vim.g.terminal_color_0 = M.color_specs.ui.bg
    vim.g.terminal_color_1 = M.color_specs.diag.error
    vim.g.terminal_color_2 = M.color_specs.diag.ok
    vim.g.terminal_color_3 = M.color_specs.diag.warn
    vim.g.terminal_color_4 = M.color_specs.ui.accent
    vim.g.terminal_color_5 = M.color_specs.syntax.keyword
    vim.g.terminal_color_6 = M.color_specs.syntax.special
    vim.g.terminal_color_7 = M.color_specs.ui.fg
  end
end

-- :lua require('scotopia').inspect_group('Normal')
function M.inspect_group (naam)
  print (vim.inspect (vim.api.nvim_get_hl (0, { name = naam })));
end


return M;
