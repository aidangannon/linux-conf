-- Configure Roslyn LSP directly (like the working config)
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Integrate with nvim-cmp if available
local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

vim.lsp.config("roslyn", {
    capabilities = capabilities,
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
            dotnet_analyzer_diagnostics_scope = "openFiles",
            dotnet_compiler_diagnostics_scope = "openFiles",
        },
    },
})

vim.api.nvim_create_user_command("CSharpSetup", function()
    vim.cmd("MasonInstall roslyn csharpier")
end, { desc = "Install C# tools" })

vim.api.nvim_create_user_command("RoslynRestart", function()
    vim.cmd("LspRestart roslyn")
end, { desc = "Restart Roslyn LSP" })

return {
    lsp = {
        "seblyng/roslyn.nvim",
        -- NO ft lazy loading - seblyng says it causes issues
        opts = {
            filewatching = "roslyn", -- Explicitly use Roslyn's file watcher (important for WSL)
        },
    },
}
