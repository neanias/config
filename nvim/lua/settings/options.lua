vim.cmd("filetype plugin indent on")

-- Basics
vim.opt.number = true
vim.opt.autoindent = true
vim.opt.smartindent = true
-- Needed for better colour support
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes" -- Always show sign column

-- Use spaces
local indent = 2
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = indent
vim.opt.tabstop = indent

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Slightly better performance for redrawing
vim.opt.hidden = true

-- Split to the right and below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Shows matching bracket when inserting one...
vim.opt.showmatch = true
-- ...for 2 tenths of a second
vim.opt.mat = 2

-- Hide mode, since lualine shows us that anyway
vim.opt.showmode = false
-- Confirm to save changes before exiting modified buffer
vim.opt.confirm = true

-- Use Ripgrep
vim.opt.grepprg = "rg --vimgrep"

-- Don't write swapfiles
vim.opt.swapfile = false

-- Show leading spaces
vim.opt.list = true
vim.opt.listchars:append("lead:⋅")

local leader = " "
vim.g.mapleader = leader
vim.g.maplocalleader = leader

-- Keep 8 lines of scrolloff visible where possible. (Shows next 8 lines as
-- approaching the bottom.)
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Ignore generated files
vim.opt.wildignore = { "*.o", "*~", "*.pyc" }

-- Don't soft warp text if it's off the side of the window
vim.opt.wrap = false

-- Set British English as the priority
vim.opt.spelllang = "en_gb,en"

-- 100k lines of scrollback in terminal buffer:
vim.opt.scrollback = -1

local neovim3_python_path = vim.loop.os_homedir() .. "/.pyenv/versions/neovim3/bin/python"
if vim.loop.fs_stat(neovim3_python_path) then
  vim.g.python3_host_prog = neovim3_python_path
end

-- Undo & backup options
local backups_path = vim.fn.stdpath("config") .. "/backups"
vim.cmd("silent !mkdir " .. backups_path .. " > /dev/null 2>&1")
vim.o.undodir = backups_path
vim.o.undofile = true

-- Have the undotree be in a panel on the RHS
vim.g.undotree_WindowLayout = 3
