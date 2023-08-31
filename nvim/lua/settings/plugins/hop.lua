return {
  "phaazon/hop.nvim",
  version = "~2.0.0",
  config = true,
  keys = {
    {
      "<leader><leader>w",
      mode = { "n", "x", "o" },
      function()
        local hop = require("hop")
        hop.hint_words({ direction = require("hop.hint").HintDirection.AFTER_CURSOR })
      end,
      desc = "Search for hop directions",
    },
    {
      "<leader><leader>b",
      mode = { "n", "x", "o" },
      function()
        local hop = require("hop")
        hop.hint_words({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR })
      end,
      desc = "Search for hop directions",
    },
    {
      "<leader><leader>f",
      mode = { "n", "x", "o" },
      function()
        require("hop").hint_char1()
      end,
      desc = "Search for hop directions to a certain char",
    },
    {
      "<leader><leader>l",
      mode = { "n", "x", "o" },
      function()
        require("hop").hint_lines_skip_whitespace()
      end,
      desc = "Hop to a specific line",
    },
    {
      "<leader><leader>p",
      mode = { "n", "x", "o" },
      function()
        require("hop").hint_patterns()
      end,
      desc = "Hop based on a pattern",
    },
  },
}
