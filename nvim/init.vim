" Leader
    let mapleader=" "

" =============================================================================
" # Plugins
" =============================================================================

	call plug#begin(stdpath('data') . '/plugged')

		" Color Schemes
		Plug 'arcticicestudio/nord-vim'

		" Visual enhancements
		" Plug 'itchyny/lightline.vim'
		Plug 'machakann/vim-highlightedyank'
		Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
		Plug 'kyazdani42/nvim-web-devicons'

		" LSP
		Plug 'neovim/nvim-lspconfig'
		"Plug 'nvim-lua/lsp_extensions.nvim'

		" Autocompletion
		Plug 'hrsh7th/nvim-compe'
		Plug 'hrsh7th/vim-vsnip'

		" Syntax highlight
		Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  

		" Quality of life
		Plug 'airblade/vim-rooter'
		Plug 'preservim/nerdcommenter'
		Plug 'jiangmiao/auto-pairs'
		" Plug 'tpope/vim-surround'

		" Telescope
		Plug 'nvim-lua/popup.nvim'
		Plug 'nvim-lua/plenary.nvim'
		Plug 'nvim-telescope/telescope.nvim'
		
		" Git
		Plug 'tpope/vim-fugitive'
		Plug 'lewis6991/gitsigns.nvim'

		" Fish script syntax
		Plug 'dag/vim-fish'

	call plug#end()



" =============================================================================
" # Theme
" =============================================================================

	" Run this command to get highlight groups undercursor when treesitter is disbled
	" execute 'hi' synIDattr(synID(line("."), col("."), 1),"name")
	
	colorscheme nord
	hi Normal ctermbg=NONE guibg=NONE
	hi SignColumn ctermbg=NONE guibg=NONE
	hi ColorColumn ctermbg=NONE guibg=NONE
	hi SpellBad ctermbg=NONE guibg=NONE
	hi SpellCap ctermbg=NONE guibg=NONE
	hi SpellRare ctermbg=NONE guibg=NONE
	hi SpellLocal ctermbg=NONE guibg=NONE
	hi! link LspReferenceRead Visual
	hi! link LspReferenceText Visual
	hi! link LspReferenceWrite Visual
	set noshowmode
	if has("termguicolors")
		set termguicolors
	endif

" =============================================================================
" # Lua plugins files
" =============================================================================

	lua require('galaxyline-config')
	lua require('treesitter-config')
	lua require('telescope-config')
	lua require('gitsigns-config')
	lua require('lsp-config')
	lua require('compe-config')

" =============================================================================
" # Editor settings
" =============================================================================

	" Basic
	set number relativenumber
	set encoding=utf-8
	
	" Add mouse support
	set mouse+=a

	" Share clipboard with system
	set clipboard=unnamedplus
	
	" Tabs
	set tabstop=4
	set noexpandtab
	set shiftwidth=4
	set softtabstop=4

	" Splits
	set splitbelow splitright

	" Save the last position in the file
	autocmd BufReadPost *
		\ if line("'\"") >= 1 && line("'\"") <= line("$") |
		\   exe "normal! g`\"" |
		\ endif

	" Add sign column for errors/warnings
	set signcolumn=yes

	" Undo
	set undodir=~/.local/share/nvim/undodir
	set undofile

	" Better search (CHECK)
	set incsearch
	set ignorecase
	set smartcase
	" set gdefault

	" Orthography
	set spelllang=en_us
	set complete+=kspell

	" You will have bad experience for diagnostic messages when it's default 4000.
	set updatetime=300

	" Give more space for displaying messages.
	set cmdheight=2

	" Remove 'Pattern not found' on autocompletion
	set shortmess+=c

" =============================================================================
" # Plugins settings
" =============================================================================

	" Nerd commenter
		" Add spaces after comment delimiters by default
		let g:NERDSpaceDelims = 1

		 " Use compact syntax for prettified multi-line comments
		let g:NERDCompactSexyComs = 1

		" Align line-wise comment delimiters flush left instead of following code indentation
		let g:NERDDefaultAlign = 'left'
		let g:NERDCustomDelimiters = {
			\ 'gitconfig': { 'left': '#'}
		\ }

		let g:NERDCreateDefaultMappings = 0

" =============================================================================
" # Keyboard shortcuts
" =============================================================================
	
	" No arrow keys --- force yourself to use the home row
	nnoremap <up> <nop>
	nnoremap <down> <nop>
	inoremap <up> <nop>
	inoremap <down> <nop>
	inoremap <left> <nop>
	inoremap <right> <nop>

	" Left and right can switch buffers
	nnoremap <left> :bp<CR>
	nnoremap <right> :bn<CR>

	" <leader><leader> toggles between buffers
	nnoremap <leader><leader> <c-^>

	" Disable Q as exmode
	nmap Q <Nop>

	" Search results centered please
	nnoremap <silent> n nzz
	nnoremap <silent> N Nzz
	nnoremap <silent> * *zz
	nnoremap <silent> # #zz
	nnoremap <silent> g* g*zz

	" Quick-save
	nmap <C-s> :w<CR>
	imap <C-s> <Esc>:w<CR>a

	" Orthography
	nmap <leader>oo :setlocal spell!<CR>
	" nmap <leader>on ]s
	" nmap <leader>op [s
	nmap <leader>oa zg
	nmap <leader>oA zw
	nmap <leader>oc z=

	" Nerd Commenter
	nmap <leader>cc <plug>NERDCommenterToggle
	xmap <leader>cc <plug>NERDCommenterToggle

	" LSP
	inoremap <silent><expr> <C-Space> compe#complete()
	inoremap <silent><expr> <CR>      compe#confirm('<CR>')
	inoremap <silent><expr> <C-e>     compe#close('<C-e>')
	inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
	inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

	inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
	inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"

	" Telescope
	nnoremap <leader>ff <cmd>Telescope find_files<cr>
	nnoremap <leader>fg <cmd>Telescope live_grep<cr>
	nnoremap <leader>fb <cmd>Telescope buffers<cr>
	nnoremap <leader>fh <cmd>Telescope help_tags<cr>
	" nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
	" nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
	" nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
	" nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" =============================================================================
" # Files settings
" =============================================================================

	filetype plugin indent on

	" File detection
		" Markdown detection
		autocmd BufRead *.md set filetype=markdown

		" LaTex detection
		autocmd BufRead *.tex set filetype=tex

	" FileType rules
		" Shorter columns in text
		  autocmd Filetype tex setlocal spell tw=80 colorcolumn=81
		  autocmd Filetype text setlocal spell tw=72 colorcolumn=73
		  autocmd Filetype markdown setlocal spell tw=72 colorcolumn=73

	" Orthography
		" Set some files to automatically have spell completion
			autocmd FileType markdown setlocal spell
			autocmd FileType gitcommit setlocal spell

