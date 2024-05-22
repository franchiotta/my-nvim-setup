local function open_or_create_terminal_buffer(buffer_name)
    if not pcall(vim.cmd, 'buffer' .. ' ' .. buffer_name)
    then
        vim.api.nvim_command('term')
        vim.api.nvim_buf_set_name(0, buffer_name)
    end
end

local function delete_current_buffer()
    if vim.o.modified
    then
        vim.api.nvim_err_writeln('Cannot delete buffer, you have unsaved changes.')
        vim.ui.input({prompt='You want to exit anyway? Type yes or no: '}, function(input)
            if (input == 'yes' or input == 'YES')
            then
                vim.api.nvim_command('bp | sp | bn | bd!')
            end
        end)
    else
        vim.api.nvim_command('bp | sp | bn | bd')
    end
end

local function delete_all_buffers_but_current_one()
    local current_buf_nr = vim.fn.bufnr('%')
    for _, buf in pairs(vim.fn.getbufinfo({buflisted=1})) do
        if buf.bufnr ~= current_buf_nr
        then
            if buf.changed == 1
            then
                vim.ui.input({prompt='Buffer: ' .. buf.name .. ' is modified, want to exit anyway? Type yes or no: '}, function(input)
                    if (input == 'yes' or input == 'YES')
                    then
                        vim.api.nvim_command('bd! ' .. buf.bufnr)
                    end
                end)
            else
                vim.api.nvim_command('bd ' .. buf.bufnr)
            end
        end
    end
    vim.api.nvim_command(':AirlineRefresh')
end

local function delete_all_buffers()
    for _, buf in pairs(vim.fn.getbufinfo({buflisted=1})) do
        if buf.changed == 1
        then
            vim.ui.input({prompt='Buffer: ' .. buf.name .. ' is modified, want to exit anyway? Type yes or no: '}, function(input)
                if (input == 'yes' or input == 'YES')
                then
                    vim.api.nvim_command('bd! ' .. buf.bufnr)
                end
            end)
        else
            vim.api.nvim_command('bd ' .. buf.bufnr)
        end
    end
    vim.api.nvim_command(':AirlineRefresh')
end

local function move_forward_column()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    -- row index starts from 1.
    -- col index starts from 0
    if col < vim.fn.col("$") - 1
    then
        vim.api.nvim_win_set_cursor(0, {row,col+1})
    else
        if row < vim.fn.line("$")
        then
            vim.api.nvim_win_set_cursor(0, {row+1,0})
        end
    end
end

local function move_backward_column()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    -- row index starts from 1.
    -- col index starts from 0
    if col == 0
    then
        if row > 1
        then
            vim.api.nvim_win_set_cursor(0, {row-1,vim.fn.col({row-1,"$"})})
        end
    else
        vim.api.nvim_win_set_cursor(0, {row,col-1})
    end
end

local function move_next_line()
    if vim.fn.line(".") < vim.fn.line("$")
    then
        vim.api.nvim_cmd({cmd='normal', args={'ja'}},{})
    end
end

local function move_previous_line()
    if vim.fn.line(".") > 1
    then
        vim.api.nvim_cmd({cmd='normal', args={'ka'}},{})
    end
end

-- FIX THIS!
local function delete_forward_character()
    if vim.fn.col(".") < vim.fn.col("$")
    then
        if vim.fn.col(".") == 1
        then
            vim.api.nvim_cmd({cmd='normal', args={'xi'}},{})
        end
        if (vim.fn.col(".") < vim.fn.col("$") - 1)
        then
            vim.api.nvim_cmd({cmd='normal', args={'lxi'}},{})
        else
            vim.api.nvim_cmd({cmd='normal', args={'lxa'}},{})
        end
    else
        if vim.fn.line(".") < vim.fn.line("$")
        then
            vim.api.nvim_cmd({cmd='normal', args={'gJi'}},{})
        end
    end
end

return {
    open_or_create_terminal_buffer = open_or_create_terminal_buffer,
    delete_current_buffer = delete_current_buffer,
    delete_all_buffers_but_current_one = delete_all_buffers_but_current_one,
    delete_all_buffers = delete_all_buffers,
    move_forward_column = move_forward_column,
    move_backward_column = move_backward_column,
    move_next_line = move_next_line,
    move_previous_line = move_previous_line,
    delete_forward_character = delete_forward_character
}
