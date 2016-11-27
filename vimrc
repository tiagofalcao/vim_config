"git --work-tree=${HOME}/.vim submodule update --init --checkout

set nocompatible
filetype plugin indent on
syntax enable

set background=dark
colorscheme badwolf

set autoindent
set noexpandtab
set tabstop=2
set shiftwidth=2

set spell
setlocal spell spelllang=en_us

" Get the current OS
let g:os = substitute(system('uname -s'), "\n", "", "")

let g:languagetool_jar = '$HOME/opt/languagetool/languagetool-commandline.jar'

let g:tex_flavor='latex'
let fts = ['tex']
if index(fts, &filetype) == -1
	set iskeyword+=:
	let g:vimtex_quickfix_autojump = 1
	let g:vimtex_quickfix_mode = 1
	map <F10> :LanguageToolCheck<CR>
	map <F9> :LanguageToolClear<CR>
	if g:os == "Linux"
		if executable('mupdf')
			let g:vimtex_view_method = 'mupdf'
			let g:vimtex_view_mupdf_send_keys = 'r'
		endif
	elseif g:os == "Darwin"
		let g:vimtex_view_general_viewer = "/Applications/Skim.app/Contents/SharedSupport/displayline"
		let g:vimtex_view_general_options = "-g -r @line @pdf @tex"
	endif
endif

"--------------------------------------------------------------------------------
" Persistent UNDO
"--------------------------------------------------------------------------------

" set a directory to store the undo history
set undodir=${HOME}/.vim/undo
" tell it to use an undo file
set undofile
" maximum number of changes that can be undone
"set undolevels=1000
" maximum number lines to save for undo on a buffer reload
"set undoreload=10000

"--------------------------------------------------------------------------------
" LLVM file
"--------------------------------------------------------------------------------

augroup filetype
  au! BufRead,BufNewFile *.ll     set filetype=llvm
augroup END


"--------------------------------------------------------------------------------
" ctrlp.vim
"--------------------------------------------------------------------------------

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

"--------------------------------------------------------------------------------
" vim-airline
"--------------------------------------------------------------------------------

set laststatus=2

" set the symbol dictionary as the one of powerline
let g:airline_powerline_fonts = 1

"" powerline symbols
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

"--------------------------------------------------------------------------------
" clang-format
"--------------------------------------------------------------------------------

let g:clang_format#code_style = 'llvm'

"--------------------------------------------------------------------------------
" TagBar
"--------------------------------------------------------------------------------

"shortcut to TabBar
nnoremap <silent> <Leader>b :TagbarToggle<CR>

" --------------------------------------------------------------------------------
" Using Silver Searcher AG: https://github.com/ggreer/the_silver_searcher
"--------------------------------------------------------------------------------
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
	let g:ctrlp_use_caching = 0

	"let g:ackprg = 'ag --vimgrep'
	let g:ackprg = 'ag --nogroup --nocolor --column'

	" bind K to grep word under cursor
	nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
endif

"--------------------------------------------------------------------------------
" Syntastic
"--------------------------------------------------------------------------------

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_tex_checkers = ['chktex']
let g:syntastic_tex_chktex_showmsgs = 3

"--------------------------------------------------------------------------------
" NERDTree
"--------------------------------------------------------------------------------

map <F12> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL

