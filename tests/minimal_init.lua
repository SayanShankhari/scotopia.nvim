-- Ensure global arg table exists to prevent Plenary busted crash
_G.arg = _G.arg or {};

local temp_dir    = vim.fn.stdpath ("data") .. "/site/pack/deps/start";
local plenary_dir = temp_dir .. "/plenary.nvim";

-- Auto-clone plenary.nvim for CI execution
if vim.fn.isdirectory (plenary_dir) == 0 then
  vim.fn.system (
    {
      -- "git clone --depth=1 https://github.com/nvim-lua/plenary.nvim ".. plenary_dir
      "git",
      "clone",
      "--depth=1",
      "https://github.com/nvim-lua/plenary.nvim",
      plenary_dir,
    }
  );
end

-- Add project root and plenary to runtimepath
vim.opt.rtp:append (".");
vim.opt.rtp:append (plenary_dir);

vim.cmd ("runtime! plugin/plenary.vim");
