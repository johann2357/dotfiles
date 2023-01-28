require("zen-mode").setup {
    window = {
        width = 120,
        options = {
            number = true,
            relativenumber = true,
        }
    },
}

vim.keymap.set("n", "<leader>zz", function()
    require("zen-mode").toggle()
    vim.wo.wrap = false
    -- TurnOffTheLights() change vimscript to lua
end)
