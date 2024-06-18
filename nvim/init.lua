require("settings.options")
require("settings.lazy")

-- After we've loaded the plugins, run the settings
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("settings.autocommands")
    require("settings.user_commands")
    require("settings.mappings")
  end,
})
