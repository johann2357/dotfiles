local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'sumneko_lua',
  'rust_analyzer',
  'pylsp',
  'vuels',
  'yamlls',
  'marksman',
  'texlab',
})

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})


local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-u>'] = cmp.mapping.scroll_docs(-4),
  ['<C-d>'] = cmp.mapping.scroll_docs(4),
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ['<C-Space>'] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>vt", function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set("n", "<leader>vi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>vf", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>va", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vh", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>v<down>", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<leader>v<up>", function() vim.diagnostic.goto_prev() end, opts)
end)

lsp.configure('pylsp', {
   settings={
     pylsp={
       plugins={
         pycodestyle={
           -- ignore={'W391'},
           maxLineLength=120
         }
       }
     }
   }
})

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
