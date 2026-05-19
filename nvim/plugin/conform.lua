vim.pack.add({ "https://github.com/stevearc/conform.nvim", "https://github.com/mason-org/mason.nvim" })

require("conform").setup({
  formatters_by_ft = {
    js = { "eslint" },
    json = { "prettierd" },
    lua = { "stylua" },
    markdown = { "markdownlint", "prettierd", stop_after_first = true },
    python = {
      "black",
      "isort",
      "ruff",
    },
    ruby = { "standardrb" },
    scss = { "prettierd", "stylelint" },
    sh = {
      "shellcheck",
      "shfmt",
    },
    yaml = { "prettierd" },
    ["_"] = { "trim_whitespace" },
  },
  formatters = {
    injected = { ignore_errors = false },
    stylelint = {
      command = "bunx",
      args = { "stylelint", "--stdin", "--fix" },
    },
    standardrb = {
      command = "bundle",
      args = {
        "exec",
        "standardrb",
        "--fix",
        "-f",
        "quiet",
        "--stderr",
        "--stdin",
        "$FILENAME",
      },
    },
  },
})

vim.o.formatexpr = "v:lua.require('conform').formatexpr()"

vim.keymap.set("n", "<leader>lf", function()
  require("conform").format({ timeout_ms = 5000, lsp_format = "last" })
end, { desc = "Format the current buffer" })
