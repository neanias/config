local M = {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
}

function M.config()
  require("dressing").setup({
    input = {
      win_options = {
        -- No transparency for input window
        winblend = 0,
      },
    },
    select = {
      telescope = require("telescope.themes").get_dropdown({}),
    },
  })
end

return M
