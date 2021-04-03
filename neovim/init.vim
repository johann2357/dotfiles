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

" Plugins
call plug#begin('~/.config/nvim/plugged')
" tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
" python
Plug 'cjrh/vim-conda', {'for': 'python'}
" custom plugins
Plug 'johann2357/nvim-smartbufs'
Plug 'johann2357/nvim-hardline', {'branch': 'custom-bufferline'}
" <lsp>
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp_extensions.nvim'
" <telescope>
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
" colorscheme
Plug 'gruvbox-community/gruvbox'
call plug#end()

filetype on
filetype plugin indent on

syntax enable

" Set Leader Key
let mapleader = ","

" Yank and paste from clipboard
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p

" Select the last changed text
nnoremap gp `[v`]

" Quick nohlsearch
nnoremap <Leader><Esc> :noh<CR>

" To normal mode
tnoremap <C-w>w <C-\><C-n>

" Easier movement between splits
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

" Resize splits
nnoremap <Leader>+ :vertical resize +6<CR>
nnoremap <Leader>- :vertical resize -6<CR>

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
  autocmd FileType javascript setlocal noexpandtab shiftwidth=2 tabstop=2
augroup END

" Plugins
lua require("johann2357")
