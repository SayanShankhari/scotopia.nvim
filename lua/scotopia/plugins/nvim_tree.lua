-- Alternative to Neo-tree, it is still heavily used alongside neo-tree
return function (specs, _)
  return {
    NvimTreeNormal           = { fg = specs.treeview.fg, bg = specs.treeview.bg },
    NvimTreeFolderName       = { fg = specs.treeview.folder },
    NvimTreeOpenedFolderName = { fg = specs.treeview.folder_open },
    NvimTreeEmptyFolderName  = { fg = specs.ui.fg_dim },
    NvimTreeIndentMarker     = { fg = specs.ui.fg_gutter },
    NvimTreeRootFolder       = { fg = specs.treeview.title, bold = true },
    NvimTreeGitDirty         = { fg = specs.diff.change_fg },
    NvimTreeGitNew           = { fg = specs.diff.add_fg },
    NvimTreeGitDeleted       = { fg = specs.diff.delete_fg },
  };
end
