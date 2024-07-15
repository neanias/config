return {
  "johmsalas/text-case.nvim",
  main = "textcase",
  keys = {
    {
      "crc",
      function()
        require("textcase").current_word("to_camel_case")
      end,
      desc = "Convert to camelCase",
    },
    {
      "crs",
      function()
        require("textcase").current_word("to_snake_case")
      end,
      desc = "Convert to snake_case",
    },
    {
      "cru",
      function()
        require("textcase").current_word("to_constant_case")
      end,
      desc = "Convert to UPPER_CASE",
    },
    {
      "crk",
      function()
        require("textcase").current_word("to_dash_case")
      end,
      desc = "Convert to kebab-case",
    },
    {
      "crt",
      "<cmd>TextCaseOpenTelescope<CR>",
      desc = "Select text conversion",
    },
  },
}
