local M = {}

local function at_tip_of_undo()
  local tree = vim.fn.undotree()
  return tree.seq_last == tree.seq_cur
end

function M.strip_whitespace()
  -- Only do if the buffer is modifiable and we are at the tip of an undo tree
  if not (vim.bo.modifiable and at_tip_of_undo()) then
    return
  end

  -- Keep the cursor position and these marks:
  local save = vim.fn.winsaveview()

  vim.cmd("keepjumps keeppatterns silent exe '%s/\\v\\s+$//e'")
  vim.cmd("silent nohlsearch")

  vim.fn.winrestview(save)
end

function M.close_window_or_kill_buffer()
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

return M
