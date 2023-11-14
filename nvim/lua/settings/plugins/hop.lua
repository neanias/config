return {
  "smoka7/hop.nvim",
  config = true,
  keys = {
    {
      "<leader><leader>w",
      mode = { "n", "x", "o" },
      function()
        local hop = require("hop")
        hop.hint_camel_case({ direction = require("hop.hint").HintDirection.AFTER_CURSOR })
      end,
      desc = "Search for hop directions",
    },
    {
      "<leader><leader>b",
      mode = { "n", "x", "o" },
      function()
        local hop = require("hop")
        hop.hint_camel_case({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR })
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
    {
      "<leader><leader>t",
      mode = { "n", "x", "o" },
      function()
        require("hop-treesitter").hint_nodes()
      end,
      desc = "Hop based on treesitter nodes",
    },
    {
      "t",
      mode = { "n", "v", "o" },
      function()
        local hop = require("hop")
        hop.hint_char1({
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        })
      end,
    },
    {
      "T",
      mode = { "n", "v", "o" },
      function()
        local hop = require("hop")
        hop.hint_char1({
          direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        })
      end,
    },
    {
      "f",
      mode = { "n", "v", "o" },
      function()
        local hop = require("hop")
        hop.hint_char1({
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          current_line_only = true,
        })
      end,
    },
    {
      "F",
      mode = { "n", "v", "o" },
      function()
        local hop = require("hop")
        hop.hint_char1({
          direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
          current_line_only = true,
        })
      end,
    },
  },
}
