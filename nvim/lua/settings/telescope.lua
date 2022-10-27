local telescope = require("telescope")
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<ESC>"] = actions.close,
        ["<C-U>"] = false,
      },
    },
  },
  pickers = {
    live_grep = {
      mappings = {
        i = {
          ["<C-T>"] = trouble.open_with_trouble,
        },
      },
    },
    buffers = {
      sort_lastused = true,
      mappings = {
        i = {
          ["<c-d>"] = actions.delete_buffer,
        },
      },
    },
  },
})

telescope.load_extension("fzf")
telescope.load_extension("dir")
telescope.load_extension("noice")

local telescope_augroup_id = vim.api.nvim_create_augroup("telescope", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = telescope_augroup_id,
  pattern = "TelescopePrompt",
  callback = function()
    vim.keymap.set("i", "<C-R>", "<C-R>", { silent = true, buffer = true })
  end,
})

local wk = require("which-key")

wk.register({
  f = {
    name = "+Telescope",
    b = { "<cmd>Telescope buffers<cr>", "Find recent buffers" },
    d = { "<cmd>Telescope dir find_files<cr>", "Find files in dir" },
    f = { "<cmd>Telescope find_files<cr>", "Find files" },
    g = { "<cmd>Telescope live_grep<cr>", "Grep through the project dir" },
    h = { "<cmd>Telescope help_tags<cr>", "Search for help tags" },
    j = { "<cmd>Telescope jumplist<cr>", "Search through jumplist" },
    o = { "<cmd>Telescope oldfiles cwd_only=true<cr>", "Search through recently opened files" },
    -- This is still Lua as it might be lazily loaded
    p = {
      telescope.extensions.neoclip.default,
      "Search through the clipboard to reassign the current paste",
    },
    s = { "<cmd>Telescope search_history<cr>", "Lists recent search history" },
    t = { "<cmd>Telescope treesitter<cr>", "Search through treesitter tags" },
    w = { require("telescope-tabs").list_tabs, "Search tabs" },
  },
}, {
  prefix = "<leader>",
  noremap = true,
})
