vim.g.mapleader = ","

require('plugins')
require('scripts')

-- vim options
vim.opt.showcmd = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = true
vim.opt.encoding="utf-8"

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
vim.keymap.set('i', '<C-f>', '<C-c>la')
vim.keymap.set('i', '<C-b>', '<C-c>i')
vim.keymap.set('i', '<C-n>', '<C-c>ja')
vim.keymap.set('i', '<C-p>', '<C-c>ka')

vim.keymap.set('n', '<C-h>', ':bprevious<CR>')
vim.keymap.set('n', '<C-l>', ':bnext<CR>')

--- editing
vim.keymap.set('i', '<C-d>', '<C-c>lxi')
vim.keymap.set('n', '<leader>q', ':bp<bar>sp<bar>bn<bar>bd<CR>')

-- terminal settings
 vim.api.nvim_command("autocmd TermOpen * startinsert")
 vim.api.nvim_command("autocmd TermOpen * set nobuflisted")
 vim.api.nvim_command("command OpenTerm bo 10new | lua open_or_create_terminal_buffer('terminal-buffer')")
