" Leader
    let mapleader=" "

" =============================================================================
" # Pluggins
" =============================================================================

	call plug#begin(stdpath('data') . '/plugged')

		" Visual enhancements
		Plug 'itchyny/lightline.vim'
		Plug 'machakann/vim-highlightedyank'
		Plug 'junegunn/goyo.vim'

		" Color Schemes
		Plug 'chriskempson/base16-vim'

		" fzf finder - git integration
		Plug 'airblade/vim-rooter'
		Plug 'junegunn/fzf'
		Plug 'junegunn/fzf.vim'

		" Facilities
		Plug 'preservim/nerdcommenter'
		Plug 'preservim/nerdtree'
		Plug 'jiangmiao/auto-pairs'
		Plug 'tpope/vim-surround'

		" Git
		Plug 'tpope/vim-fugitive'

		" Language server
		Plug 'neoclide/coc.nvim', {'branch': 'release'}

		" Go
		Plug 'fatih/vim-go'

		" Function signature
		Plug 'Shougo/echodoc'

		" C# for videogames class
		Plug 'OmniSharp/omnisharp-vim'

		" Plug 'dense-analysis/ale'

	call plug#end()

let g:ale_disable_lsp = 1
let g:ale_linters = {
\ 'cs': ['OmniSharp'],
\}
let b:ale_linters = ['cs']
" =============================================================================
" # Editor settings
" =============================================================================

	" Add mouse support
			set mouse+=a

	" Basic
		set number relativenumber
		syntax on
		set encoding=utf-8

	" Share clipboard with system
		set clipboard=unnamedplus


	" Tabs
		set tabstop=4
		set noexpandtab
		set shiftwidth=4
		set softtabstop=4


	" Splits
		set splitbelow splitright
		" map <C-h> <C-w>h
		" map <C-j> <C-w>j
		" map <C-k> <C-w>k
		" map <C-l> <C-w>l

	" Auto erase trailing whitespace and newlines
		autocmd bufWritePre * %s/\s\+$//e
		autocmd BufWritepre * %s/\n\+\%$//e

	" Save the last position in the file
		autocmd BufReadPost *
			\ if line("'\"") >= 1 && line("'\"") <= line("$") |
			\   exe "normal! g`\"" |
			\ endif

	" Undo
		set undodir=~/.local/share/nvim/undodir
		set undofile

	" Proper search (CHECK)
		set incsearch
		set ignorecase
		set smartcase
		set gdefault

	" Orthography
		" Enable spell completion and select the language
			set spelllang=en_us
			set complete+=kspell

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

	" FZF
		" let g:fzf_preview_window = ''

	" Nerd Tree
		if has('nvim')
			let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
		else
			let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
		endif

	" COC initial configuration
		" Text Edit might fail if hidden is not set.
			set hidden

			set pyxversion=3

		" Always show the sign column, otherwise it would shift the text each time
		" diagnostics appear/become resolved.
			if has("patch-8.1.1564")
			  " Recently Vim can merge sign column and number column into one
				set signcolumn=number
			else
				set signcolumn=yes
			endif

		" Give more space for displaying messages.
			set cmdheight=2

		" You will have bad experience for diagnostic messages when it's default 4000.
			set updatetime=300

		" Don't pass messages to |ins-completion-menu|.
			set shortmess+=c

		" Show signature help on placeholder jump
			autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

		" Highlight the symbol and its references when holding the cursor.
			autocmd CursorHold * silent call CocActionAsync('highlight')

		" Use autocmd to force lightline update.
			autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

		" Add `:Format` command to format current buffer.
			command! -nargs=0 Format :call CocAction('format')

		" Add `:Fold` command to fold current buffer.
			command! -nargs=? Fold :call     CocAction('fold', <f-args>)

		" Add `:OR` command for organize imports of the current buffer.
			command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

	" GO options

		" Disable gopls cause im only using the extension to syntax highlight
			let g:go_gopls_enabled = 0
			" let g:go_gopls_options = ['-remote=auto']

		" vim-go maps K to :GoDoc and don't let coc do the hover
			let g:go_doc_keywordprg_enabled = 0

		" This is handled by LanguageClient [LC]
			let g:go_def_mapping_enabled = 0

		" Go highlighting options
			let g:go_highlight_functions = 1
			let g:go_highlight_methods = 1
			let g:go_highlight_structs = 1
			let g:go_highlight_interfaces = 1
			let g:go_highlight_operators = 1
			let g:go_highlight_build_constraints = 1
			let g:go_highlight_extra_types = 1
			let g:go_highlight_function_parameters = 1
			let g:go_highlight_function_calls = 1
			let g:go_highlight_types = 1
			let g:go_highlight_fields = 1
			let g:go_highlight_build_constraints = 1

		" Function signature
			let g:echodoc#enable_at_startup=1
			let g:echodoc#type="floating"

" =============================================================================
" # Keyboard shortcuts
" =============================================================================

	" esc in insert mode
		inoremap kj <esc>

	" esc in command mode
		cnoremap kj <C-C>

	" esc in term mode
		tnoremap kj <C-\><C-n>
		" tnoremap <Esc> <C-\><C-n>

	" Disable Q as exmode
		nmap Q <Nop>

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

	" Search results centered please
		nnoremap <silent> n nzz
		nnoremap <silent> N Nzz
		nnoremap <silent> * *zz
		nnoremap <silent> # #zz
		nnoremap <silent> g* g*zz

	" Search alias
		" Replace all is aliased to S.
			nnoremap S :%s//g<Left><Left>

	" Quick-save
		nmap <C-s> :w<CR>
		nmap <Leader>w :w<CR>

	" Orthography
		" Add custom mappings to the spell checker
			nmap <leader>oo :setlocal spell!<CR>
			" nmap <leader>on ]s
			" nmap <leader>op [s
			nmap <leader>oa zg
			nmap <leader>oA zw
			nmap <leader>oc z=

	" Move in menu's using Ctrl+j/k
		inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "j"
		inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "k"

	" Nerd Commenter
		nmap <leader>cc <plug>NERDCommenterInvert
		xmap <leader>cc <plug>NERDCommenterInvert
		nmap <leader>ca <plug>NERDCommenterInsert
		xmap <leader>ca <plug>NERDCommenterInsert

	" FZF
		nnoremap <silent> <leader>ff :Files<CR>
		nnoremap <silent> <leader>fg :GFiles<CR>
		nnoremap <silent> <leader>fb :Buffers<CR>
		nnoremap <silent> <leader>fl :BLines<CR>
		nnoremap <silent> <leader>fc :BCommits<CR>

	" Nerd tree
		map <leader>n :NERDTreeToggle<CR>

	" COC
		" Use tab for trigger completion with characters ahead and navigate.
		" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
		" other plugin before putting this into your config.
			inoremap <silent><expr> <TAB>
				\ pumvisible() ? "\<C-n>" :
				\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
				\ <SID>check_back_space() ? "\<TAB>" :
				\ coc#refresh()

			inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


			" let g:coc_snippet_next = '<C-k>'
			" let g:coc_snippet_prev = '<C-j>'

		" Use <c-space> to trigger completion.
			if has('nvim')
			  inoremap <silent><expr> <c-space> coc#refresh()
			else
			  inoremap <silent><expr> <c-@> coc#refresh()
			endif

		" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
		" position. Coc only does snippet and additional edit on confirm.
			if exists('*complete_info')
				inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
			else
				imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
			endif


		" Use `[z` and `]z` to navigate diagnostics
			nmap <silent> [z <Plug>(coc-diagnostic-prev)
			nmap <silent> ]z <Plug>(coc-diagnostic-next)

		" GoTo code navigation.
			nmap <silent> gd <Plug>(coc-definition)
			nmap <silent> gy <Plug>(coc-type-definition)
			nmap <silent> gi <Plug>(coc-implementation)
			nmap <silent> gr <Plug>(coc-references)

		" Use K to show documentation in preview window.
			nnoremap <silent> K :call <SID>show_documentation()<CR>
			nnoremap <silent> <C-space> :call <SID>show_documentation()<CR>

		" Symbol renaming.
			nmap <leader>rn <Plug>(coc-rename)

		" Apply AutoFix to problem on the current line.
			nmap <leader>qf  <Plug>(coc-fix-current)

		" Use <TAB> for selections ranges.
			nmap <silent> <C-s> <Plug>(coc-range-select)
			xmap <silent> <C-s> <Plug>(coc-range-select)

		" Find symbol of current document.
			nnoremap <silent> <space>o  :<C-u>CocList outline<cr>

		" Search workspace symbols.
			nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

		" Implement methods for trait
			nnoremap <silent> <space>i  :call CocActionAsync('codeAction', '', 'Implement missing members')<cr>

		" Show actions available at this location
			nnoremap <silent> <space>a  :CocAction<cr>

" =============================================================================
" # Theme
" =============================================================================

		" let base16colorspace=256

		colorscheme base16-material
		hi SignColumn ctermbg=NONE
		hi LineNr ctermbg=NONE
		hi CursorLineNr ctermbg=NONE
		hi CursorColumn ctermbg=11
		hi Normal ctermbg=NONE
		hi ColorColumn ctermbg=NONE
		hi clear ModeMsg
		" set noshowmode


		let g:lightline = {
		\ 'colorscheme': 'wombat',
		\ 'active': {
		\   'left': [ [ 'mode', 'paste' ],
		\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
		\ },
		\ 'component_function': {
		\   'cocstatus': 'coc#status'
		\ },
		\ }

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

" =============================================================================
" # Functions
" =============================================================================

	" Function to enable autocomplete white tab
	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	" Function to show documentation of the hover word
	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		else
			call CocAction('doHover')
		endif
	endfunction
