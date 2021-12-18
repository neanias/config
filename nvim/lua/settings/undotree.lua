local backups_path = vim.fn.stdpath("config") .. "/backups"
vim.cmd("silent !mkdir " .. backups_path .. " > /dev/null 2>&1")
vim.o.undodir = backups_path
vim.o.undofile = true

-- Have the undotree be in a panel on the RHS
vim.g.undotree_WindowLayout = 3

local wk = require("which-key")
wk.register({
  u = { "<Cmd>UndotreeToggle<CR>", "Opens the UndoTree" },
}, { prefix = "<leader>", noremap = true })
