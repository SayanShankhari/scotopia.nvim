local assert = require ("luassert");

--[[
before_each (
  function()
    if vim.g.colors_name then vim.cmd ("hi clear") end;
    if vim.g.syntax_on then vim.cmd ("syntax reset") end;
  end
);
--]]

describe (
  "Theme verification",
  function()
    before_each (
      function()
        vim.cmd ("highlight clear");
        --if vim.g.syntax_on then vim.cmd ("syntax reset") end;
        vim.cmd ("syntax reset");
      end
    );

    it (
      "loads colorscheme without throwing errors",
      function()
        local status_ok, _ = pcall (function() vim.cmd ("colorscheme scotopia") end);
        assert.is_true (status_ok, "Failed to execute :colorscheme scotopia");
      end
    );

    it (
      "applies essential highlight groups",
      function()
        vim.cmd ("colorscheme scotopia");

        -- Retrieve highlight group attributes
        local normal_hl  = vim.api.nvim_get_hl (0, { name = "Normal", link = false } );
        local comment_hl = vim.api.nvim_get_hl (0, { name = "Comment", link = false } );

        assert.is_not_nil (normal_hl.fg, "Normal foreground color should be set");
        assert.is_not_nil (comment_hl.fg, "Comment foreground color should be set");
      end
    );
    --[[
    it (
      "respects configuration overrides",
      function()
        local theme = require ("scotopia");

        -- Example test for transparent background option
        theme.setup ( { transparent = true } );
        vim.cmd ("colorscheme scotopia");

        local normal_hl = vim.api.nvim_get_hl (0, { name = "Normal", link = false } );
        assert.is_nil (normal_hl.bg, "Normal background should be nil when transparent = true");
      end
    );
    --]]
  end
);
