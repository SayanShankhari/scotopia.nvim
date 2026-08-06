return function (specs, _)
  return {
    NeoTreeNormal             = { fg = specs.treeview.fg, bg = specs.treeview.bg },
    NeoTreeNormalNC           = { fg = specs.treeview.fg, bg = specs.treeview.bg },
    NeoTreeRootName           = { fg = specs.treeview.title, bold = true },
    NeoTreeDirectoryIcon      = { fg = specs.treeview.icon },
    NeoTreeDirectoryName      = { fg = specs.treeview.folder },
    NeoTreeSymbolicLinkTarget = { fg = specs.syntax.special },
    NeoTreeGitAdded           = { fg = specs.diff.add_fg },
    NeoTreeGitConflict        = { fg = specs.diag.error, bold = true },
    NeoTreeGitModified        = { fg = specs.diff.change_fg },
    NeoTreeGitDeleted         = { fg = specs.diff.delete_fg },
    NeoTreeFileName           = { fg = specs.treeview.file_name },
    NeoTreeFileIcon           = { fg = specs.treeview.file_icon },
    NeoTreeFileNameOpened     = { fg = specs.treeview.file_opened },
    NeoTreeIndentMarker       = { fg = specs.treeview.indent_marker },
    NeoTreeExpander           = { fg = specs.treeview.expander },
    NeoTreeGitUntracked       = { fg = specs.diff.untrack },
    NeoTreeGitIgnored         = { fg = specs.diff.ignore },
    NeoTreeGitStaged          = { fg = specs.diff.stage },
  };
end
