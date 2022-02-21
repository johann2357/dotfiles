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
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
" python
Plug 'cjrh/vim-conda', {'for': 'python'}
" <treesitter>
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
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
" <hardline>
Plug 'ojroques/nvim-hardline'
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

" Resize splits
nnoremap <C-w>< :vertical resize +6<CR>
nnoremap <C-w>> :vertical resize -6<CR>
nnoremap <C-w>+ :resize +6<CR>
nnoremap <C-w>- :resize -6<CR>

" I have mapped the arrow keys to a different layer
" in the same place as hjkl
nnoremap <Down> L13<C-e>
nnoremap <Up> H13<C-y>

"Jumplist mutations
nnoremap <expr> k (v:count > 13 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 13 ? "m'" . v:count : "") . 'j'

" Keep it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap { {zzzv
nnoremap } }zzzv
nnoremap <c-u> <c-u>zzzv
nnoremap <c-d> <c-d>zzzv
nnoremap <c-o> <c-o>zzzv
nnoremap <c-i> <c-i>zzzv
nnoremap <C-j> :cnext<CR>zzzv
nnoremap <C-k> :cprev<CR>zzzv

" Moving stuff
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Undo breakpoints
inoremap . .<c-g>u
inoremap = =<c-g>u
inoremap ( (<c-g>u
inoremap ) )<c-g>u
inoremap [ [<c-g>u
inoremap ] ]<c-g>u
inoremap { {<c-g>u
inoremap } }<c-g>u
inoremap <space> <space><c-g>u

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
