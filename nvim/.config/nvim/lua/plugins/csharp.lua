vim.api.nvim_create_user_command("CSharpSetup", function()
    vim.cmd("MasonInstall roslyn csharpier")
end, { desc = "Install C# tools" })

return {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    opts = {}
}
