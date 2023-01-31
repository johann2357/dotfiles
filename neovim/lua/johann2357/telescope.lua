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
        layout_strategy = "vertical",
        layout_config = {
            height = 0.95,
            width = 0.65,
        },
    },
})
telescope.load_extension("git_worktree")

local telescope_builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>t", telescope_builtin.git_files)
vim.keymap.set("n", "<Leader>g", telescope_builtin.git_status)
vim.keymap.set("n", "<Leader>f", telescope_builtin.find_files)
vim.keymap.set("n", "<Leader>l", telescope_builtin.diagnostics)
vim.keymap.set("n", "<Leader>L", telescope_builtin.lsp_references)
vim.keymap.set("n", "<Leader>d", telescope_builtin.lsp_definitions)
vim.keymap.set("n", "<Leader>h", telescope_builtin.help_tags)
vim.keymap.set("n", "<Leader>r", telescope_builtin.live_grep)
vim.keymap.set("n", "<Leader>R", telescope_builtin.grep_string)
vim.keymap.set("n", "<Leader>b", telescope_builtin.current_buffer_fuzzy_find)
vim.keymap.set("n", "<Leader>m", telescope_builtin.man_pages)
vim.keymap.set("n", "<Leader>'", telescope_builtin.keymaps)

local telescope_extensions = require("telescope").extensions
-- git-worktree
-- <Enter> - switches to that worktree
-- <c-d> - deletes that worktree
-- <c-f> - toggles forcing of the next deletion
vim.keymap.set("n", "<Leader>w", telescope_extensions.git_worktree.git_worktrees)
vim.keymap.set("n", "<Leader>c", telescope_extensions.git_worktree.create_git_worktree)

