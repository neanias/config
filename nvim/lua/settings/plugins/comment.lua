local M = {
  "numToStr/Comment.nvim",
  version = false,
  keys = {
    {
      "<leader>cc",
      mode = { "n", "v" },
      desc = "Line-wise comment"
    },
    {
      "<leader>cb",
      mode = { "n", "v" },
      desc = "Block-wise comment"
    },
  },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
}

function M.config()
  require("Comment").setup({
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    toggler = {
      line = "<leader>cc",
      block = "<leader>cb",
    },
    opleader = {
      line = "<leader>cc",
      block = "<leader>cb",
    },
  })
end

return M
