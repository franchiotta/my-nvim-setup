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
vim.keymap.set('i', '<C-f>', 'col(".") == col("$") ? (line(".") == line("$") ? \'<C-c>a\': \'<C-c>jI\') : \'<C-c>la\'', {expr = true})
vim.keymap.set('i', '<C-b>', 'col(".") == 1 ? (line(".") == 1 ? \'<C-c>i\' : \'<C-c>kA\') : \'<C-c>i\'', {expr = true})
vim.keymap.set('i', '<C-n>', 'line(".") == line("$") ? \'<C-c>a\' : \'<C-c>ja\'', { expr = true })
vim.keymap.set('i', '<C-p>', 'line(".") == 1 ? \'<C-c>a\' : \'<C-c>ka\'', { expr = true })

vim.keymap.set('n', '<C-h>', ':bprevious<CR>')
vim.keymap.set('n', '<C-l>', ':bnext<CR>')

--- editing
vim.keymap.set('i', '<C-d>', '<C-c>lxi')
vim.keymap.set('n', '<leader>q', ':bp<bar>sp<bar>bn<bar>bd<CR>')

-- terminal settings
 vim.api.nvim_command("autocmd TermOpen * startinsert")
 vim.api.nvim_command("autocmd TermOpen * set nobuflisted")
 vim.api.nvim_command("command OpenTerm bo 10new | lua open_or_create_terminal_buffer('terminal-buffer')")

-- search commands
vim.api.nvim_command("command -nargs=1 InsensitiveSearch vimgrep /\\c<args>/j `git ls-files`")
vim.api.nvim_command("command -nargs=1 SensitiveSearch vimgrep /\\C<args>/j `git ls-files`")
vim.api.nvim_command("command -nargs=1 IS InsensitiveSearch <args>")
vim.api.nvim_command("command -nargs=1 SS SensitiveSearch <args>")

-- quickfix customizations
 vim.api.nvim_command("autocmd FileType qf set nobuflisted")

