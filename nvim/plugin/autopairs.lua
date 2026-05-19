vim.api.nvim_create_autocmd("InsertEnter", {
  desc = "Autopairs plugin setup",
  once = true,
  callback = function()
    vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })
    require("nvim-autopairs").setup({ check_ts = true })
  end,
})
