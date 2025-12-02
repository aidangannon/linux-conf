local function c_sharp_setup_cmd()
    vim.api.nvim_create_user_command("CSharpSetup", function()
        vim.cmd("MasonInstall roslyn csharpier")
    end, { desc = "Install C# tools" })
end

c_sharp_setup_cmd()

vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.cs",
    callback = function(args)
        vim.defer_fn(function()
            if vim.fn.filereadable(vim.fn.expand("%")) == 0 then
                vim.cmd("write")
            end

            for _, client in ipairs(vim.lsp.get_clients({name = "roslyn"})) do
                client.notify("workspace/didChangeWatchedFiles", {
                    changes = {{ uri = vim.uri_from_bufnr(args.buf), type = 1 }}
                })
                vim.lsp.buf_attach_client(args.buf, client.id)
            end
        end, 50)
    end
})

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
            filewatching = "auto",
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
                    ["csharp|background_analysis"] = {
                        dotnet_compiler_diagnostics_scope = "fullSolution",
                        dotnet_analyzer_diagnostics_scope = "fullSolution"
                    }
                }
            }
        }
    },
}
