vim.pack.add({ "https://github.com/mason-org/mason.nvim", "https://github.com/mason-org/mason-lspconfig.nvim" })

vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Open Mason" })

local opts = {
  ensure_installed = {
    "actionlint",
    "black",
    "eslint_d",
    "isort",
    "markdownlint",
    "prettierd",
    "ruff",
    "selene",
    "shellcheck",
    "shfmt",
    "stylua",
  },
}

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
