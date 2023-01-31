" TODO: take a look at https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

" Plugins
call plug#begin('~/.config/nvim/plugged')
" tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
" <treesitter>
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'
Plug 'romgrk/nvim-treesitter-context'
" <lsp>
Plug 'VonHeikemen/lsp-zero.nvim', { 'branch': 'v1.x' }
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp'  " LSP source for nvim-cmp
Plug 'hrsh7th/cmp-buffer'  " Source for buffer words
Plug 'hrsh7th/cmp-path'  " Source for path stuff
Plug 'hrsh7th/nvim-cmp'  " Autocompletion plugin
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'
" <git>
Plug 'ThePrimeagen/git-worktree.nvim'
" <telescope>
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'kyazdani42/nvim-web-devicons'
" <harpoon>
Plug 'ThePrimeagen/harpoon'
" <comments>
Plug 'numToStr/Comment.nvim'
" <undotree>
Plug 'mbbill/undotree'
" <hardline>
Plug 'johann2357/nvim-hardline', { 'branch': 'harpoon' }
" colorscheme
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
" other
Plug 'folke/zen-mode.nvim'
call plug#end()

" Plugins
lua require('johann2357')
