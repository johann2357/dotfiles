-- Setup lspkind
local source_mapping = {
  buffer = "[buff]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[lua]",
  cmp_tabnine = "[tabn]",
  path = "[path]",
}
local lspkind = require("lspkind")
lspkind.init({
    mode = "text",
})

-- Setup nvim-cmp.
vim.opt.completeopt={"menu", "menuone", "noinsert", "noselect"}
local cmp = require("cmp")
cmp.setup({
  mapping = {
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format(
        "%9.9s %s",
        string.lower(vim_item.kind),
        lspkind.presets.default[vim_item.kind]
      )
      local menu = source_mapping[entry.source.name]
      if entry.source.name == "cmp_tabnine" then
        if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
            menu = entry.completion_item.data.detail .. " " .. menu
        end
        vim_item.kind = ""
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
local tabnine = require("cmp_tabnine.config")
tabnine:setup({
  max_lines = 1000,
  max_num_results = 10,
  sort = true,
  run_on_every_keystroke = true,
  snippet_placeholder = "..",
})

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local function config(_config)
  return vim.tbl_deep_extend("force", {
    capabilities = capabilities,
    on_attach = function()
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
      vim.keymap.set("n", "<leader>vd", vim.lsp.buf.definition, {buffer=0})
      vim.keymap.set("n", "<leader>vt", vim.lsp.buf.type_definition, {buffer=0})
      vim.keymap.set("n", "<leader>vi", vim.lsp.buf.implementation, {buffer=0})
      vim.keymap.set("n", "<leader>vr", vim.lsp.buf.rename, {buffer=0})
      vim.keymap.set("n", "<leader>vf", vim.lsp.buf.references, {buffer=0})
      vim.keymap.set("n", "<leader>va", vim.lsp.buf.code_action, {buffer=0})
      vim.keymap.set("n", "<leader>vh", vim.lsp.buf.signature_help, {buffer=0})
      vim.keymap.set("n", "<leader>v<down>", vim.diagnostic.goto_next, {buffer=0})
      vim.keymap.set("n", "<leader>v<up>", vim.diagnostic.goto_prev, {buffer=0})
    end
  }, _config or {})
end

require"lspconfig".pylsp.setup(config({
  settings={
    pylsp={
      plugins={
        pycodestyle={
          maxLineLength=120;
        }
      }
    }
  }
}))

-- check if previous config failed we use lspcontainers
-- require"lspconfig".pylsp.setup {
--   cmd = require"lspcontainers".command("pylsp");
--   -- on_attach=require"completion".on_attach;
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
require"lspconfig"[server].setup(config({
  on_new_config = function(new_config, new_root_dir)
    new_config.cmd = require"lspcontainers".command(server, { root_dir = new_root_dir })
  end;
  settings = {
      Lua = {
          diagnostics = {
              globals = { "vim" }
          }
      }
  }
}))

require"lspconfig".bashls.setup(config({
  cmd = require"lspcontainers".command("bashls"),
  -- root_dir = util.root_pattern(".git", vim.fn.getcwd()),
}))

require"lspconfig".yamlls.setup(config({
  cmd = require"lspcontainers".command("yamlls"),
  -- root_dir = util.root_pattern(".git", vim.fn.getcwd()),
}))
