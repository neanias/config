return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>lf",
      function()
        require("conform").format({ timeout_ms = 5000, lsp_format = "last" })
      end,
      desc = "Format the current buffer",
    },
  },
  opts = {
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
  },
  init = function()
    vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
  end,
}
