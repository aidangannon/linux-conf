local function keymaps()
    local fzf = require("fzf-lua")
    vim.keymap.set("n", "<leader>ff", fzf.files)
    vim.keymap.set("n", "<leader>fg", fzf.live_grep)
    vim.keymap.set("n", "<leader>fs", fzf.lsp_document_symbols)
end

return {
    "ibhagwan/fzf-lua",
    config = keymaps
}
