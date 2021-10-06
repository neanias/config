local luasnip = require("luasnip")
local loader = require("luasnip.loaders.from_vscode")

luasnip.config.set_config({
  history = true,
})

loader.lazy_load()
