return {
  "jose-elias-alvarez/null-ls.nvim",
  event = "BufReadPre",
  config = function()
    local nls = require("null-ls")
    nls.setup({
      debounce = 150,
      save_after_format = false,
      sources = {
        nls.builtins.code_actions.gitsigns,
        nls.builtins.diagnostics.flake8,
        nls.builtins.diagnostics.markdownlint,
        nls.builtins.formatting.black,
        nls.builtins.formatting.isort,
        nls.builtins.formatting.prettierd.with({
          filetypes = { "markdown" }, -- only runs `deno fmt` for markdown
        }),
        nls.builtins.formatting.rubocop.with({
          command = { "bin/rubocop" },
        }),
        nls.builtins.formatting.stylua,
      },
      root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", ".git"),
    })
  end,
}
