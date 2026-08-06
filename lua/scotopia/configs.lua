local C = {};

C.default_configs = {
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

C.options = {
  transparent = false,
  dim_inactive = false,
  styles = {
    comments = { italic = true },
    keywords = { italic = false },
    functions = { bold = false },
  },
}

C.defaults = {
  transparent = false,
  italics = {
    comments = true,
    keywords = false,
  },
  bold = {
    comments = false,
    keywords = true,
  },
  dim_inactive = false,
  terminal_colors = true,
  undercurl = true,
  override_specs = {},
}

C.options = vim.deepcopy (C.defaults)

function C.setup (opts)
  C.options = vim.tbl_deep_extend ('force', C.defaults, opts or {});
end

return C;
