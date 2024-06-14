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
  ["<leader>cc"] = { "gcc", "Comment current line", remap = true },

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
  f = { name = "+Telescope" },
  c = { name = "+comment" },

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

  ["ii"] = { "<Cmd>Inspect<CR>", "Reveal treesitter capture groups under cursor" },

  s = { name = "+debug" },
  t = { name = "+test" },

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

  ["<leader>"] = {
    name = "+hop",
  },

  d = { name = "+duck" },
}, {
  prefix = "<leader>",
})

-- Terminal mode
wk.register({
  ["<ESC>"] = { "<C-\\><C-n>" },
  ["<Leader><ESC>"] = { "<C-\\><C-n>" },
}, {
  mode = "t",
})

-- Visual mode
wk.register({
  ["<leader>cc"] = { "gc", "Toggle comment for selection", remap = true },
}, {
  mode = "v",
})
