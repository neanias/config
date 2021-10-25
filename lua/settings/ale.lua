-- ALE

vim.g.ale_linters = {
  typescript = { "tslint", "tsserver", "typecheck" },
  rust = { "cargo", "rls" },
  ruby = { "rubocop", "ruby", "brakeman" },
}

vim.g.ale_fixers = {
  lua = { "stylua" },
  ruby = { "rubocop" },
}

vim.g.ale_ruby_rubocop_executable = "bundle"

vim.g.ale_rust_rls_toolchain = "stable"

vim.g.ale_python_auto_pipenv = true
