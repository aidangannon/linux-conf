return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "ts_ls", "pyright" }
        })
        
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
              vim.keymap.set("n", 'gd', vim.lsp.buf.definition, { buffer = args.buf })
              vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf })
              vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = args.buf })
              vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf })
              vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = args.buf })
              vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = args.buf })
              vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = args.buf })
            end
        })

        vim.lsp.enable("ts_ls")
        vim.lsp.enable("pyright")
    end
}
