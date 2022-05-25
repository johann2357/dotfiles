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
" Continue comment marker in new lines.
set formatoptions+=o
" Horizontal split below current.
set splitbelow
" Vertical split to right of current.
set splitright
" default 4000ms - reduce it for better user experience
set updatetime=50
" custom
set laststatus=3
set cc=100
set ruler
set nofoldenable
set signcolumn=no
set nu
set relativenumber
set nowrap
set termguicolors
set scrolloff=6
set showcmd
set showmode
" dynamic stuff
fun! ToggleWinbar()
  echo(&winbar)
  if len(&winbar) == 0
    set winbar=%=%R\ %M\ %f
  else
    set winbar=
  endif
endfun
