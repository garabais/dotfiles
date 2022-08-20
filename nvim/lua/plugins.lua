local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

local first_run = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
  first_run = true
end

require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Color Schemes
  use { 'arcticicestudio/nord-vim' }

  -- LSP
  use {
    'williamboman/nvim-lsp-installer',
    cmd = { 'LspInfo', 'LspRestart', 'LspStart', 'LspStop', 'LspInstall', 'LspUninstall', 'LspInstallInfo', 'LspUninstallAll', 'LspInstallLog', 'LspPrintInstalled' },
    event = 'BufReadPre',
    wants = { 'nvim-lspconfig' },
    requires = {
      { 'neovim/nvim-lspconfig', opt = true }, -- Mark as optional to lazy load with lsp installer
    },
    config = function()
      require('config.lsp')
    end
  }

  -- Status line
  use {
    'NTBBloodbath/galaxyline.nvim',
    event = 'BufWinEnter',
    -- Some optional icons
    requires = {
      { 'kyazdani42/nvim-web-devicons' },
    },
    config = function()
      require('config.statusline')
    end
  }
  -- https://github.com/akinsho/bufferline.nvim
  -- use {
  --   'nvim-lualine/lualine.nvim',
  --   requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  --   config = function()
  --     require('config.statusline')
  --   end
  -- }

  -- Quality of life
  use 'airblade/vim-rooter'

  use {
    'numToStr/Comment.nvim',
    event = 'BufRead',
    config = function()
      require('config.comment')
    end
  }

  use {
    'jiangmiao/auto-pairs',
    event = 'BufEnter',
  }

  use {
    'machakann/vim-highlightedyank',
    event = 'BufEnter'
  }


  -- Syntax highlight and more
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    event = 'BufRead',
    config = function()
      require('config.treesiter')
    end
  }

  -- Completion and Snippets
  use {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdLineEnter' },
    wants = { 'LuaSnip', 'lspkind-nvim' },
    config = function()
      require('config.completion')
    end,
    requires = {
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-lspconfig' },
      -- { 'f3fora/cmp-spell', after = 'nvim-cmp' },
      -- { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      -- { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      -- { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      -- { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
      { 'onsails/lspkind-nvim', after = 'nvim-cmp' },
    },
  }

  use {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    requires = {
      { 'rafamadriz/friendly-snippets' },
    },
    config = function()
      -- The load path may change depending on the platform and if you use lazy loading or not (start/opt)
      require('luasnip/loaders/from_vscode').load({ paths = { '~/.local/share/nvim/site/pack/packer/start/friendly-snippets' } })
    end
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'kyazdani42/nvim-web-devicons' }
    },
    event = 'BufEnter',
    cmd = 'Telescope',
    config = function()
      require('config.telescope')
    end
  }

  -- Git
  use {
    'tpope/vim-fugitive',
    event = 'BufRead',
    cmd = 'Git',
  }

  use {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    config = function()
      require('config.gitsigns')
    end,
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- Fish support
  use {
    'dag/vim-fish',
    ft = 'fish'
  }

end)

if first_run then
  vim.api.nvim_command('PackerInstall')
  vim.api.nvim_command('PackerCompile')
end
