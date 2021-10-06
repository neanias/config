-- Custom RSpec extensions:
--   - match `it { is_expected.to ... }`
--   - allow `context` blocks to act as namespaces too
vim.g.ultest_custom_patterns = {
  ["ruby#rspec"] = {
    test = {
      [[\v^\s*it%(\(| )%("|'')(.*)%("|'')]],
      [[\v^\s*it\s*%(\{)\s*(.*?)\s*\}]],
    },
    namespace = {
      [[\v^\s*%(describe|context)%(\(| )%(\"|'')(.*)%(\"|'')]],
      [[\v^\s*%(describe|context)%(\(| )(\S+)]],
    },
  },
}

-- RSpec results can't be parsed out of a bigger run, so have to be run
-- separately. Doing this sequentially avoids DB contention for now.
vim.g.ultest_max_threads = 1
