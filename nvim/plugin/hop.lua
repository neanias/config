vim.pack.add({ "https://github.com/smoka7/hop.nvim" })
require("hop").setup()

local mappings = {
  {
    { "n", "x", "o" },
    "<leader><leader>w",
    function()
      local hop = require("hop")
      hop.hint_camel_case({ direction = require("hop.hint").HintDirection.AFTER_CURSOR })
    end,
    { desc = "Search for hop directions" },
  },
  {
    { "n", "x", "o" },
    "<leader><leader>b",
    function()
      local hop = require("hop")
      hop.hint_camel_case({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR })
    end,
    { desc = "Search for hop directions" },
  },
  {
    { "n", "x", "o" },
    "<leader><leader>f",
    function()
      require("hop").hint_char1()
    end,
    { desc = "Search for hop directions to a certain char" },
  },
  {
    { "n", "x", "o" },
    "<leader><leader>l",
    function()
      require("hop").hint_lines_skip_whitespace()
    end,
    { desc = "Hop to a specific line" },
  },
  {
    { "n", "x", "o" },
    "<leader><leader>p",
    function()
      require("hop").hint_patterns()
    end,
    { desc = "Hop based on a pattern" },
  },
  {
    { "n", "x", "o" },
    "<leader><leader>t",
    function()
      require("hop-treesitter").hint_nodes()
    end,
    { desc = "Hop based on treesitter nodes" },
  },
  {
    { "n", "v", "o" },
    "t",
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
    { "n", "v", "o" },
    "T",
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
    { "n", "v", "o" },
    "f",
    function()
      local hop = require("hop")
      hop.hint_char1({
        direction = require("hop.hint").HintDirection.AFTER_CURSOR,
        current_line_only = true,
      })
    end,
  },
  {
    { "n", "v", "o" },
    "F",
    function()
      local hop = require("hop")
      hop.hint_char1({
        direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
        current_line_only = true,
      })
    end,
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping[1], mapping[2], mapping[3], mapping[4] or {})
end
