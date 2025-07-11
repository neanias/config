-- bootstrap from github
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazy_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable", -- latest stable release
    "https://github.com/folke/lazy.nvim.git",
    lazy_path,
  })
end
vim.opt.runtimepath:prepend(lazy_path)

require("lazy").setup({
  defaults = {
    lazy = true,
    version = "*",
  },
  spec = {
    { import = "settings/plugins" },
  },
  dev = {
    patterns = jit.os:find("Windows") and {} or { "neanias" },
    path = "~/Programming/nvim-plugins",
  },
  install = {
    colorscheme = { "everforest", "habamax" },
  },
  checker = { enabled = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  rocks = {
    enabled = false,
  },
})

vim.keymap.set("n", "<leader>p", "<cmd>:Lazy<cr>", { desc = "Open Lazy" })
