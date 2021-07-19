require'lspconfig'.pyls.setup{
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

-- check if previous config failed we use lspcontainers
-- require'lspconfig'.pylsp.setup {
--   cmd = require'lspcontainers'.command('pylsp');
--   -- on_attach=require'completion'.on_attach;
--   settings={
--     pylsp={
--       plugins={
--         pycodestyle={
--           maxLineLength=120;
--         }
--       }
--     }
--   }
-- }
-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#pyls

local server = "sumneko_lua"
require'lspconfig'[server].setup{
  on_new_config = function(new_config, new_root_dir)
    new_config.cmd = require'lspcontainers'.command(server, { root_dir = new_root_dir })
  end;
  settings = {
      Lua = {
          diagnostics = {
              globals = { 'vim' }
          }
      }
  }
}

require'lspconfig'.bashls.setup {
  cmd = require'lspcontainers'.command('bashls'),
  -- root_dir = util.root_pattern(".git", vim.fn.getcwd()),
}

require'lspconfig'.yamlls.setup {
  cmd = require'lspcontainers'.command('yamlls'),
  -- root_dir = util.root_pattern(".git", vim.fn.getcwd()),
}
