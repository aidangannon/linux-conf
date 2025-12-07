local snacks_keymaps = {
    { "<leader>ff", function() Snacks.picker.files() end },
    { "<leader>fg", function() Snacks.picker.grep() end },
    { "<leader>fs", function() Snacks.picker.lsp_symbols() end },
    { "<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end },
    { "<leader>rF", function() Snacks.rename.rename_file() end },
}

local function nvim_tree_keymaps()
    vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>")
    vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>")
end

local function on_nvim_tree_attach(bufnr)
    local api = require("nvim-tree.api")
    api.config.mappings.default_on_attach(bufnr)
end

nvim_tree_keymaps()

return {
    files = {
        "folke/snacks.nvim",
        lazy = false,
        opts = {
            picker = { enabled = true },
            rename = { enabled = true }
        },
        keys = snacks_keymaps
    },
    explorer = {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "folke/snacks.nvim" },
        config = function()
            require("nvim-tree").setup({
                on_attach = on_nvim_tree_attach,
                renderer = {
                    full_name = true,
                },
                view = {
                    width = 40,
                },
            })
        end
    }
}
