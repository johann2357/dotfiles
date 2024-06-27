vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("GoFmt", { clear = true }),
    pattern = {"*.go"},
    callback = function()
        if vim.fn.executable("go") == 0 then
            print("go command not found")
            return
        end
        local current_file = vim.fn.expand("%:p")
        local current_dir = vim.fn.expand("%:p:h")
        -- TODO: Iterrate over the parent directories to find the go.mod file
        local current_go_mod = current_dir .. "/go.mod"
        if vim.fn.filereadable(current_go_mod) == 0 then
            print(current_go_mod .. " not found")
            return
        end
        vim.fn.jobstart({ "go", "fmt", current_file }, {
            stdout_buffered = false,
            stderr_buffered = true,
            on_stdout = function(_, data)
                if data and #data > 0 then
                    vim.api.nvim_command('edit!')
                end
            end,
            on_stderr = function(_, data)
                if data and #data > 0 then
                    print(vim.inspect(data))
                end
            end,
        })
    end,
})
