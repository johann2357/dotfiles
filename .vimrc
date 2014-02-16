set nocompatible
execute pathogen#infect()

filetype on
filetype plugin indent on

syntax enable

" Search beahavior
set incsearch
set hlsearch

" Encoding
set fileencoding=utf-8
set encoding=utf-8

" Block arrow keys
no <down> <esc>:let @z=@"<CR>ddp<esc>:let @"=@z<CR>
no <up> <esc>:let @z=@"<CR>ddkP<esc>:let @"=@z<CR>
no <left> <Nop>
no <right> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>
vno <down> <esc>:let @w=@"<CR>gvd<esc>p<esc>:let @"=@w<CR>`[V`]
vno <up> <esc>:let @w=@"<CR>gvd<esc>kP<esc>:let @"=@w<CR>`[V`]
vno <left> <Nop>
vno <right> <Nop>

" tab behavior
set expandtab
set shiftwidth=2
set softtabstop=2
set smarttab
set smartindent

" background
set background=dark
map <F10> :let &background = ( &background == "light"? "dark" : "light" )<CR>

" Splits behavior
set cc=80
set winwidth=81
set winminwidth=31
set winwidth=81
set winheight=11
set winminheight=11
set winheight=666

" Set Leader Key
let mapleader = ","

" Yank and paste from clipboard
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p

" Select the last changed text
nnoremap gp `[v`]

" Better indentation
vnoremap < <gv
vnoremap > >gv

inoremap <Leader>' ''<esc>i
inoremap <Leader>" ""<esc>i
inoremap <Leader>( ()<esc>i
inoremap <Leader>[ []<esc>i
inoremap <Leader>{ {}<esc>i

" Easier movement between tabs
noremap <Leader>z <esc>:tabprevious<CR>
noremap <Leader>m <esc>:tabnext<CR>

" Easier movement between splits
noremap <Leader>h <esc><c-w>h<CR>
noremap <Leader>j <esc><c-w>j<CR>
noremap <Leader>k <esc><c-w>k<CR>
noremap <Leader>l <esc><c-w>l<CR>

" Python settings
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4