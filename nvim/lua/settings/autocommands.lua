--- Creates a namespaced autogroup
---@param name string a vim-acceptable group name (alphanumeric, underscored)
---@return number # The id of the new augroup
local function augroup(name)
  return vim.api.nvim_create_augroup("neanias_" .. name, { clear = true })
end

-- create directories when needed, when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- windows to close with "q"
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = { "help", "startuptime", "qf", "lspinfo", "checkhealth", "man" },
  desc = "Remaps q to close this buffer type",
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("spelling"),
  pattern = { "gitcommit", "markdown" },
  desc = "Enable spelling by default in prose files",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Highlight yanked text after yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ on_visual = false, timeout = 300 })
  end,
})

-- Strip trailing whitespace in Python and Ruby files
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("strip_whitespace"),
  pattern = { "*.py", "*.rb" },
  callback = require("utils").strip_whitespace,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup("terminal_config"),
  callback = function(event)
    vim.cmd("setlocal nonumber")
    vim.cmd("setlocal norelativenumber")
    vim.cmd("startinsert!")
    vim.bo[event.buf].buflisted = false
  end,
})

-- Enable Ctrl-R pasting in the Telescope prompt
local telescope_augroup_id = vim.api.nvim_create_augroup("telescope", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = telescope_augroup_id,
  pattern = "TelescopePrompt",
  callback = function()
    vim.keymap.set("i", "<C-R>", "<C-R>", { silent = true, buffer = true })
  end,
})

-- Update navic lazily in large files
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("lazy_update_navic"),
  callback = function()
    if vim.api.nvim_buf_line_count(0) > 10000 then
      vim.b.navic_lazy_update_context = true
    end
  end,
})

-- Resize splits when the window resizes
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Open file at the last position it was edited earlier",
  group = augroup("open_file_at_last_edit"),
  pattern = "*",
  command = [[silent! normal! g`"zv]],
})
