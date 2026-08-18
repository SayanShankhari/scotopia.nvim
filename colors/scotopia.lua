-- acts as fallback trigger for legacy runtime
-- to loads `:colorscheme scotopia` manually

-- set parameters
vim.g.colors_name = "scotopia";
vim.o.background = "dark";

-- expects no argument, runs automatically with existing configuration
-- applies highlight-groups and paints colors onto screen
-- runs every time the colorscheme is activated
require("scotopia").load()
