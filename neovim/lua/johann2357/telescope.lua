local telescope = require("telescope")

telescope.setup({
    defaults={
        file_ignore_patterns = {
            "node_modules/.*",
            "__pycache__/.*",
            ".git/.*",
            "build/.*",
            "deps/.*",
            "dist/.*",
            "platforms/.*",
            "hooks/.*",
            "media/.*",
            "tmp/.*",
            "%.pyc",
        },
        prompt_prefix = "> ",
        color_devicons = true,
        layout_strategy = 'vertical',
        layout_config = {
            height = 0.95,
            width = 0.65,
        },
    },
})
telescope.load_extension("git_worktree")
