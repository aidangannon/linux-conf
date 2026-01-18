vim.cmd("colorscheme vim")

-- Override popup colors (removes magenta)
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#1c1c1c", fg = "#d0d0d0" })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#5f87af", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1c1c1c", fg = "#d0d0d0" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1c1c1c", fg = "#5f87af" })

require("options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "williamboman/mason.nvim",
        opts = {
            registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry"
            }
        }
    },
    require("plugins.csharp").lsp,
    require("plugins.lang").navigation,
    require("plugins.lang").ats,
    require("plugins.lang").lsp,
    require("plugins.lang").autocomplete,
    require("plugins.files").files,
    require("plugins.files").explorer,
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    }
})

require("keymaps")
require("autocmds")
