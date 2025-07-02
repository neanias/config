vim.cmd("filetype plugin indent on")

-- Basics
vim.o.number = true
-- Needed for better colour support
vim.o.termguicolors = true
vim.o.signcolumn = "yes" -- Always show sign column

-- Indentation
local indent = 2
vim.o.autoindent = true
vim.o.breakindent = true
vim.o.copyindent = true
vim.o.expandtab = true -- Use spaces rather than tabs
vim.o.preserveindent = true
vim.o.shiftround = true
vim.o.shiftwidth = indent
vim.o.smartindent = true
vim.o.tabstop = indent

-- Searching
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true

-- Slightly better performance for redrawing
vim.o.hidden = true

-- Split to the right and below
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.splitkeep = "screen"

-- Shows matching bracket when inserting one...
vim.o.showmatch = true
-- ...for 2 tenths of a second
vim.o.mat = 2

-- Hide mode, since lualine shows us that anyway
vim.o.showmode = false
-- Confirm to save changes before exiting modified buffer
vim.o.confirm = true

-- Use Ripgrep
vim.o.grepprg = "rg --vimgrep"
vim.o.grepformat = "%f:%l:%c:%m"

-- Don't write swapfiles
vim.o.swapfile = false

-- Show leading spaces and other "hidden" chars
vim.o.list = true
vim.opt.listchars:append("lead:⋅,extends:…,precedes:…,nbsp:␣")

local leader = " "
vim.g.mapleader = leader
vim.g.maplocalleader = leader

-- Keep 8 lines of scrolloff visible where possible. (Shows next 8 lines as
-- approaching the bottom.)
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- Ignore generated files
vim.opt.wildignore = { "*.o", "*~", "*.pyc" }

-- Don't soft warp text if it's off the side of the window
vim.o.wrap = false
vim.o.linebreak = true

-- Set British English as the priority
vim.o.spelllang = "en_gb,en"

-- 100k lines of scrollback in terminal buffer:
vim.o.scrollback = -1

local neovim3_python_path = vim.loop.os_homedir() .. "/.pyenv/versions/neovim3/bin/python"
if vim.loop.fs_stat(neovim3_python_path) then
  vim.g.python3_host_prog = neovim3_python_path
end

-- Undo & backup options
local backups_path = vim.fn.stdpath("cache") .. "/backups"
vim.cmd("silent !mkdir " .. backups_path .. " > /dev/null 2>&1")
vim.o.undodir = backups_path
vim.o.undofile = true

-- Have the undotree be in a panel on the RHS
vim.g.undotree_WindowLayout = 3

-- Folding
-- Enable fold for nvim-ufo
vim.o.foldenable = true
-- Set high foldlevel for nvim-ufo
vim.o.foldlevel = 99
-- Start with all code unfolded
vim.o.foldlevelstart = 99
vim.o.foldcolumn = "0"
vim.o.fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:⏵]]
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldtext = ""

-- Status column
vim.opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]

-- Make builtin completion menus slightly transparent
vim.o.pumblend = 10
-- Make popup menu smaller
vim.o.pumheight = 10
-- Make floating windows slightly transparent
vim.o.winblend = 10

-- Diff options
vim.opt.diffopt = "internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram"
