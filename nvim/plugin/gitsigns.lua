vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

local gs = require("gitsigns")
gs.setup({
  numhl = true,
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.nav_hunk("next")
      end)
      return "<Ignore>"
    end, { expr = true, desc = "Go to next hunk" })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.nav_hunk("prev")
      end)
      return "<Ignore>"
    end, { expr = true, desc = "Go to previous hunk" })

    map("n", "<leader>gS", gs.stage_hunk, { desc = "Stage the current hunk" })

    map("n", "<leader>gb", function()
      gs.blame_line({ full = true })
    end, { desc = "Blame line" })

    map("n", "<leader>glb", function()
      gs.toggle_current_line_blame()
    end, { desc = "Toggle showing inline blame" })

    map("n", "<leader>gw", function()
      gs.stage_buffer()
    end, { desc = "Stage the current buffer" })
  end,
})
