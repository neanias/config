-- need a map method to handle the different kinds of key maps
function map(mode, combo, mapping, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, combo, mapping, options)
end

local function atTipOfUndo()
  local tree = vim.fn.undotree()
  return tree.seq_last == tree.seq_cur
end

function stripWhitespace()
  -- Only do if the buffer is modifiable and we are at the tip of an undo tree
  if not (vim.bo.modifiable and atTipOfUndo()) then
    return
  end

  -- Keep the cursor position and these marks:
  local original_cursor = vim.fn.getcurpos()
  local first_changed = vim.fn.getpos("'[")
  local last_changed = vim.fn.getpos("']")

  vim.cmd("silent exe 's/\\v\\s+$//e'")

  vim.fn.setpos("']", last_changed)
  vim.fn.setpos("'[", first_changed)
  vim.fn.setpos(".", original_cursor)
end

function closeWindowOrKillBuffer()
  local window_number = vim.fn["winnr"]("$")
  local range_of_windows = vim.fn.range(1, window_number)
  local windows_attached_to_the_buffer = vim.fn.filter(range_of_windows, "winbufnr(v:val) == bufnr('%')")
  local number_of_windows_to_this_buffer = vim.fn.len(windows_attached_to_the_buffer)

  -- Never delete the tree buffer
  if vim.fn.matchstr(vim.fn.expand("%"), "Nvim") == "Nvim" then
    vim.cmd("wincmd c")
    return
  end

  if number_of_windows_to_this_buffer > 1 then
    vim.cmd("wincmd c")
  else
    vim.cmd("bdelete")
  end
end
