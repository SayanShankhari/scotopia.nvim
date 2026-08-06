-- Controls built-in Vim diff mode (vim -d or :diffthis).
return function (specs, _)
  return {
    DiffAdd     = { bg = specs.diff.add_bg, fg = specs.diff.add_fg },
    DiffChange  = { bg = specs.diff.change_bg },
    DiffDelete  = { bg = specs.diff.delete_bg, fg = specs.diff.delete_fg },
    DiffText    = { bg = specs.diff.text_bg, fg = specs.diff.text_fg },
    DiffAdded   = { fg = specs.diff.add_fg },
    DiffRemoved = { fg = specs.diff.delete_fg },
    DiffChanged = { fg = specs.diff.change_fg },
  };
end
