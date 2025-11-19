vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.tabstop = 4 
vim.opt.shiftwidth = 4 
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.clipboard = 'unnamedplus'

vim.g.mapleader = ' '

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
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = { 'ts_ls', 'pyright', 'pylsp' }
      })
      
      vim.lsp.enable('ts_ls')
      vim.lsp.enable('pyright')
      vim.lsp.enable('pylsp')
      
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf })
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = args.buf })
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = args.buf })
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = args.buf })
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = args.buf })
          vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { buffer = args.buf })
        end,
      })
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete()
        }),
        sources = {
          { name = 'nvim_lsp' },
        }
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup()
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')
      vim.keymap.set('n', '<leader>ef', ':NvimTreeFindFile<CR>')
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
      vim.keymap.set('n', '<leader>fw', builtin.lsp_workspace_symbols, {})
    end,
  },
  {
  'projekt0n/github-nvim-theme',
    config = function()
      require('github-theme').setup()
      vim.cmd('colorscheme github_light')
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'python', 'typescript', 'javascript', 'lua' },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
})

vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
