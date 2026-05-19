vim.pack.add({ "https://github.com/johmsalas/text-case.nvim" })

local mappings = {
  {
    "crc",
    function()
      require("textcase").current_word("to_camel_case")
    end,
    { desc = "Convert to camelCase" },
  },
  {
    "crs",
    function()
      require("textcase").current_word("to_snake_case")
    end,
    { desc = "Convert to snake_case" },
  },
  {
    "cru",
    function()
      require("textcase").current_word("to_constant_case")
    end,
    { desc = "Convert to UPPER_CASE" },
  },
  {
    "crk",
    function()
      require("textcase").current_word("to_dash_case")
    end,
    { desc = "Convert to kebab-case" },
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set("n", mapping[1], mapping[2], mapping[3])
end
