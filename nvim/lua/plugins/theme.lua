return {
    "folke/tokyonight.nvim",
    config = function()
        require("tokyonight").setup({
            style = "day",
        })
        vim.cmd("colorscheme tokyonight-day")
    end
}
