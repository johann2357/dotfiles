require("mason").setup()

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
    ensure_installed = {
        "tsserver",
        "lua_ls",
        -- "rust_analyzer",
        "pylsp",
        "vuels",
        "yamlls",
        "marksman",
        "texlab",
    }
})

local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.Select}
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local lsp_attach = function (_, bufnr)
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
end

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            -- require("snippy").expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    sources = cmp.config.sources(
        {
            { name = "nvim_lsp" },
            -- { name = "vsnip" }, -- For vsnip users.
            { name = "luasnip" }, -- For luasnip users.
            -- { name = "ultisnips" }, -- For ultisnips users.
            -- { name = "snippy" }, -- For snippy users.
        },
        {
            { name = "buffer" },
        }
    )
})

local lspconfig = require("lspconfig")

lspconfig.pylsp.setup({
    on_attach = lsp_attach,
    capabilities = lsp_capabilities,
    settings={
        pylsp={
            plugins={
                pycodestyle={
                    -- ignore={"W391"},
                    maxLineLength=120
                }
            }
        }
    }
})

-- Fix Undefined global 'vim'
lspconfig.lua_ls.setup({
    on_attach = lsp_attach,
    capabilities = lsp_capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
})

lspconfig.rust_analyzer.setup({
    on_attach = lsp_attach,
    capabilities = lsp_capabilities,
    cmd = {
        "rustup", "run", "stable", "rust-analyzer",
    },
    settings = {
        ["rust-analyzer"] = {
            diagnostics = {
                enable = true;
            }
        }
    }
})

lspconfig.tsserver.setup({
    on_attach = lsp_attach,
    capabilities = lsp_capabilities,
})

lspconfig.vuels.setup({
    on_attach = lsp_attach,
    capabilities = lsp_capabilities,
})

lspconfig.yamlls.setup({
    on_attach = lsp_attach,
    capabilities = lsp_capabilities,
})

lspconfig.marksman.setup({
    on_attach = lsp_attach,
    capabilities = lsp_capabilities,
})

lspconfig.texlab.setup({
    on_attach = lsp_attach,
    capabilities = lsp_capabilities,
})

vim.diagnostic.config({
    virtual_text = true
})
