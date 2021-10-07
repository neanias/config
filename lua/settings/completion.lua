local luasnip = require("luasnip")
local cmp = require("cmp")

local function has_words_before()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function feedkey(key)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
end

local function tab_mapping(fallback)
  if vim.fn.pumvisible() == 1 then
    feedkey("<C-n>")
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  elseif has_words_before() then
    cmp.complete()
  else
    fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
  end
end

local function reverse_tab_mapping(fallback)
  if vim.fn.pumvisible() == 1 then
    feedkey("<C-p>")
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end

vim.o.completeopt = { "menuone", "noselect" }

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  snippet = {
    expand = function(args)
      -- For `luasnip` user.
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    -- ['<C-Space>'] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(tab_mapping, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(reverse_tab_mapping, { "i", "s" }),
  },
})

-- you need setup cmp first put this after cmp.setup()
require("nvim-autopairs.completion.cmp").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
  auto_select = true, -- automatically select the first item
  insert = false, -- use insert confirm behavior instead of replace
  map_char = { -- modifies the function or method delimiter by filetypes
    all = "(",
    tex = "{",
  },
})
