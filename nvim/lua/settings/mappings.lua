local wk = require("which-key")
local utils = require("utils")
local gs = require("gitsigns")

-- General mappings
wk.add({
  -- Create window splits more easily
  { "ss", "<C-W>s", desc = "Split a window vertically" },
  { "vv", "<C-W>v", desc = "Split a window vertically" },

  -- Move around windows more easily
  { "<C-h>", "<C-W>h", desc = "Move to the window on the left" },
  { "<C-j>", "<C-W>j", desc = "Move to the window below" },
  { "<C-k>", "<C-W>k", desc = "Move to the window above" },
  { "<C-l>", "<C-W>l", desc = "Move to the window on the right" },

  {
    "//",
    "<Cmd>noh<CR>",
    desc = "Clear the current search highlighting",
    remap = true,
  },
  { "0", "^", desc = "Move to the first instance of whitespace on this line" },
  { "<C-\\>", "<cmd>NvimTreeFindFile<CR>", desc = "Open the project tree and expose current file" },
  {
    "<leader>cc",
    "gcc",
    desc = "Comment current line",
    remap = true,
  },
  { "^", "0", desc = "Move to the first character on this line" },

  {
    "Q",
    utils.close_window_or_kill_buffer,
    desc = "Smart close the window or close the buffer",
  },
})

-- Surround mappings
wk.add({
  { '<leader>"', 'ysiw"', desc = "Wrap the word under the cursor in double quotes", remap = true },
  { "<leader>'", "ysiw'", desc = "Wrap the word under the cursor in single quotes", remap = true },
  {
    "<leader>(",
    "ysiw(",
    desc = "Wrap the word under the cursor in brackets, but with spaces around the word",
    remap = true,
  },
  { "<leader>)", "ysiw)", desc = "Wrap the word under the cursor in brackets", remap = true },
  {
    "<leader>[",
    "ysiw[",
    desc = "Wrap the word under the cursor in square brackets, but with spaces around the word",
    remap = true,
  },
  { "<leader>]", "ysiw]", desc = "Wrap the word under the cursor in square brackets", remap = true },
  { "<leader>`", "ysiw`", desc = "Wrap the word under the cursor in backticks", remap = true },
  {
    "<leader>{",
    "ysiw{",
    desc = "Wrap the word under the cursor in curly brackets, but with spaces around the word",
    remap = true,
  },
  { "<leader>}", "ysiw}", desc = "Wrap the word under the cursor in curly brackets", remap = true },
})

-- Normal mode mappings
wk.add({
  {
    "<leader>w",
    utils.strip_whitespace,
    desc = "Strips trailing whitespace from the buffer",
  },
  { "<leader>c", group = "comment" },
  { "<leader>d", group = "duck" },
  { "<leader>f", group = "Telescope" },

  { "<leader>g", group = "git" },
  { "<leader>gD", "<cmd>DiffviewFileHistory %<cr>", desc = "Open file history for current file" },
  { "<leader>gS", gs.stage_hunk, desc = "Stage the current hunk" },
  {
    "<leader>gb",
    function()
      gs.blame_line({ full = true })
    end,
    desc = "Blame line",
  },
  { "<leader>gc", ":tab Git commit<cr>", desc = "Open Fugitive commit dialog" },
  { "<leader>gd", "<cmd>DiffviewOpen -uno<cr>", desc = "Open diffview" },
  {
    "<leader>glb",
    function()
      gs.toggle_current_line_blame()
    end,
    desc = "Toggle showing inline blame",
  },
  { "<leader>gs", ":tab Git<cr>", desc = "Open Fugitive viewer" },
  { "<leader>gw", gs.stage_buffer, desc = "Stage the current buffer" },

  {
    "<leader>ii",
    "<Cmd>Inspect<CR>",
    desc = "Reveal treesitter capture groups under cursor",
  },

  { "<leader>s", group = "debug" },
  { "<leader>t", group = "test" },

  -- UndoTree
  { "<leader>u", "<Cmd>UndotreeToggle<CR>", desc = "Opens the UndoTree" },

  -- Trouble
  { "<leader>x", group = "Trouble" },
  { "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", desc = "Show document LSP diagnostics in Trouble" },
  { "<leader>xl", "<cmd>Trouble loclist<cr>", desc = "Open loclist in Trouble dialogue" },
  { "<leader>xq", "<cmd>Trouble quickfix<cr>", desc = "Open quickfix list in Trouble" },
  { "<leader>xt", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble window" },
  { "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", desc = "Show workspace LSP diagnostics in Trouble" },
  { "<leader>xx", "<cmd>Trouble<cr>", desc = "Open Trouble dialogue" },

  { "<leader><leader>", group = "hop" },
})

-- Terminal mode
wk.add({
  { "<ESC>", desc = "<C-\\><C-n>", mode = "t" },
  { "<Leader><ESC>", desc = "<C-\\><C-n>", mode = "t" },
})

-- Visual mode
wk.add({
  { "<leader>cc", "gc", desc = "Toggle comment for selection", mode = "v", remap = true },
})
