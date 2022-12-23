local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
}

function M.config()
  vim.opt.list = true
  vim.opt.listchars:append("lead:⋅")
  require("indent_blankline").setup({
    enabled = false,
    use_treesitter = true,
    show_current_context = true,
    show_current_context_start = true,
  })

  vim.keymap.set("n", "<leader>ig", "<cmd>:IndentBlanklineToggle<cr>", { desc = "Toggle indent guides" })
end

return M
