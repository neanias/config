-- Set the syntax for .rbapi files to be Ruby
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", "BufReadPost" }, {
  pattern = "*.rbapi",
  command = [[set syntax=ruby]],
})
