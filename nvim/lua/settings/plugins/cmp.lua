local M = {
  "hrsh7th/nvim-cmp",
  version = false,
  event = "InsertEnter",
  enabled = false,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "rafamadriz/friendly-snippets",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
}

local function has_words_before()
  if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

function M.config()
  local luasnip = require("luasnip")
  local cmp = require("cmp")

  local function tab_mapping(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_locally_jumpable() then
      luasnip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
    end
  end

  local function reverse_tab_mapping(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end

  cmp.setup({
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "path" },
      { name = "lazydev", group_index = 0 },
    }, {
      {
        name = "buffer",
        option = {
          get_bufnrs = function()
            local buffers = {}
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              buffers[vim.api.nvim_win_get_buf(win)] = true
            end
            return vim.tbl_keys(buffers)
          end,
        },
      },
    }),
    snippet = {
      expand = function(args)
        -- For `luasnip` user.
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(tab_mapping, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(reverse_tab_mapping, { "i", "s" }),
    }),
  })

  -- We need to setup cmp first hence this being after cmp.setup()
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
