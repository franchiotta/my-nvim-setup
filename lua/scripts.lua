function open_or_create_terminal_buffer(buffer_name)
  if not pcall(vim.cmd, 'buffer' .. ' ' .. buffer_name)
  then
    vim.api.nvim_command('term')
    vim.api.nvim_buf_set_name(0, buffer_name)
  end
end

function delete_current_buffer()
  if vim.o.modified
  then
    vim.api.nvim_err_writeln('Cannot delete buffer, you have unsaved changes.')
  else
    vim.api.nvim_command('bp | sp | bn | bd')
  end
end

