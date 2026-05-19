vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

local lint_trigger_events = { "BufWritePost", "BufReadPost", "InsertLeave" }
local linters_by_ft = {
  eruby = { "erb_lint" },
  ghaction = { "actionlint" },
  markdown = { "markdownlint" },
  ruby = { "ruby", "standardrb" },
  scss = { "stylelint" },
}

local function debounce(ms, fn)
  local timer = vim.loop.new_timer()
  return function(...)
    local argv = { ... }
    timer:start(ms, 0, function()
      timer:stop()
      vim.schedule_wrap(fn)(unpack(argv))
    end)
  end
end

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

local function lint()
  -- Use nvim-lint's logic first:
  -- * checks if linters exist for the full filetype first
  -- * otherwise will split filetype by "." and add all those linters
  -- * this differs from conform.nvim which only uses the first filetype that has a formatter
  local names = nvim_lint._resolve_linter_by_ft(vim.bo.filetype)

  -- Create a copy of the names table to avoid modifying the original.
  names = vim.list_extend({}, names)

  -- Add fallback linters.
  if #names == 0 then
    vim.list_extend(names, nvim_lint.linters_by_ft["_"] or {})
  end

  -- Add global linters.
  vim.list_extend(names, nvim_lint.linters_by_ft["*"] or {})

  -- Filter out linters that don't exist or don't match the condition.
  names = vim.tbl_filter(function(name)
    return vim.tbl_contains(vim.tbl_keys(nvim_lint.linters), name)
  end, names)

  -- Run linters.
  if #names > 0 then
    nvim_lint.try_lint(names)
  end
end

vim.api.nvim_create_autocmd(lint_trigger_events, {
  group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
  callback = debounce(100, lint),
})
