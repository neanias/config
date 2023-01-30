local wk = require("which-key")
local utils = require("utils")
local gs = require("gitsigns")

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
    utils.close_window_or_kill_buffer,
    "Smart close the window or close the buffer",
  },
})

-- Surround mappings

-- Normal mode mappings
wk.register({
  w = {
    utils.strip_whitespace,
    "Strips trailing whitespace from the buffer",
    silent = true,
  },
  f = {
    name = "+Telescope",
    b = { "<cmd>Telescope buffers<cr>", "Find recent buffers" },
    d = { "<cmd>Telescope dir find_files<cr>", "Find files in dir" },
    f = { "<cmd>Telescope smart_open cwd_only=true<cr>", "Find files" },
    g = { "<cmd>Telescope live_grep<cr>", "Grep through the project dir" },
    h = { "<cmd>Telescope help_tags<cr>", "Search for help tags" },
    j = { "<cmd>Telescope jumplist<cr>", "Search through jumplist" },
    l = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search through lines in the buffer" },
    o = { "<cmd>Telescope oldfiles only_cwd=true<cr>", "Search through recently opened files" },
    p = { "<cmd>Telescope neoclip<cr>", "Search through the clipboard to reassign the current paste" },
    s = { "<cmd>Telescope search_history<cr>", "Lists recent search history" },
    t = { "<cmd>Telescope treesitter<cr>", "Search through treesitter tags" },
    w = { "<cmd>Telescope telescope-tabs list_tabs<cr>", "Search tabs" },
  },

  g = {
    name = "+git",
    D = { "<cmd>DiffviewFileHistory %<cr>", "Open file history for current file" },
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
    c = { ":tab Git commit<cr>", "Open Fugitive commit dialog" },
    d = { "<cmd>DiffviewOpen -uno<cr>", "Open diffview" },
    lb = {
      function()
        gs.toggle_current_line_blame()
      end,
      "Toggle showing inline blame",
    },
    s = {
      ":tab Git<cr>",
      "Open Fugitive viewer",
    },
    w = {
      gs.stage_buffer,
      "Stage the current buffer",
    },
  },

  r = {
    name = "+refactoring",
  },
  t = {
    name = "+test",
  },

  -- UndoTree
  u = { "<Cmd>UndotreeToggle<CR>", "Opens the UndoTree" },

  -- Trouble
  x = {
    name = "+Trouble",
    d = { "<cmd>Trouble document_diagnostics<cr>", "Show document LSP diagnostics in Trouble" },
    l = { "<cmd>Trouble loclist<cr>", "Open loclist in Trouble dialogue" },
    q = { "<cmd>Trouble quickfix<cr>", "Open quickfix list in Trouble" },
    t = { "<cmd>TroubleToggle<cr>", "Toggle Trouble window" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Show workspace LSP diagnostics in Trouble" },
    x = { "<cmd>Trouble<cr>", "Open Trouble dialogue" },
  },

  -- Hop
  ["<leader>"] = {
    name = "+hop",
    w = {
      function()
        local hop = require("hop")
        hop.hint_words({ direction = require("hop.hint").HintDirection.AFTER_CURSOR })
      end,
      "Search for hop directions",
    },
    b = {
      function()
        local hop = require("hop")
        hop.hint_words({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR })
      end,
      "Search for hop directions",
    },
    f = {
      function()
        require("hop").hint_char1()
      end,
      "Search for hop directions to a certain char",
    },
    l = {
      function()
        require("hop").hint_lines_skip_whitespace()
      end,
      "Hop to a specific line",
    },
    p = {
      function()
        require("hop").hint_patterns()
      end,
      "Hop based on a pattern",
    },
  },

  d = { name = "+duck" },
}, {
  prefix = "<leader>",
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

-- Terminal mode
wk.register({
  ["<ESC>"] = { "<C-\\><C-n>" },
  ["<Leader><ESC>"] = { "<C-\\><C-n>" },
}, {
  mode = "t",
})
