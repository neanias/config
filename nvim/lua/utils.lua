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

  vim.cmd("silent exe '%s/\\v\\s+$//e'")
  vim.cmd("silent nohlsearch")

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

require("which-key").register({
  ["Q"] = {
    closeWindowOrKillBuffer,
    "Smart close the window or close the buffer",
    silent = true,
    noremap = true,
  },

  ["<leader>w"] = {
    stripWhitespace,
    "Strips trailling whitespace from the buffer",
    silent = true,
    noremap = true,
  },
})

-- Strip trailing whitespace in Python and Ruby files
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.py", "*.rb" },
  callback = stripWhitespace,
})
