local function lsp_keymaps()
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf })
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = args.buf })
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf })
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = args.buf })
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = args.buf })
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = args.buf })
        end
    })
end

lsp_keymaps()

return {
    ats = {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "python",
                    "typescript",
                    "javascript",
                    "lua",
                    "hcl",
                    "terraform",
                    "c_sharp"
                },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    lsp = {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "ts_ls",
                    "pyright",
                    "lua_ls",
                    "terraformls"
                }
            })

            vim.lsp.enable("ts_ls")
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("pyright")
            vim.lsp.enable("terraformls")
            vim.lsp.config("roslyn", {})
        end
    },
    autocomplete = {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip"
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete()
                }),
                sources = {
                    { name = "nvim_lsp" }
                }
            })
        end
    }
}
