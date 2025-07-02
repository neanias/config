return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    image = { enabled = false },
    indent = { enabled = false },
    input = { enabled = true },
    lazygit = { enabled = false },
    notifier = { enabled = true },
    picker = {
      enabled = true,
      ui_select = true,
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
          },
        },
      },
    },
    quickfile = { enabled = false },
    scope = { enabled = true },
    scratch = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = true },
  },
  keys = {
    {
      "<leader>.",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle scratch buffer",
    },
    {
      "<leader>S",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select scratch buffer",
    },
    {
      "<leader>dps",
      function()
        Snacks.profiler.scratch()
      end,
      desc = "Profiler scratch buffer",
    },
    {
      "<leader>n",
      function()
        if Snacks.config.picker and Snacks.config.picker.enabled then
          Snacks.picker.notifications()
        else
          Snacks.notifier.show_history()
        end
      end,
      desc = "Notification history",
    },
    {
      "<leader>f<space>",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart find files",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find files",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers({
          win = {
            input = {
              keys = {
                ["<c-d>"] = { "bufdelete", mode = { "n", "i" } },
              },
            },
          },
        })
      end,
      desc = "Find buffers",
    },
    {
      "<leader>fd",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "Buffer diagnostics",
    },
    {
      "<leader>fD",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Project diagnostics",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>fG",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "Grep in open buffers",
    },
    {
      "<leader>fh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help pages",
    },
    {
      "<leader>fH",
      function()
        Snacks.picker.highlights()
      end,
      desc = "Vim highlights",
    },
    {
      "<leader>fl",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer lines",
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.registers()
      end,
      desc = "Registers",
    },
    {
      "<leader>fP",
      function()
        Snacks.picker.pick()
      end,
      desc = "Pick pickers",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recents({ filter = { cwd = true } })
      end,
      desc = "Recent files",
    },
    {
      "<leader>fR",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume",
    },
    {
      "<leader>ft",
      function()
        Snacks.picker.treesitter()
      end,
      desc = "Treesitter symbols",
    },
    {
      "<leader>fw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Grep for cursor word",
    },
    {
      "<leader>f:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command history",
    },
  },
}
