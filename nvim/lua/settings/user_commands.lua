-- Open a terminal in a new tab
vim.api.nvim_create_user_command("Tterm", function(input)
  local command = input.args
  if command == "" or command == nil then
    command = vim.env.SHELL
  end
  vim.cmd("tabnew term://" .. command)
end, {
  nargs = "*", -- Any number of args permitted
  desc = "Run the command in terminal in a new tab",
})

-- Copy text to clipboard using codeblock format ```{ft}{content}```
vim.api.nvim_create_user_command("CopyCodeBlock", function(opts)
  local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, true)
  local content = table.concat(lines, "\n")
  local result = string.format("```%s\n%s\n```", vim.bo.filetype, content)
  vim.fn.setreg("+", result)
  vim.notify("Text copied to clipboard")
end, { range = true })
