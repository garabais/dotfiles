" Leader
    let mapleader=" "

" =============================================================================
" # Plugins
" =============================================================================

	lua require('plugins')

" =============================================================================
" # Theme
" =============================================================================

	" Overriding the colorscheme in a proper way
	augroup nord-theme-overrides
		autocmd!
		autocmd ColorScheme nord hi Normal ctermbg=NONE guibg=NONE
		autocmd ColorScheme nord hi SignColumn ctermbg=NONE guibg=NONE
		autocmd ColorScheme nord hi ColorColumn ctermbg=NONE guibg=NONE
		autocmd ColorScheme nord hi SpellBad ctermbg=NONE guibg=NONE
		autocmd ColorScheme nord hi SpellCap ctermbg=NONE guibg=NONE
		autocmd ColorScheme nord hi SpellRare ctermbg=NONE guibg=NONE
		autocmd ColorScheme nord hi SpellLocal ctermbg=NONE guibg=NONE
		autocmd ColorScheme nord hi foldColumn gui=bold cterm=bold ctermfg=06 guifg=#ECEFF4 guibg=None ctermbg=None
	augroup END

	" Colorscheme declaration should be after autocmd overriding it
	" or have 'filetype plugin indent on' and 'syntax on' before using hi
	colorscheme nord
	set noshowmode
	if has("termguicolors")
		set termguicolors
	endif

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

	" Update packer configuration on save
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
