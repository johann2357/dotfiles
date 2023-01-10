" Ingore files
set wildignore+=*.so
set wildignore+=*.swp
set wildignore+=*.pyc
set wildignore+=*.out
set wildignore+=**/tmp/*
set wildignore+=**/__pycache__/*
set wildignore+=**/.git/*
set wildignore+=**/node_modules/*
set wildignore+=**/dist/*
set wildignore+=**/platforms/*
set wildignore+=**/hooks*/
set wildignore+=**/media/*

" TODO: take a look at https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

" Plugins
call plug#begin('~/.config/nvim/plugged')
" tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
" python
Plug 'cjrh/vim-conda', {'for': 'python'}
" <treesitter>
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'
Plug 'romgrk/nvim-treesitter-context'
" <lsp>
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'  " LSP source for nvim-cmp
Plug 'hrsh7th/cmp-buffer'  " Source for buffer words
Plug 'hrsh7th/cmp-path'  " Source for path stuff
Plug 'hrsh7th/nvim-cmp'  " Autocompletion plugin
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }  " Smart completion stuff
Plug 'onsails/lspkind-nvim'  " Symbols for completion stuff
Plug 'nvim-lua/lsp_extensions.nvim'
" <lspcontainers>
Plug 'lspcontainers/lspcontainers.nvim'
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
" <hardline>
Plug 'johann2357/nvim-hardline', { 'branch': 'harpoon' }
" colorscheme
Plug 'gruvbox-community/gruvbox'
" other
Plug 'folke/zen-mode.nvim'
call plug#end()

filetype on
filetype plugin indent on

syntax enable

augroup lang_settings
  autocmd!
  autocmd FileType vim setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType java setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType css setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType scss setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType html setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType yaml setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType lua setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType javascriptreact setlocal noexpandtab shiftwidth=2 tabstop=2
  autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType vue setlocal expandtab shiftwidth=4 tabstop=4
augroup END

" Plugins
lua require("johann2357")
