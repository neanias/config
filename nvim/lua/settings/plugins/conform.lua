return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>lf",
      function()
        require("conform").format({ lsp_fallback = true })
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
      ruby = {
        rubocop = { command = "bin/rubocop" },
      },
      sh = {
        "shellcheck",
        "shfmt",
      },
    },
    formatters = {
      injected = { ignore_errors = false },
    },
  },
  init = function ()
    vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
  end
}
