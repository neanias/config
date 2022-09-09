vim.cmd("filetype plugin indent on")

-- Basics
vim.opt.number = true
vim.opt.autoindent = true
vim.opt.smartindent = true
-- Needed for better colour support
vim.opt.termguicolors = true

-- Use spaces
vim.opt.expandtab = true
local indent = 2
vim.opt.tabstop = indent
vim.opt.shiftwidth = indent

-- Is this needed?
-- vim.cmd("runtime macros/matchit.vim")

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Slightly better performance for redrawing
vim.opt.lazyredraw = true
vim.opt.hidden = true

-- Split to the right and below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Shows matching bracket when inserting one
vim.opt.showmatch = true
-- For 2 for tenths of a second
vim.opt.mat = indent

-- Don't write swapfiles
vim.opt.swapfile = false

local leader = " "
vim.g.mapleader = leader
vim.g.maplocalleader = leader

-- Keep 8 lines of scrolloff visible where possible. (Shows next 8 lines as
-- approaching the bottom.)
vim.opt.scrolloff = 8

-- Ignore generated files
vim.opt.wildignore = { "*.o", "*~", "*.pyc" }

-- Don't soft warp text if it's off the side of the window
vim.opt.wrap = false

-- Set British English as the priority
vim.opt.spelllang = "en_gb,en"

-- Highlight yanked text after yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ on_visual = false, timeout = 300 })
  end,
})

local neovim3_python_path = vim.loop.os_homedir() .. "/.pyenv/versions/neovim3/bin/python"
if vim.loop.fs_stat(neovim3_python_path) then
  vim.g.python3_host_prog = neovim3_python_path
end
