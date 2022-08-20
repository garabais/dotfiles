require 'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", or a list of languages
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "rust" }, -- list of language that will be disabled
  },
  indent = {
    enable = true
  }
}
