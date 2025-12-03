local function c_sharp_setup_cmd()
    vim.api.nvim_create_user_command("CSharpSetup", function()
        vim.cmd("MasonInstall roslyn csharpier")
    end, { desc = "Install C# tools" })

    vim.api.nvim_create_user_command("CSharpNotifyFile", function()
        for _, client in ipairs(vim.lsp.get_clients({name = "roslyn"})) do
            client.notify("workspace/didChangeWatchedFiles", {
                changes = {{ uri = vim.uri_from_bufnr(0), type = 1 }}
            })
        end
    end, { desc = "Notify Roslyn of file change" })
end

c_sharp_setup_cmd()

-- Notify Roslyn on file create
vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.cs",
    callback = function(args)
        -- Save the file first so it exists on disk
        vim.defer_fn(function()
            if vim.fn.filereadable(vim.fn.expand("%")) == 0 then
                vim.cmd("write")
            end

            for _, client in ipairs(vim.lsp.get_clients({name = "roslyn"})) do
                client.notify("workspace/didChangeWatchedFiles", {
                    changes = {{ uri = vim.uri_from_bufnr(args.buf), type = 1 }}
                })
                -- Also send didOpen to ensure Roslyn tracks the file
                vim.lsp.buf_attach_client(args.buf, client.id)
            end
        end, 50)
    end
})

-- Notify Roslyn on file delete
vim.api.nvim_create_autocmd("BufDelete", {
    pattern = "*.cs",
    callback = function(args)
        for _, client in ipairs(vim.lsp.get_clients({name = "roslyn"})) do
            client.notify("workspace/didChangeWatchedFiles", {
                changes = {{ uri = vim.uri_from_bufnr(args.buf), type = 3 }}
            })
        end
    end
})

-- Notify Roslyn on file write (covers renames/moves from file explorers)
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.cs",
    callback = function()
        for _, client in ipairs(vim.lsp.get_clients({name = "roslyn"})) do
            client.notify("workspace/didChangeWatchedFiles", {
                changes = {{ uri = vim.uri_from_bufnr(0), type = 2 }}
            })
        end
    end
})

return {
    lsp = {
        "seblyng/roslyn.nvim",
        ft = "cs",
        opts = {
            config = {
                settings = {
                    ["csharp|completion"] = {
                        dotnet_show_completion_items_from_unimported_namespaces = true,
                    },
                    ["csharp|inlay_hints"] = {
                        csharp_enable_inlay_hints_for_implicit_object_creation = true,
                        csharp_enable_inlay_hints_for_implicit_variable_types = true
                    },
                    ["csharp|code_lens"] = {
                        dotnet_enable_references_code_lens = true
                    },
                }
            }
        }
    },
}
