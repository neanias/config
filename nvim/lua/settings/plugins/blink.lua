local M = {
  "saghen/blink.cmp",
  lazy = false, -- lazy loading handled internally
  -- optional: provides snippets for the snippet source
  dependencies = "rafamadriz/friendly-snippets",

  -- use a release tag to download pre-built binaries
  version = "v0.*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = "super-tab" },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    sources = {
      completion = {
        enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
      },
      providers = {
        lsp = { fallback_for = { "lazydev" } },
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
      },
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      accept = {
        auto_brackets = { enabled = true },
      },
      menu = {
        draw = {
          treesitter = { "lsp" },
        },
      },
    },
  },
}

return M
