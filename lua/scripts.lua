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
