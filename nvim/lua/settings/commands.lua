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
