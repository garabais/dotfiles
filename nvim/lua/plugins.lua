local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

local first_run = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  first_run = true
end

require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Color Schemes
  use 'arcticicestudio/nord-vim'
  
  -- LSP
  use {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    cmd = {'LspInfo', 'LspRestart', 'LspStart', 'LspStop', 'LspInstall', 'LspUninstall'},
  }
  use {
    'kabouzeid/nvim-lspinstall', 
    after = {'nvim-lspconfig'},
    config = function()
      require('config.lsp')
    end
  }

  -- Status line
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    event = 'BufWinEnter',
    -- Some optional icons
    requires = {{'kyazdani42/nvim-web-devicons'}},
    config = function()
      require('config.statusline')
    end
  }

  -- Quality of life
  use 'airblade/vim-rooter'
  use {
    'tpope/vim-commentary',
    event = 'BufRead',
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

  -- Autocompletion
  use {
    'hrsh7th/nvim-compe',
    event = 'InsertEnter',
    config = function()
      require('config.compe')
    end
  }

  use {
    'hrsh7th/vim-vsnip', 
    after = 'nvim-compe',
    event = 'InsertEnter'
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}, {'kyazdani42/nvim-web-devicons'}},
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
    requires = {
      'nvim-lua/plenary.nvim'
    }
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
