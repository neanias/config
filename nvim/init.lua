-- Must be first so that it can handle caching
require("impatient")

-- NOTE: Can this plugins require be deferred to load at the end?
-- Does that need lazy loading of all plugins?
require("plugins")

require("utils")
require("general")

require("settings")
