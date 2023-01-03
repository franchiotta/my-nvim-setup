function open_or_create_terminal_buffer(buffer_name)
  if not pcall(vim.cmd, 'buffer' .. ' ' .. buffer_name)
  then
    vim.api.nvim_command('term')
    vim.api.nvim_buf_set_name(0, buffer_name)
  end
end
