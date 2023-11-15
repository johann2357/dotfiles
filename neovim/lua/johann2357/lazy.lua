local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup(
    {
        -- tpope
        'tpope/vim-fugitive',
        'tpope/vim-rhubarb',
        'tpope/vim-vinegar',
        'tpope/vim-surround',
        -- treesitter
        {
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate'
        },
        'nvim-treesitter/playground',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context',
        -- LSP
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        -- Autocompletion
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        -- Snippets
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
        -- Custom styles
        'onsails/lspkind.nvim',
        -- productivity
        {
            'nvim-telescope/telescope.nvim',
            -- version = '0.1.4',
            branch = '0.1.x',
            dependencies = { {'nvim-lua/plenary.nvim'} }
        },
        'ThePrimeagen/git-worktree.nvim',
        'ThePrimeagen/harpoon',
        'github/copilot.vim',
        'numToStr/Comment.nvim',
        'mbbill/undotree',
        'folke/zen-mode.nvim',
        -- look and feel
        'nvim-tree/nvim-web-devicons',
        {
            'catppuccin/nvim',
            name = 'catppuccin',
            priority = 420,
            lazy = false,
        },
        {
            'johann2357/nvim-hardline',
            branch = 'harpoon',
        },
    },
    {
        ui = {
            icons = {
                cmd = "⌘",
                config = "🛠",
                event = "📅",
                ft = "📂",
                init = "⚙",
                keys = "🗝",
                plugin = "🔌",
                runtime = "💻",
                source = "📄",
                start = "🚀",
                task = "📌",
            },
        },
        git = {
            -- defaults for the `Lazy log` command
            log = { "-10" }, -- show the last 10 commits
            -- log = { "-8" }, -- show commits from the last 3 days
            timeout = 240, -- kill processes that take more than 2 minutes
            url_format = "https://github.com/%s.git",
            -- lazy.nvim requires git >=2.19.0. If you really want to use lazy with an older version,
            -- then set the below to false. This should work, but is NOT supported and will
            -- increase downloads a lot.
            filter = true,
        },
    }
)
