return {
  "windwp/nvim-autopairs",

  config = function()
    local npairs = require("nvim-autopairs")

    npairs.setup({ check_ts = true })
  end,
}
