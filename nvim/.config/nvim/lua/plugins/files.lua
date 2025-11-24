local snacks_keymaps = {
    { "<leader>ff", function() Snacks.picker.files() end },
    { "<leader>fg", function() Snacks.picker.grep() end },
    { "<leader>fs", function() Snacks.picker.lsp_symbols() end },
    { "<leader>rF", function() Snacks.rename.rename_file() end }
}

local function nvim_tree_keymaps()
    vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>")
    vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>")
end

local function on_nvim_tree_attach(bufnr)
    local api = require("nvim-tree.api")

    local function rename_with_lsp()
        local node = api.tree.get_node_under_cursor()
        if node then
            local old_path = node.absolute_path
            api.fs.rename_full(node)
            vim.schedule(function()
                local new_node = api.tree.get_node_under_cursor()
                if new_node and new_node.absolute_path ~= old_path then
                    Snacks.rename.on_rename_file(old_path, new_node.absolute_path)
                end
            end)
        end
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set('n', 'r', rename_with_lsp, { buffer = bufnr })
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
            })
        end
    }
}
