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
Plug 'johann2357/nvim-hardline', {'branch': 'develop'}
" <lsp>
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp_extensions.nvim'
" <lspcontainers>
Plug 'lspcontainers/lspcontainers.nvim'
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
let mapleader = " "

" Yank and paste from clipboard
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p

" Select the last changed text
nnoremap gp `[v`]

" Quick nohlsearch
nnoremap <Leader><Esc> :noh<CR>

" Terminal mappings
tnoremap <C-w>w <C-\><C-n>
tnoremap <C-w>c <C-\><C-n><C-w>c
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l
tnoremap <C-w>v <C-\><C-n><C-w>v
tnoremap <C-w>z <C-\><C-n><C-w>s

" Dvorak stuff because my brain is about to explode
" and it was fun to do this in qwerty
nnoremap <C-w>z <C-w>s
tnoremap <C-w>t <C-\><C-n><C-w>j
tnoremap <C-w>n <C-\><C-n><C-w>k
tnoremap <C-w>s <C-\><C-n><C-w>l
nnoremap <C-w>t <C-w>j
nnoremap <C-w>n <C-w>k
nnoremap <C-w>s <C-w>l

" Resize splits
nnoremap <Leader>+ :vertical resize +6<CR>
nnoremap <Leader>- :vertical resize -6<CR>
nnoremap <Leader><Leader>+ :resize +6<CR>
nnoremap <Leader><Leader>- :resize -6<CR>

" I have mapped the arrow keys to a different layer
" in the same place as hjkl
nnoremap <Left> 12h
nnoremap <Down> 12j
nnoremap <Up> 12k
nnoremap <Right> 12l

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
