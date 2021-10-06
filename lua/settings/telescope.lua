local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-t>"] = trouble.open_with_trouble,
        ["<ESC>"] = actions.close,
      },
      n = { ["<C-t>"] = trouble.open_with_trouble },
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

local wk = require("which-key")

wk.register({
  f = {
    name = "+file",
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
