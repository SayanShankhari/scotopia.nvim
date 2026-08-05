local default_configs = {
  terminal_colors = true,
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  inverse = true,
  contrast = "",
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
}


local M = {}

M.options = {
  transparent = false,
  dim_inactive = false,
  styles = {
    comments = { italic = true },
    keywords = { italic = false },
    functions = { bold = false },
  },
}

M.defaults = {
  transparent = false,
  italics = {
    comments = true,
    keywords = false,
  },
  dim_inactive = false,
}

M.options = vim.deepcopy (M.defaults)

function M.setup(opts)
  M.options = vim.tbl_deep_extend ('force', M.defaults, opts or {});
end


return M;
