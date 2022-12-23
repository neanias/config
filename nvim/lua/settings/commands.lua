-- create directories when needed, when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  command = [[call mkdir(expand('<afile>:p:h'), 'p')]],
})

-- windows to close with "q"
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "startuptime", "qf", "lspinfo", "checkhealth" },
  command = [[nnoremap <buffer><silent> q :close<CR>]],
  desc = "Remaps q to close this buffer type",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "man",
  command = [[nnoremap <buffer><silent> q :quit<CR>]],
  desc = "Remaps q to close man pages",
})

-- Set the syntax for .rbapi files to be Ruby
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", "BufReadPost" }, {
  pattern = "*.rbapi",
  command = [[set syntax=ruby]],
})

-- Highlight yanked text after yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ on_visual = false, timeout = 300 })
  end,
})

-- Strip trailing whitespace in Python and Ruby files
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.py", "*.rb" },
  callback = require("utils").strip_whitespace,
})

vim.cmd([[autocmd TermOpen term://* startinsert]])

-- Enable Ctrl-R pasting in the Telescope prompt
local telescope_augroup_id = vim.api.nvim_create_augroup("telescope", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = telescope_augroup_id,
  pattern = "TelescopePrompt",
  callback = function()
    vim.keymap.set("i", "<C-R>", "<C-R>", { silent = true, buffer = true })
  end,
})
