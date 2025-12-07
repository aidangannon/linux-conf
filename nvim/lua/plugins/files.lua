local snacks_keymaps = {
    { "<leader>ff", function() Snacks.picker.files() end },
    { "<leader>fg", function() Snacks.picker.grep() end },
    { "<leader>fs", function() Snacks.picker.lsp_symbols() end },
    { "<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end },
    { "<leader>rF", function() Snacks.rename.rename_file() end },
}

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
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
            { "<leader>ef", "<cmd>Neotree reveal<cr>", desc = "Reveal file in Neo-tree" },
        },
        opts = {
            close_if_last_window = true,
            filesystem = {
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                },
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
            },
            window = {
                position = "left",
                width = 30,
            },
        },
    }
}
