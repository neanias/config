vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

local lint_trigger_events = { "BufWritePost", "BufReadPost", "InsertLeave" }
local linters_by_ft = {
  eruby = { "erb_lint" },
  ghaction = { "actionlint" },
  markdown = { "markdownlint" },
  ruby = { "ruby", "standardrb" },
  scss = { "stylelint" },
  typescript = { "eslint" },
}

vim.filetype.add({
  pattern = {
    [".*/.github/workflows/.*%.yml"] = "yaml.ghaction",
    [".*/.github/workflows/.*%.yaml"] = "yaml.ghaction",
  },
})

local nvim_lint = require("lint")
nvim_lint.linters_by_ft = linters_by_ft

-- As a rule of thumb, we want to use a bundle-specific version of Standard
local standardrb = nvim_lint.linters.standardrb
standardrb.cmd = "bundle"
standardrb.args = { "exec", "standardrb", "--stdin", "%:p", "--format", "json", "--force-exclusion" }

vim.api.nvim_create_autocmd(lint_trigger_events, {
  group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
  callback = function()
    vim.schedule(nvim_lint.try_lint)
  end,
})
