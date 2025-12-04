return {
    "RRethy/base16-nvim",
    config = function()
        vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })

        vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName", { fg = "#666666" })
        vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#000000" })
        vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "#000000" })
        vim.api.nvim_set_hl(0, "NvimTreeVertSplit", { bg = "#000000" })

        require('base16-colorscheme').setup({
            base00 = '#000000',
            base01 = '#1a1a1a',
            base02 = '#2d2d2d',
            base03 = '#666666',
            base04 = '#cccccc',
            base05 = '#ffffff',
            base06 = '#ffffff',
            base07 = '#ffffff',
            base08 = '#ffffff',
            base09 = '#F9F1A5',
            base0A = '#61D6D6',
            base0B = '#16C60C',
            base0C = '#3B78FF',
            base0D = '#3B78FF',
            base0E = '#F9F1A5',
            base0F = '#16C60C',
        })
    end
}

