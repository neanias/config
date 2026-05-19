-- Experimental UI2: floating cmdline and messages
vim.o.cmdheight = 0
require("vim._core.ui2").enable({
  enable = true,
  msg = {
    targets = {
      [""] = "msg",
      empty = "cmd",
      bufwrite = "msg",
      confirm = "cmd",
      emsg = "pager",
      echo = "msg",
      echomsg = "msg",
      echoerr = "pager",
      completion = "cmd",
      list_cmd = "pager",
      lua_error = "pager",
      lua_print = "msg",
      progress = "pager",
      rpc_error = "pager",
      quickfix = "msg",
      search_cmd = "cmd",
      search_count = "cmd",
      shell_cmd = "pager",
      shell_err = "pager",
      shell_out = "pager",
      shell_ret = "msg",
      undo = "msg",
      verbose = "pager",
      wildlist = "cmd",
      wmsg = "msg",
      typed_cmd = "cmd",
    },
    cmd = {
      height = 0.5,
    },
    dialog = {
      height = 0.5,
    },
    msg = {
      height = 0.3,
      timeout = 5000,
    },
    pager = {
      height = 0.5,
    },
  },
})

local skip_messages = {
  -- Write
  "%d+L, %d+B",

  -- Search
  -- "; after #%d+",
  -- "; before #%d+",
  "^[/?].*", -- searching up/down
  -- "E486: Pattern not found:",

  -- Edit
  "%d+ less lines",
  "%d+ fewer lines",
  "%d+ more lines",
  "%d+ change;",
  "%d+ line less;",
  "%d+ more lines?;",
  "%d+ fewer lines;?",
  "1 more line",
  "1 line less",
  "^Hunk %d+ of %d+$",
  "Already at newest change",
  "Already at oldest change",

  "%d lines yanked",
  "no lines in buffer",

  -- Undo/Redo
  "%d+ changes?;",
  " changes; before #",
  " changes; after #",
  " 1 change; before #",
  " 1 change; after #",

  -- Move lines
  " lines moved",
  " lines indented",
}

local normalized_content = function(src)
  if type(src) ~= "table" then
    return tostring(src or "")
  end

  local list = {}
  for _, chunk in ipairs(src) do
    if type(chunk) == "table" and chunk[2] then
      list[#list + 1] = chunk[2]
    end
  end

  return table.concat(list)
end

local ui2 = require("vim._core.ui2")
local msgs = require("vim._core.ui2.messages")
local original_set_pos = msgs.set_pos
msgs.set_pos = function(tgt)
  original_set_pos(tgt)
  if (tgt == "msg" or tgt == nil) and vim.api.nvim_win_is_valid(ui2.wins.msg) then
    pcall(
      vim.api.nvim_win_set_config,
      ui2.wins.msg,
      { relative = "editor", anchor = "NE", row = 1, col = vim.o.columns - 1, border = "rounded" }
    )
  end
end

local original_show_msg = msgs.msg_show

msgs.msg_show = function(kind, content, replace_last, history, append, id, trigger)
  if kind == "bufwrite" then
    return
  end

  local msg = normalized_content(content)

  for _, pattern in ipairs(skip_messages) do
    if msg:find(pattern) then
      return
    end
  end

  original_show_msg(kind, content, replace_last, history, append, id, trigger)
end

vim.pack.add({
  "https://github.com/rachartier/tiny-cmdline.nvim",
  "https://github.com/j-hui/fidget.nvim",
})

require("tiny-cmdline").setup({
  on_reposition = require("tiny-cmdline").adapters.blink,
  position = {
    x = "50%",
    y = "25%",
  },
})

require("fidget").setup({
  notification = {
    window = {
      avoid = {
        "NvimTree",
      },
    },
  },
})
