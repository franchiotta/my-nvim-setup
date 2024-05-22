require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  --use 'scrooloose/nerdtree'
  use 'ellisonleao/gruvbox.nvim'

  -- lsp
  use 'williamboman/mason.nvim'
  use "williamboman/mason-lspconfig.nvim"
  use 'neovim/nvim-lspconfig'
  use {
        "hrsh7th/nvim-cmp",
        requires = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip'
        }
  }
  use 'mfussenegger/nvim-jdtls'

  use "folke/neodev.nvim"
  use 'udalov/kotlin-vim'
  use 'Einenlum/yaml-revealer'
  use 'preservim/nerdcommenter'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'tpope/vim-fugitive'
  use 'preservim/vim-markdown'
  use {
      'iamcco/markdown-preview.nvim',
      run = "cd app && npm install",
      setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
      ft = { "markdown" }
  }
  use 'szw/vim-maximizer'
  use 'j-hui/fidget.nvim'
  use {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.6',
      requires = {
          "nvim-lua/plenary.nvim"
      }
  }
  use 'elzr/vim-json'
  use 'lepture/vim-jinja'
  use 'hashivim/vim-terraform'
  use {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = { 
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  }
end)

-- command-t
vim.g.CommandTWildIgnore = ",venv,build,*.egg-info"
vim.cmd('nnoremap <leader>t :CommandTGit<CR>')

---- nerdtree
--vim.cmd('nnoremap <leader>nt :NERDTree<CR>')
--vim.cmd('nnoremap <leader>ntf :NERDTreeFind<CR>')
--vim.cmd('nnoremap <leader>ntfc :NERDTreeFocus<CR>')
--vim.cmd('nnoremap <leader>ntt :NERDTreeToggle<CR>')
--vim.cmd('nnoremap <leader>ntb :NERDTreeFromBookmark ')
----vim.api.nvim_command('autocmd VimEnter * NERDTree')

vim.g.NERDTreeShowBookmarks = 0
vim.g.NERDTreeChDirMode = 2

-- gruvbox
vim.o.background = "dark"
require("gruvbox").setup({
  contrast = "hard"
})
vim.cmd("colorscheme gruvbox")

-- vim-airline
vim.api.nvim_set_var('airline#extensions#tabline#enabled', 1)
vim.api.nvim_set_var('airline#extensions#branch#enabled', 1)
vim.g.airline_solarized_bg = 'dark'
vim.g.airline_powerline_fonts = 1

-- vim-maximizer
vim.cmd('nnoremap <C-w>m :MaximizerToggle!<CR>')

-- fidget
require("fidget").setup()

-- neotree
require('plugins.neotree')

-- telescope
require('plugins.telescope')

-- cmp
require('plugins.cmp')

-- nepdev
require("neodev").setup() -- IMPORTANT: make sure to setup neodev BEFORE lspconfig

-- mason
require("mason").setup({
    log_level = vim.log.levels.DEBUG,
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- mason-lspconfig
require("mason-lspconfig").setup()

-- lspconfig
require('plugins.lspconfig')

-- vim-jinja
vim.api.nvim_create_user_command('FormatJinja', 'set ft=jinja', {nargs=0})
vim.api.nvim_create_user_command('FormatJson', 'set ft=json', {nargs=0})

-- Don't remove return, otherwise it will not load.
return
