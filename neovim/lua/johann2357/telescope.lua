require('telescope').setup({
    defaults={
        -- file_sorter=require('telescope.sorters').get_fzy_sorter,
        file_ignore_patterns = {
            "node_modules/.*",
            "__pycache__/.*",
            ".git/.*",
            "deps/.*",
            "dist/.*",
            "platforms/.*",
            "hooks/.*",
            "media/.*",
            "tmp/.*",
            "%.pyc",
        },
        prompt_prefix = '> ',
        color_devicons = true,
    }
})
require("telescope").load_extension("git_worktree")
