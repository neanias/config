local M = {
  "numToStr/Comment.nvim",
  version = false,
  keys = {
    { "<leader>cc", mode = { "n", "v" } },
    { "<leader>cb", mode = { "n", "v" } },
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
