local function c_sharp_setup_cmd()
    vim.api.nvim_create_user_command("CSharpSetup", function()
        vim.cmd("MasonInstall roslyn csharpier")
    end, { desc = "Install C# tools" })
end

local function sync_filesys_to_namespace_autocmd()
    vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*.cs",
        callback = function()
            vim.defer_fn(function()
                vim.lsp.buf.code_action({
                    filter = function(action)
                        return action.title:match("namespace") ~= nil
                    end,
                    apply = true,
                })
            end, 300)
        end
    })
end

c_sharp_setup_cmd()
sync_filesys_to_namespace_autocmd()

-- Configure roslyn BEFORE the plugin loads
vim.lsp.config("roslyn", {
    settings = {
        ["csharp|completion"] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
        }
    }
})

return {
    "seblyng/roslyn.nvim",
    lazy = false,
    opts = {}
}
