local wk = require("which-key")
local util = require("utils")
local gs = require("gitsigns")
local hop = require("hop")
local hop_hint = require("hop.hint")
local neotest = require("neotest")
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")

wk.setup({
  show_help = false,
  spelling = {
    enabled = true,
    suggestions = 20,
  },
  key_labels = {
    ["<leader>"] = "SPC",
  },
})

-- General mappings
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
  },

  Q = {
    util.close_window_or_kill_buffer,
    "Smart close the window or close the buffer",
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

  w = {
    util.strip_whitespace,
    "Strips trailling whitespace from the buffer",
    silent = true,
  },
  f = {
    name = "+Telescope",
    b = { "<cmd>Telescope buffers<cr>", "Find recent buffers" },
    d = { "<cmd>Telescope dir find_files<cr>", "Find files in dir" },
    f = { "<cmd>Telescope find_files<cr>", "Find files" },
    g = { "<cmd>Telescope live_grep<cr>", "Grep through the project dir" },
    h = { "<cmd>Telescope help_tags<cr>", "Search for help tags" },
    j = { "<cmd>Telescope jumplist<cr>", "Search through jumplist" },
    l = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search through lines in the buffer" },
    o = {
      function()
        telescope_builtin.oldfiles({ only_cwd = true })
      end,
      "Search through recently opened files",
    },
    -- This is still Lua as it might be lazily loaded
    p = {
      telescope.extensions.neoclip.default,
      "Search through the clipboard to reassign the current paste",
    },
    s = { "<cmd>Telescope search_history<cr>", "Lists recent search history" },
    t = { "<cmd>Telescope treesitter<cr>", "Search through treesitter tags" },
    w = { require("telescope-tabs").list_tabs, "Search tabs" },
  },

  g = {
    name = "+git",
    s = { ":tab Git<cr>", "Open Fugitive viewer" },
    c = {
      ":tab Git commit<cr>",
      "Open Fugitive commit dialog",
    },
    w = {
      gs.stage_buffer,
      "Stage the current buffer",
    },
    S = {
      gs.stage_hunk,
      "Stage the current hunk",
    },
    b = {
      function()
        gs.blame_line({ full = true })
      end,
      "Blame line",
    },
    lb = {
      function()
        gs.toggle_current_blame_line()
      end,
      "Toggle showing inline blame",
    },
  },

  -- Neotest
  t = {
    name = "+test",
    f = {
      function()
        neotest.run.run(vim.fn.expand("%"))
      end,
      "Run the whole test file",
    },
    t = {
      function()
        neotest.run.run()
      end,
      "Runs the nearest test",
    },
    x = {
      function()
        neotest.run.stop()
      end,
      "Stop the test",
    },
    s = {
      function()
        neotest.summary.toggle()
      end,
      "Toggle the summary window",
    },
    a = {
      function()
        neotest.run.run(vim.fn.getcwd())
      end,
      "Run the full test suite, presuming that vim's directory is the same as the project root.",
    },
    n = {
      function()
        neotest.jump.next()
      end,
      "Jump to the next test",
    },
    p = {
      function()
        neotest.jump.prev()
      end,
      "Jump to the previous test",
    },
  },

  -- UndoTree
  u = { "<Cmd>UndotreeToggle<CR>", "Opens the UndoTree" },

  -- Trouble
  x = {
    name = "+Trouble",
    d = { "<cmd>Trouble document_diagnostics<cr>", "Show document LSP diagnostics in Trouble" },
    l = { "<cmd>Trouble loclist<cr>", "Open loclist in Trouble dialogue" },
    q = { "<cmd>Trouble quickfix<cr>", "Open quickfix list in Trouble" },
    t = { "<cmd>TroubleToggle<cr>", "Toggle Trougle window" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Show workspace LSP diagnostics in Trouble" },
    x = { "<cmd>Trouble<cr>", "Open Trouble dialogue" },
  },

  ["nz"] = {
    require("neo-zoom").neo_zoom,
    "Toggle NeoZoom window",
    nowait = true,
  },

  -- Hop
  ["<leader>"] = {
    name = "+hop",
    w = {
      function()
        hop.hint_words({ direction = hop_hint.HintDirection.AFTER_CURSOR })
      end,
      "Search for hop directions",
    },
    b = {
      function()
        hop.hint_words({ direction = hop_hint.HintDirection.BEFORE_CURSOR })
      end,
      "Search for hop directions",
    },
    f = { hop.hint_char1, "Search for hop directions to a certain char" },
    l = { hop.hint_lines_skip_whitespace, "Hop to a specific line" },
    p = { hop.hint_patterns, "Hop based on a pattern" },
  },
  d = { name = "+duck" },
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

wk.register({
  a = {
    { "<Plug>(EasyAlign)", "Start interactive EasyAlign for a motion/text object (e.g. gaip)" },
    { "<Plug>(EasyAlign)", "Start interactive EasyAlign in visual mode (e.g. vipga)", mode = "x" },
  },
  R = { "<cmd>Trouble lsp_references<cr>", "Reveal LSP references under cursor in Trouble" },
}, {
  prefix = "g",
})

-- SplitJoin
wk.register({
  j = { "<Cmd>SplitjoinSplit<CR>", "Smart split 2 lines using SplitJoin" },
  k = { "<Cmd>SplitjoinJoin<CR>", "Smart join 2 lines using SplitJoin" },
}, {
  prefix = "s",
})

-- Terminal mode
wk.register({
  ["<ESC>"] = { "<C-\\><C-n>" },
  ["<Leader><ESC>"] = { "<C-\\><C-n>" },
}, {
  mode = "t",
})
