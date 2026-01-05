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
            vim.keymap.set("n", "<leader>rn", function()
                local params = vim.lsp.util.make_position_params()
                local new_name = vim.fn.input("New name: ", vim.fn.expand("<cword>"))
                if new_name == "" or new_name == vim.fn.expand("<cword>") then return end

                params.newName = new_name
                vim.lsp.buf_request(0, "textDocument/rename", params, function(err, result, ctx)
                    if err then
                        vim.notify("Rename failed: " .. tostring(err), vim.log.levels.ERROR)
                        return
                    end
                    if result then
                        vim.lsp.util.apply_workspace_edit(result, "utf-8")
                        vim.defer_fn(function()
                            for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
                                if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].modified then
                                    vim.api.nvim_buf_call(bufnr, function()
                                        vim.cmd("silent! write")
                                    end)
                                end
                            end
                        end, 100)
                    end
                end)
            end, { buffer = args.buf, desc = "Rename and save all" })

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
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
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
                textobjects = {
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>a"] = "@parameter.inner",
                            ["<leader>m"] = "@function.outer",
                        },
                        swap_previous = {
                            ["<leader>A"] = "@parameter.inner",
                            ["<leader>M"] = "@function.outer",
                        },
                    },
                },
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
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            if ok then
                capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
            end

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {"pyrefly", "lua_ls", "ts_ls", "terraformls"}
            })

            vim.lsp.config("ts_ls", { capabilities = capabilities })
            vim.lsp.config("lua_ls", { capabilities = capabilities })
            vim.lsp.config("pyrefly", { capabilities = capabilities })
            vim.lsp.config("terraformls", { capabilities = capabilities })

            vim.lsp.enable("ts_ls")
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("pyrefly")
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
