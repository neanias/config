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
      eruby = { "erb_format" },
      lua = { "stylua" },
      markdown = { { "markdownlint", "prettierd" } },
      python = {
        "black",
        "isort",
        "ruff",
      },
      ruby = { "standardrb" },
      sh = {
        "shellcheck",
        "shfmt",
      },
      ["_"] = { "trim_whitespace" },
    },
    formatters = {
      injected = { ignore_errors = false },
      standardrb = { command = "bin/standardrb" },
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
  end,
}
