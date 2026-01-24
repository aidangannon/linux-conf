vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set({'n', 'i', 'v', 'x', 's', 'o'}, '<C-c>', '<Nop>')

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

vim.keymap.set({'n', 'v'}, '<Left>', 'h')
vim.keymap.set({'n', 'v'}, '<Right>', 'l')
vim.keymap.set({'n', 'v'}, '<Up>', 'k')
vim.keymap.set({'n', 'v'}, '<Down>', 'j')

vim.keymap.set({'n', 'v'}, 'h', '<Nop>')
vim.keymap.set({'n', 'v'}, 'j', '<Nop>')
vim.keymap.set({'n', 'v'}, 'k', '<Nop>')
vim.keymap.set({'n', 'v'}, 'l', '<Nop>')
