vim.pack.add({ { src = "https://github.com/akinsho/bufferline.nvim", version = vim.version.range("*") } })
require("bufferline").setup({
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
})
