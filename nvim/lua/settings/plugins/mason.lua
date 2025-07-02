local M = {
  "mason-org/mason.nvim",
  keys = {
    { "<leader>m", "<cmd>Mason<cr>", desc = "Open Mason" },
  },
  opts = {
    ensure_installed = {
      "actionlint",
      "black",
      "deno",
      "eslint_d",
      "isort",
      "luacheck",
      "markdownlint",
      "prettierd",
      "ruff",
      "selene",
      "shellcheck",
      "shfmt",
      "stylua",
      "woke",
    },
  },
}

function M.config(_, opts)
  require("mason").setup(opts)

  local mr = require("mason-registry")
  for _, tool in ipairs(opts.ensure_installed) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      p:install()
    end
  end

  require("mason-lspconfig").setup({
    automatic_installation = true,
  })
end

return M
