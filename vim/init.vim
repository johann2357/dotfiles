if has('nvim')
    let plugged_path = '~/.config/nvim/plugged'
else
    let plugged_path = '~/.vim/plugged'
endif

" Plugins
call plug#begin(plugged_path)
Plug 'johann2357/onehalf', {'rtp': 'vim/', 'branch': 'python-improvements'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'johann2357/python-mode', {'for': 'python', 'branch': 'improvements'}
call plug#end()

filetype on
filetype plugin indent on

syntax enable

" Encoding
set fileencoding=utf-8
set encoding=utf-8

" Search beahavior
set incsearch
set hlsearch
set smartcase

" tab behavior
set expandtab
set smarttab
set smartindent

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

" Ignore files !!
set wildignore+=*/tmp/*,*.so,*.swp,*.pyc,*/media/*,*.out,*/dist/*,*/platforms/*,*/test/*,*/node_modules/*,*/hooks*/,*/bower_components/*,*/plugins/*

" Adopted from https://gist.github.com/celso/6cefedb9fce92827ee38e8f7411b8b30
set ruler               " Show the line and column numbers of the cursor.
set formatoptions+=o    " Continue comment marker in new lines.
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.
set showcmd             " Show me what I'm typing
set showmode            " Show current mode.

" Easier movement between tabs
noremap <Leader>z <esc>:tabprevious<CR>
noremap <Leader>m <esc>:tabnext<CR>

" Easier movement between splits
noremap <Leader>h <esc><c-w>h<CR>
noremap <Leader>j <esc><c-w>j<CR>
noremap <Leader>k <esc><c-w>k<CR>
noremap <Leader>l <esc><c-w>l<CR>
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

" Easier movement between buffers
noremap <Leader>bl <esc>:buffers<CR>
noremap <Leader>bb <esc>:b#<CR>
noremap <Leader>be <esc>:buffers<CR>:buffer<Space>
noremap <Leader>bd <esc>:buffers<CR>:bdelete<Space>
noremap <Leader>bd! <esc>:buffers<CR>:bdelete!<Space>
noremap <Leader>q <esc>:bdelete<CR>
noremap <Leader>q! <esc>:bdelete!<CR>
noremap <Leader><Tab> <esc>:bnext<CR>
noremap <Leader><S-Tab> <esc>:bprevious<CR>
nnoremap <Leader>1 :buffer 1<CR>
nnoremap <Leader>2 :buffer 2<CR>
nnoremap <Leader>3 :buffer 3<CR>
nnoremap <Leader>4 :buffer 4<CR>
nnoremap <Leader>5 :buffer 5<CR>
nnoremap <Leader>6 :buffer 6<CR>
nnoremap <Leader>7 :buffer 7<CR>
nnoremap <Leader>8 :buffer 8<CR>
nnoremap <Leader>9 :buffer 9<CR>


" PLUGINS

" python-mode
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1

" NERDTreeToggle
let NERDTreeIgnore = ['\.pyc$', '__pycache__', '\.swp$']
nnoremap <Leader>n :NERDTreeToggle<CR>

" airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1

" flake8
autocmd FileType python map <buffer> <c-s> :w<esc>:call flake8#Flake8()<CR>

" Languages settings
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType java setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType css setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType scss setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType html setlocal expandtab shiftwidth=2 softtabstop=2

set laststatus=2

" Splits behavior
set cc=120

" GVIM settings
if has("gui_running")
    set guifont=Menlo\ for\ Powerline:h16
    set background=dark
    colorscheme onehalfdarkvivid
    let g:airline_theme='onehalfdark'
else
    " Colorscheme
    let iterm_profile = $ITERM_PROFILE
    " mouse might be useful at some point
    set mouse=a
    if iterm_profile == "Dark"
        set background=dark
        colorscheme onehalfdarkvivid
        let g:airline_theme='onehalfdark'
    else
        set background=light
        colorscheme onehalflight
        let g:airline_theme='onehalflight'
    endif
endif
