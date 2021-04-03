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
-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#pyls
-- lua require'lspconfig'.sumneko_lua.setup{ on_attach=require'completion'.on_attach }
