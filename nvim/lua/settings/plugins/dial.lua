return {
  "monaqa/dial.nvim",
  event = "VeryLazy",
  version = false,
  keys = {
    {
      "<C-a>",
      function()
        return require("dial.map").manipulate("increment", "normal")
      end,
      expr = true,
      desc = "Increment",
    },
    {
      "<C-x>",
      function()
        return require("dial.map").manipulate("decrement", "normal")
      end,
      expr = true,
      desc = "Decrement",
    },
  },
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.constant.alias.bool,
        augend.semver.alias.semver,
      },
    })
  end,
}
