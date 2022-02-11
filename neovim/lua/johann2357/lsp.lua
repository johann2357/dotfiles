-- Setup lspkind
local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  cmp_tabnine = "[TN]",
  path = "[Path]",
}
local lspkind = require("lspkind")
lspkind.init({
    with_text = true,
})

-- Setup nvim-cmp.
local cmp = require("cmp")
cmp.setup({
  mapping = {
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind]
      local menu = source_mapping[entry.source.name]
      if entry.source.name == 'cmp_tabnine' then
        if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
            menu = entry.completion_item.data.detail .. ' ' .. menu
        end
        vim_item.kind = ''
      end
      vim_item.menu = menu
      return vim_item
    end
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
  },
})

-- Setup cmp_tabnine
local tabnine = require('cmp_tabnine.config')
tabnine:setup({
  max_lines = 1000,
  max_num_results = 20,
  sort = true,
  run_on_every_keystroke = true,
  snippet_placeholder = '..',
})

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local function config(_config)
  return vim.tbl_deep_extend("force", {
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  }, _config or {})
end

require'lspconfig'.pylsp.setup(config({
  settings={
    pyls={
      plugins={
        pycodestyle={
          maxLineLength=120;
        }
      }
    }
  }
}))

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
require'lspconfig'[server].setup(config({
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
}))

require'lspconfig'.bashls.setup(config({
  cmd = require'lspcontainers'.command('bashls'),
  -- root_dir = util.root_pattern(".git", vim.fn.getcwd()),
}))

require'lspconfig'.yamlls.setup(config({
  cmd = require'lspcontainers'.command('yamlls'),
  -- root_dir = util.root_pattern(".git", vim.fn.getcwd()),
}))
