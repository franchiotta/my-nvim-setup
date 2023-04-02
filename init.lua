vim.g.mapleader = ","

require('plugins')
require('scripts')
require('mappings.lsp')

-- vim options
vim.opt.showcmd = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = true
vim.opt.encoding="utf-8"

-- vim window options
vim.wo.cursorline = true

vim.opt.list = true
vim.opt.listchars = {tab = "⇥ ", nbsp = "·", trail = "␣", extends = "▸", precedes = "◂", eol = "↩"}

-- custom mapppings

--- json parsing
vim.keymap.set('v', 'JF', ':!jq .<CR>')
vim.keymap.set('v', 'jf', ':!jq -c .<CR>')

--- quoting
vim.keymap.set('n', 'quo', 'ciw"<C-R>""<C-C>')
vim.keymap.set('n', 'squo', 'ciw\'<C-R>"\'<C-C>')
vim.keymap.set('v', 'quo', 'c"<C-c>pa"<C-C>')
vim.keymap.set('v', 'squo', 'c\'<C-c>pa\'<C-C>')
vim.keymap.set('n', 'unq', 'di"hPl2x')
vim.keymap.set('n', 'sunq', 'di\'hPl2x')

--- moving
vim.keymap.set('i', '<C-f>', function() return move_forward_column_keystrokes() end, {expr = true})
vim.keymap.set('i', '<C-b>', function() return move_backward_column_keystrokes() end, {expr = true})
vim.keymap.set('i', '<C-n>', function() return move_next_line_keystrokes() end, {expr = true})
vim.keymap.set('i', '<C-p>', function() return move_previous_line_keystrokes() end, {expr = true})

vim.keymap.set('n', '<C-h>', ':bprevious<CR>')
vim.keymap.set('n', '<C-l>', ':bnext<CR>')

--- editing
vim.keymap.set('i', '<C-d>', function() return delete_forward_character_keystrokes() end, {expr=true})
vim.keymap.set('n', '<leader>q', '<cmd>lua delete_current_buffer()<CR>')
vim.keymap.set('n', '<leader>qa', '<cmd>lua delete_all_buffers()<CR>')
vim.keymap.set('n', '<leader>qo', '<cmd>lua delete_all_buffers_but_current_one()<CR>')

-- quickfix
vim.keymap.set('n', '<leader>rn', ':cnext<CR>')
vim.keymap.set('n', '<leader>rp', ':cprevious<CR>')
vim.api.nvim_command("autocmd FileType qf set nobuflisted")

 -- terminal settings
 vim.api.nvim_command("autocmd TermOpen * startinsert")
 vim.api.nvim_command("autocmd TermOpen * set nobuflisted")
 vim.api.nvim_command("command TermOpen bo 10new | lua open_or_create_terminal_buffer('terminal-buffer')")

-- search commands
vim.api.nvim_create_user_command('InsensitiveSearch', 'vimgrep /\\c<args>/j `git ls-files`', {nargs=1})
vim.api.nvim_create_user_command('SensitiveSearch', 'vimgrep /\\C<args>/j `git ls-files`', {nargs=1})
vim.api.nvim_create_user_command('IS', 'InsensitiveSearch <args>', {nargs=1})
vim.api.nvim_create_user_command('SS', 'SensitiveSearch <args>', {nargs=1})


vim.api.nvim_create_user_command("FileInfo", function()
    local buffer_number = vim.fn.bufnr()
    local number_of_lines = vim.fn.line("$")
    local file_name = vim.fn.expand('%:p')
    print(string.format('buf %d: %q %d lines', buffer_number, file_name, number_of_lines))
end, {nargs = 0})

vim.keymap.set('n', '<leader><leader>x', '<cmd>write <bar> source %<CR>')
