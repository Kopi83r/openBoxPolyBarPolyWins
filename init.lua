-- ~/.config/nvim/init.lua

-- =============================================================================
-- Part 1: Bootstrap lazy.nvim (Plugin Manager)
-- =============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- Part 2: Basic Neovim Options (Good Defaults)
-- =============================================================================
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.tabstop = 2           -- Number of spaces a tab is
vim.opt.shiftwidth = 2        -- Number of spaces to use for auto-indent
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.smartindent = true    -- Be smart about indentation
vim.opt.wrap = false          -- Don't wrap lines

-- =============================================================================
-- Part 3: Configure and Install Plugins with lazy.nvim
-- =============================================================================
require("lazy").setup({
  -- Plugin specifications go here

  -- ===================================
  -- Plugin 1: Syntax Highlighting
  -- `nvim-treesitter` provides modern, fast, and accurate highlighting
  -- ===================================
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate', -- Command to update parsers
    config = function()
      require('nvim-treesitter.configs').setup({
        -- A list of parser names, or "all"
        ensure_installed = { "bash", "lua", "vim", "vimdoc", "c" },
        -- Automatically install missing parsers when entering a buffer
        auto_install = true,
        -- Enable syntax highlighting
        highlight = {
          enable = true,
        },
      })
    end,
  },

  -- ===================================
  -- Plugin 2: Autocompletion Engine (nvim-cmp) and its sources
  -- This is a suite of plugins that work together.
  -- ===================================
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp', -- Source for LSP (code suggestions)
      'hrsh7th/cmp-buffer',   -- Source for text in current buffer
      'hrsh7th/cmp-path',     -- Source for filesystem paths
      'L3MON4D3/LuaSnip',     -- Snippet engine
      'saadparwaiz1/cmp_luasnip', -- Bridge between cmp and luasnip
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        -- Keybindings for completion
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept suggestion
        }),
        -- Sources for completion
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' }, -- IMPORTANT: This enables path completion
        }, {
          { name = 'buffer' },
        })
      })
    end,
  },

  -- ===================================
  -- Plugin 3: LSP Configuration (to make autocompletion "smart")
  -- `nvim-lspconfig` helps configure language servers
  -- ===================================
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- This is where we configure language servers.
      -- We'll configure the Bash language server here.
      local lspconfig = require('lspconfig')

      -- Configure bash-language-server
      lspconfig.bashls.setup({})

      -- Keybindings for LSP actions (optional but recommended)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
    end,
  },

})

-- Set the leader key (optional, but many keymaps use it)
vim.g.mapleader = " "
