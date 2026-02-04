vim.g.mapleader = ","

require('plugins')
local scripts = require('scripts')
require('mappings.lsp')

-- vim options
vim.opt.showcmd = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.wrap = true
vim.opt.encoding="utf-8"

-- vim window options
vim.wo.cursorline = true

vim.opt.list = true
vim.opt.listchars = {tab = "⇥ ", nbsp = "·", trail = "␣", extends = "▸", precedes = "◂", eol = "↩"}

vim.opt.conceallevel = 2

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
vim.keymap.set('i', '<C-f>', scripts.move_forward_column)
vim.keymap.set('i', '<C-b>', scripts.move_backward_column)
vim.keymap.set('i', '<C-n>', scripts.move_next_line)
vim.keymap.set('i', '<C-p>', scripts.move_previous_line)

vim.keymap.set('n', '<C-h>', ':bprevious<CR>')
vim.keymap.set('n', '<C-l>', ':bnext<CR>')

--- editing
vim.keymap.set('i', '<C-d>', scripts.delete_forward_character)
vim.keymap.set('n', '<leader>q', scripts.delete_current_buffer)
vim.keymap.set('n', '<leader>qa', scripts.delete_all_buffers)
vim.keymap.set('n', '<leader>qo', scripts.delete_all_buffers_but_current_one)

-- quickfix
vim.keymap.set('n', '<leader>rn', ':cnext<CR>')
vim.keymap.set('n', '<leader>rp', ':cprevious<CR>')
vim.api.nvim_command("autocmd FileType qf set nobuflisted")

 -- terminal settings
vim.api.nvim_create_autocmd("TermOpen", {command = "startinsert"})
vim.api.nvim_create_autocmd("TermOpen", {command = "set nobuflisted"})
vim.api.nvim_create_user_command("TermOpen", function()
    vim.api.nvim_command('botright 10new')
    scripts.open_or_create_terminal_buffer('terminal-buffer')
end, {nargs=0})

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
end, {nargs = 0, desc = 'Prints file info'})

vim.keymap.set('n', '<leader><leader>x', '<cmd>write <bar> source %<CR>', {desc = 'Save and source current file'})
