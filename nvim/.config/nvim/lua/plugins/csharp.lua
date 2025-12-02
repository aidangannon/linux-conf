local function c_sharp_setup_cmd()
    vim.api.nvim_create_user_command("CSharpSetup", function()
        vim.cmd("MasonInstall roslyn csharpier")
    end, { desc = "Install C# tools" })
end

c_sharp_setup_cmd()

return {
    lsp = {
        "seblyng/roslyn.nvim",
        ft = "cs",
        opts = {
            filewatching = "roslyn"
        },
        settings = {
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
    },
    filewatching = {
        "khoido2003/roslyn-filewatch.nvim",
        config = function()
            require("roslyn_filewatch").setup({})
        end
    }
}
