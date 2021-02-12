let plugged_path = '~/.config/nvim/plugged'

" Plugins
call plug#begin(plugged_path)
Plug 'johann2357/vim-dracula', {'as': 'dracula', 'branch': 'johann2357'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'cjrh/vim-conda', {'for': 'python'}
Plug 'python-mode/python-mode', {'for': 'python', 'branch': 'develop'}
Plug 'johann2357/nvim-smartbufs'
" <telescope>
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
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

" fold off
set nofoldenable

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
set wildignore+=*/tmp/*,*.so,*.swp,*.pyc,*/__pycache__/*,*/media/*,*.out,*/dist/*,*/platforms/*,*/test/*,*/node_modules/*,*/hooks*/,*/bower_components/*,*/plugins/*

" Adopted from https://gist.github.com/celso/6cefedb9fce92827ee38e8f7411b8b30
set ruler               " Show the line and column numbers of the cursor.
set formatoptions+=o    " Continue comment marker in new lines.
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.
set showcmd             " Show me what I'm typing
set showmode            " Show current mode.

" Custom
set nu
set nowrap
set termguicolors
set relativenumber
set scrolloff=6

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
noremap <Leader>bl :buffers<CR>
noremap <Leader>bb :b#<CR>
noremap <Leader>be :buffers<CR>:buffer<Space>
noremap <Leader>bd :buffers<CR>:bdelete<Space>
noremap <Leader>!bd :buffers<CR>:bdelete!<Space>
noremap <Leader>q :bdelete<CR>
noremap <Leader>!q :bdelete!<CR>
noremap <Leader><Tab> :bnext<CR>
noremap <Leader><S-Tab> :bprevious<CR>

" PLUGINS

" nvim-smartbufs
nnoremap <Leader>1 :lua require("nvim-smartbufs").open_n_active_buffer(1)<CR>
nnoremap <Leader>2 :lua require("nvim-smartbufs").open_n_active_buffer(2)<CR>
nnoremap <Leader>3 :lua require("nvim-smartbufs").open_n_active_buffer(3)<CR>
nnoremap <Leader>4 :lua require("nvim-smartbufs").open_n_active_buffer(4)<CR>
nnoremap <Leader>5 :lua require("nvim-smartbufs").open_n_active_buffer(5)<CR>
nnoremap <Leader>6 :lua require("nvim-smartbufs").open_n_active_buffer(6)<CR>
nnoremap <Leader>7 :lua require("nvim-smartbufs").open_n_active_buffer(7)<CR>
nnoremap <Leader>8 :lua require("nvim-smartbufs").open_n_active_buffer(8)<CR>

" python-mode
set completeopt=menuone,noinsert
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_print_as_function = 1
let g:pymode_virtualenv = 1

let g:pymode_rope = 1
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_completion_bind = '<Leader-n>'
let g:pymode_rope_goto_definition_cmd = 'e'
let g:pymode_rope_goto_definition_bind = '<Leader>g'
let g:pymode_rope_show_doc_bind = '<Leader>d'

" TODO: create a flake8 plugin
let g:pymode_lint_on_write = 0
let g:pymode_lint_ignore = ["E501","B950","D100","D102","D104","D107","D204","D401","E501","E999","Q000",]
let g:pymode_rope_regenerate_on_write = 0
let g:pymode_options_max_line_length = 120

" conda settings
let g:conda_startup_msg_suppress = 1

" airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1

" telescope settings
lua require('telescope').setup({defaults = {file_sorter = require('telescope.sorters').get_fzy_sorter}})

nnoremap <leader>t :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>f :lua require('telescope.builtin').find_files()<CR>

" Ctrl+s to save running checking lint and regenerate rope
augroup python_stuff
  autocmd!
  autocmd FileType python map <buffer> <c-s> :w<esc>:call pymode#lint#check()<esc>:call pymode#rope#regenerate()<CR>
augroup END

" Languages settings
augroup lang_settings
  autocmd FileType vim setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType java setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType css setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType scss setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType html setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType yaml setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType lua setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType javascriptreact setlocal noexpandtab shiftwidth=2 tabstop=2
augroup END

set laststatus=2

" Splits behavior
set cc=120

" Set mouse in normal mode
set mouse=n

set background=dark
colorscheme dracula
let g:airline_theme='dracula'
