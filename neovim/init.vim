let plugged_path = '~/.config/nvim/plugged'

" Plugins
call plug#begin(plugged_path)
Plug 'johann2357/vim-dracula', {'as': 'dracula', 'branch': 'johann2357'}
Plug 'ojroques/nvim-hardline'
" tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
" python
Plug 'cjrh/vim-conda', {'for': 'python'}
" tailored plugins
Plug 'johann2357/nvim-smartbufs'
" <lsp>
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp_extensions.nvim'
" <telescope>
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
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
set signcolumn=no
set nu
set nowrap
set termguicolors
set relativenumber
set scrolloff=6

" Quick nohlsearch
nnoremap <Leader><Esc> :noh<CR>

" To normal mode
tnoremap <C-w>w <C-\><C-n>

" Easier movement between splits
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

" PLUGINS

" nvim-smartbufs
nnoremap <Leader>1 :lua require("nvim-smartbufs").goto_buffer(1)<CR>
nnoremap <Leader>2 :lua require("nvim-smartbufs").goto_buffer(2)<CR>
nnoremap <Leader>3 :lua require("nvim-smartbufs").goto_buffer(3)<CR>
nnoremap <Leader>4 :lua require("nvim-smartbufs").goto_buffer(4)<CR>
nnoremap <Leader>5 :lua require("nvim-smartbufs").goto_buffer(5)<CR>
nnoremap <Leader>6 :lua require("nvim-smartbufs").goto_buffer(6)<CR>
nnoremap <Leader>7 :lua require("nvim-smartbufs").goto_buffer(7)<CR>
nnoremap <Leader>8 :lua require("nvim-smartbufs").goto_buffer(8)<CR>
nnoremap <Leader>9 :lua require("nvim-smartbufs").goto_buffer(9)<CR>
nnoremap <Leader>c1 :lua require("nvim-smartbufs").goto_terminal(1)<CR>
nnoremap <Leader>c2 :lua require("nvim-smartbufs").goto_terminal(2)<CR>
nnoremap <Leader>c3 :lua require("nvim-smartbufs").goto_terminal(3)<CR>
nnoremap <Leader>c4 :lua require("nvim-smartbufs").goto_terminal(4)<CR>
nnoremap <Leader><Tab> :lua require("nvim-smartbufs").goto_next_buffer()<CR>
nnoremap <Leader><S-Tab> :lua require("nvim-smartbufs").goto_prev_buffer()<CR>
nnoremap <Leader>qq :lua require("nvim-smartbufs").close_current_buffer()<CR>
nnoremap <Leader>q1 :lua require("nvim-smartbufs").close_buffer(1)<CR>
nnoremap <Leader>q2 :lua require("nvim-smartbufs").close_buffer(2)<CR>
nnoremap <Leader>q3 :lua require("nvim-smartbufs").close_buffer(3)<CR>
nnoremap <Leader>q4 :lua require("nvim-smartbufs").close_buffer(4)<CR>
nnoremap <Leader>q5 :lua require("nvim-smartbufs").close_buffer(5)<CR>
nnoremap <Leader>q6 :lua require("nvim-smartbufs").close_buffer(6)<CR>
nnoremap <Leader>q7 :lua require("nvim-smartbufs").close_buffer(7)<CR>
nnoremap <Leader>q8 :lua require("nvim-smartbufs").close_buffer(8)<CR>
nnoremap <Leader>q9 :lua require("nvim-smartbufs").close_buffer(9)<CR>

" conda settings
let g:conda_startup_msg_suppress = 1

" telescope settings
lua require('telescope').setup({defaults = {file_sorter = require('telescope.sorters').get_fzy_sorter}})

nnoremap <leader>t :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>f :lua require('telescope.builtin').find_files()<CR>

" LSP settings
set completeopt=menuone,noinsert,noselect

nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vsd :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_enable_auto_popup = 0
imap <silent> <c-n> <Plug>(completion_trigger)

" https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#pyls
" TODO: maybe move this config to a different file? with all lsp?
lua << EOF
local lspconfig = require'lspconfig'
lspconfig.pyls.setup{
  on_attach=require'completion'.on_attach;
  settings={
    pyls={
      plugins={
        pycodestyle={
          maxLineLength=120;
        }
      }
    }
  }
}
EOF
" lua require'lspconfig'.sumneko_lua.setup{ on_attach=require'completion'.on_attach }

" FIXME: start spliting this into multiple files!!!! :(
" Hardline
lua << EOF
require('hardline').setup {
  bufferline = true,
  theme = 'nord'
}
EOF

" Languages settings
augroup lang_settings
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

set laststatus=2

" Splits behavior
set cc=120

set background=dark
colorscheme dracula
