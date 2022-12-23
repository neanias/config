local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "olimorris/neotest-rspec",
    "haydenmeade/neotest-jest",
  },
}

function M.config()
  require("neotest").setup({
    adapters = {
      require("neotest-rspec"),
      require("neotest-jest"),
    },
  })
end

return M
