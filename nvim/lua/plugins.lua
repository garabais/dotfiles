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
  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall'

  -- Visual enhancements
  use 'machakann/vim-highlightedyank'
  use {
    'glepnir/galaxyline.nvim',
      branch = 'main',
      -- Some optional icons
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- Quality of life
  use 'tpope/vim-commentary'
  use 'airblade/vim-rooter'
  use 'jiangmiao/auto-pairs'


  -- Syntax highlight and more
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Autocompletion
  use 'hrsh7th/nvim-compe'
  use 'hrsh7th/vim-vsnip'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- Git
  use 'tpope/vim-fugitive'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  -- Fish support
  use 'dag/vim-fish'
end)

if first_run then
  vim.api.nvim_command('PackerInstall')
  vim.api.nvim_command('PackerCompile')
end


require('galaxyline-config')
require('treesitter-config')
require('telescope-config')
require('gitsigns-config')
require('lsp-config')
require('compe-config')
