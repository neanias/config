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

local silicon_utils = require("silicon.utils")
local group = vim.api.nvim_create_augroup("SiliconRefresh", { clear = true })
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  group = group,
  callback = function()
    silicon_utils.build_tmTheme()
    silicon_utils.reload_silicon_cache({ async = true })
  end,
  desc = "Reload silicon themes cache on colorscheme switch",
})
