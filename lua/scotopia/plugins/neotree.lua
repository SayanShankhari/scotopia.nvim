local specs = require ("scotopia.specs");

return {
  NeoTreeNormal         = { fg = specs.treeview.foreground, bg = specs.treeview.bakground },
  NeoTreeNormalNC       = { fg = specs.treeview.foreground, bg = specs.treeview.background },
  NeoTreeDirectoryName  = { fg = specs.treeview.dir_name },
  NeoTreeDirectoryIcon  = { fg = specs.treeview.dir_icon },
  NeoTreeFileName       = { fg = specs.treeview.file_name },
  NeoTreeFileIcon       = { fg = specs.treeview.file_icon },
  NeoTreeFileNameOpened = { fg = specs.treeview.file_opened },
  NeoTreeIndentMarker   = { fg = specs.treeview.indent_marker },
  NeoTreeExpander       = { fg = specs.treeview.expander },
  NeoTreeRootName       = { fg = specs.treeview.root_name, bold = true },
  NeoTreeGitAdded       = { fg = specs.diff.add },
  NeoTreeGitDeleted     = { fg = specs.diff.delete },
  NeoTreeGitModified    = { fg = specs.diff.modify },
  NeoTreeGitConflict    = { fg = specs.diff.conflict },
  NeoTreeGitUntracked   = { fg = specs.diff.untrack },
  NeoTreeGitIgnored     = { fg = specs.diff.ignore },
  NeoTreeGitStaged      = { fg = specs.diff.stage },
}
