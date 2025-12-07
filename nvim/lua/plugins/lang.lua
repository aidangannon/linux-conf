vim.diagnostic.config({
    update_in_insert = true,
    virtual_text = true,
    signs = true,
    underline = true,
    severity_sort = true,
})

local function lsp_keymaps()
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf })
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = args.buf })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = args.buf })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf })
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = args.buf })
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf })
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = args.buf })
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = args.buf })
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = args.buf })
        end
    })
end

local code_navigation_keys = {
    { "[s", "<cmd>AerialPrev<cr>", desc = "Previous symbol" },
    { "]s", "<cmd>AerialNext<cr>", desc = "Next symbol" },
    { "<leader>a", "<cmd>AerialToggle<cr>", desc = "Toggle aerial outline" }
}

lsp_keymaps()

return {
    navigation = {
        "stevearc/aerial.nvim",
        opts = {},
        keys = code_navigation_keys
    },
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
            -- Get capabilities from nvim-cmp
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            if ok then
                capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
            end

            require("mason").setup()
            require("mason-lspconfig").setup({}) -- Empty setup for auto-discovery

            -- Configure all servers consistently with vim.lsp.config()
            vim.lsp.config("ts_ls", { capabilities = capabilities })
            vim.lsp.config("lua_ls", { capabilities = capabilities })
            vim.lsp.config("pyright", { capabilities = capabilities })
            vim.lsp.config("terraformls", { capabilities = capabilities })

            -- Enable servers
            vim.lsp.enable("ts_ls")
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("pyright")
            vim.lsp.enable("terraformls")
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
                    ["<CR>"] = cmp.mapping.confirm({
                        select = true,
                        behavior = cmp.ConfirmBehavior.Replace
                    }),
                    ["<C-Space>"] = cmp.mapping.complete()
                }),
                sources = {
                    { name = "nvim_lsp" }
                },
                experimental = {
                    ghost_text = true
                }
            })
        end
    }
}
