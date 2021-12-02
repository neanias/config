local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<ESC>"] = actions.close,
      },
    },
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      mappings = {
        i = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
        },
        n = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
        },
      },
    },
  },
})

telescope.load_extension("fzf")

local wk = require("which-key")

wk.register({
  f = {
    name = "+Telescope",
    b = { "<cmd>Telescope buffers<cr>", "Find recent buffers" },
    f = { "<cmd>Telescope find_files<cr>", "Find files" },
    g = { "<cmd>Telescope live_grep<cr>", "Grep through the project dir" },
    h = { "<cmd>Telescope help_tags<cr>", "Search for help tags" },
    -- This is still Lua as it might be lazily loaded
    p = {
      "<cmd>lua require('telescope').extensions.neoclip.default()<cr>",
      "Search through the clipboard to reassign the current paste",
    },
    s = { "<cmd>Telescope search_history<cr>", "Lists recent search history" },
    t = { "<cmd>Telescope treesitter<cr>", "Search through treesitter tags" },
  },
}, {
  prefix = "<leader>",
  noremap = true,
})
