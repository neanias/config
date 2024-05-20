return {
  "akinsho/bufferline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  version = "~4.6.0",
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      offsets = {
        {
          filetype = "NvimTree",
          text = function()
            return vim.fn.getcwd()
          end,
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
}
