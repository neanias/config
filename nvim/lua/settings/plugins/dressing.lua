local M = {
  "stevearc/dressing.nvim",
}

function M.init()
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.ui.select = function(...)
    require("lazy").load({ plugins = { "dressing.nvim" } })
    return vim.ui.select(...)
  end
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.ui.input = function(...)
    require("lazy").load({ plugins = { "dressing.nvim" } })
    return vim.ui.input(...)
  end
end

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
