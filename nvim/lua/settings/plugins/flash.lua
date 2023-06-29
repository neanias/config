return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    search = {
      incremental = true,
    },
  },
  keys = {
    {
      "<leader><leader>b",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump({
          search = { forward = false, wrap = false, multi_window = false },
        })
      end,
      desc = "Search backwards from current position",
    },
    {
      "<leader><leader>l",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump({
          search = { mode = "search", max_length = 0 },
          highlight = {
            label = { after = { 0, 0 } },
            matches = false,
          },
          pattern = "^\\s*\\S\\?", -- match non-whitespace at start plus any character (ignores empty lines)
        })
        vim.cmd([[normal! ^]])
      end,
      desc = "Hop to a specific line",
    },
    {
      "<leader><leader>p",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Search for a pattern",
    },
    {
      "<leader><leader>t",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Search in the treesitter tree",
    },
    {
      "<leader><leader>w",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump({
          search = {
            mode = function(str)
              return "\\<" .. str
            end,
          },
        })
      end,
      desc = "Search forwards from current position",
    },
  },
}
