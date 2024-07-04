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
                    print("error formatting file")
                end
            end,
        })
    end,
})

local add_test_result = function(state, entry)
    local key = entry.Package .. "/" .. entry.Test
    if state[key] == nil then
        state[key] = {
            output = {},
            status = nil,
            result = nil,
            file_name = nil,
            line_number = nil,
        }
    end
end

local append_output = function(state, entry)
    local key = entry.Package .. "/" .. entry.Test
    local output = entry.Output
    table.insert(state[key].output, entry.Output)
    if string.match(output, "_test.go:") then
        local file_name, line_number = output:match("%s+(.-):(.-):")
        state[key].file_name = file_name
        state[key].line_number = tonumber(line_number)
    end
end

local add_result = function(state, entry)
    local key = entry.Package .. "/" .. entry.Test
    state[key].status = entry.Status
    state[key].result = entry
end

local debug_data = function(data)
    local data_str = vim.inspect(data)
    local lines = {}
    for line in data_str:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end
    vim.cmd.new()
    vim.api.nvim_buf_set_lines(vim.api.nvim_get_current_buf(), 0, -1, false, lines)
end

vim.api.nvim_create_user_command(
    'Test',
    function(_)
        local state = {}
        local ns_id = vim.api.nvim_create_namespace("CustomTest")
        local bufnr = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

        local current_file = vim.fn.expand("%:p")
        local current_dir = vim.fn.expand("%:p:h")
        local file_extension = vim.fn.expand("%:e")

        if (file_extension == "go") then
            if vim.fn.executable("go") == 0 then
                print("go command not found")
                return
            end
            vim.fn.jobstart({ "go", "test", "-v", "-json" }, {
                cwd = current_dir,
                stdout_buffered = true,
                on_stdout = function(_, data, _)
                    if not data then
                        print("No data received from tests")
                        return
                    end
                    for _, line in ipairs(data) do
                        local entry = vim.json.decode(line)
                        if entry.Action == "run" then
                            add_test_result(state, entry)
                        end
                        if entry.Action == "output" then
                            append_output(state, entry)
                        end
                        if entry.Action == "pass" or entry.Action == "fail" then
                            add_result(state, entry)
                        end
                    end
                end,
                on_stderr = function(_, _, _)
                    print("Error running tests")
                end,
                on_exit = function(_, _, _)
                    local failed = {}
                    for _, data in pairs(state) do
                        if data.result.Action == "fail" and string.match(current_file, data.file_name) then
                            local message = "Test failed"
                            for _, output in ipairs(data.output) do
                                local pattern = data.file_name .. ":" .. data.line_number .. ":"
                                if data.file_name and string.match(output, data.file_name) then
                                    message = output:gsub("%s+" .. pattern .. " ", "")
                                    message = message:gsub("\n", "")
                                    break
                                end
                            end
                            table.insert(failed, {
                                bufnr = bufnr,
                                lnum = data.line_number - 1,  -- 0 based
                                col = 0,
                                severity = vim.diagnostic.severity.ERROR,
                                source = "go-test",
                                message = message,
                                user_data = {},
                            })
                        end
                    end


                    if failed and #failed > 0 then
                        vim.diagnostic.set(ns_id, bufnr, failed, {})
                        print("some test(s) failed")
                    else
                        print("all tests passed")
                    end
                end,
            })
            return
        end
    end,
    { nargs = '?' }
)
