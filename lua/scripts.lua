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

function delete_all_buffers_but_current_one()
    current_buf_nr = vim.fn.bufnr('%')
    for key, buf in pairs(vim.fn.getbufinfo({buflisted=1})) do
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

function delete_all_buffers()
    current_buf_nr = vim.fn.bufnr('%')
    for key, buf in pairs(vim.fn.getbufinfo({buflisted=1})) do
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

function move_forward_column_keystrokes()
    if vim.fn.col(".") < vim.fn.col("$")
    then
        return '<C-c>la'
    else
        if vim.fn.line(".") < vim.fn.line("$")
        then
            return '<C-c>jI'
        end
    end
end

function move_backward_column_keystrokes()
    if vim.fn.col(".") == 1
    then
        if vim.fn.line(".") > 1
        then
            return '<c-c>kA'
        end
    else
        return '<C-c>i'
    end
end

function move_next_line_keystrokes()
    if vim.fn.line(".") < vim.fn.line("$")
    then
        return '<C-c>ja'
    end
end

function move_previous_line_keystrokes()
    if vim.fn.line(".") > 1
    then
        return '<C-c>ka'
    end
end

function delete_forward_character_keystrokes()
    if vim.fn.col(".") < vim.fn.col("$")
    then
        if vim.fn.col(".") == 1
        then
            return '<C-c>xi'
        end
        if (vim.fn.col(".") < vim.fn.col("$") - 1)
        then
            return '<C-c>lxi'
        else
            return '<C-c>lxa'
        end
    else
        if vim.fn.line(".") < vim.fn.line("$")
        then
            return '<C-c>gJi'
        end
    end
end
