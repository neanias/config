local wk = require("which-key")

wk.setup()

wk.register({
  -- Create window splits more easily
  ["vv"] = { "<C-W>v", "Split a window vertically" },
  ["ss"] = { "<C-W>s", "Split a window vertically" },

  -- Move around windows more easily
  ["<C-j>"] = { "<C-W>j", "Move to the window below" },
  ["<C-k>"] = { "<C-W>k", "Move to the window above" },
  ["<C-h>"] = { "<C-W>h", "Move to the window on the left" },
  ["<C-l>"] = { "<C-W>l", "Move to the window on the right" },

  ["//"] = { ":noh<CR>", "Clear the current search highlighting", noremap = false },

  ["0"] = { "^", "Move to the first instance of whitespace on this line" },
  ["^"] = { "0", "Move to the first character on this line" },

  ["<C-\\>"] = {
    "<cmd>NvimTreeFindFile<CR>",
    "Open the project tree and expose current file",
    silent = true,
    noremap = true,
  },
})

-- Surround mappings

-- Normal mode mappings
wk.register({
  ['"'] = { 'ysiw"', "Wrap the word under the cursor in double quotes" },
  ["'"] = { "ysiw'", "Wrap the word under the cursor in single quotes" },
  ["("] = { "ysiw(", "Wrap the word under the cursor in brackets, but with spaces around the word" },
  [")"] = { "ysiw)", "Wrap the word under the cursor in brackets" },
  ["["] = { "ysiw[", "Wrap the word under the cursor in square brackets, but with spaces around the word" },
  ["]"] = { "ysiw]", "Wrap the word under the cursor in square brackets" },
  ["{"] = { "ysiw{", "Wrap the word under the cursor in curly brackets, but with spaces around the word" },
  ["}"] = { "ysiw}", "Wrap the word under the cursor in curly brackets" },
  ["`"] = { "ysiw`", "Wrap the word under the cursor in backticks" },
}, {
  prefix = "<leader>",
})

-- Visual mode mappings
wk.register({
  ["#"] = { 'c#{<C-r>}"}<ESC>', "Wrap the word under the cursor in a Ruby interpolation hash" },
  ['"'] = { 'c"<C-r>""<ESC>', "Wrap the word under the cursor in double quotes" },
  ["'"] = { "c'<C-r>\"'<ESC>", "Wrap the word under the cursor in single quotes" },
  ["("] = { 'c( <C-r>" )<ESC>', "Wrap the word under the cursor in brackets with spaces around the word" },
  [")"] = { 'c(<C-r>")<ESC>', "Wrap the word under the cursor in brackets" },
  ["["] = { 'c[ <C-r>" ]<ESC>', "Wrap the word under the cursor in square brackets with spaces around the word" },
  ["]"] = { 'c[<C-r>"]<ESC>', "Wrap the word under the cursor in square brackets" },
  ["{"] = { 'c{ <C-r>" }<ESC>', "Wrap the word under the cursor in curly brackets with spaces around the word" },
  ["}"] = { 'c{<C-r>"}<ESC>', "Wrap the word under the cursor in curly brackets" },
  ["`"] = { 'c`<C-r>"`<ESC>', "Wrap the word under the cursor in backticks" },
}, {
  prefix = "<leader>",
  mode = "v",
})

-- Easy Align

wk.register({
  a = { "<Plug>(EasyAlign)", "Start interactive EasyAlign for a motion/text object (e.g. gaip)" },
}, {
  prefix = "g",
})

wk.register({
  a = { "<Plug>(EasyAlign)", "Start interactive EasyAlign in visual mode (e.g. vipga)" },
}, {
  prefix = "g",
  mode = "x",
})
