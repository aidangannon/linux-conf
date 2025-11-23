local function keymaps()
    require("nvim-tree").setup()
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
    vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>")
end

return {
    "nvim-tree/nvim-tree.lua",
    config = keymaps
}
