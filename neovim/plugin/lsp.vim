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
