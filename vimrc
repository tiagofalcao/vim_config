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


if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
	let g:ctrlp_use_caching = 0

	"let g:ackprg = 'ag --vimgrep'
	let g:ackprg = 'ag --nogroup --nocolor --column'

	" bind K to grep word under cursor
	nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
endif



highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL

map <F12> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

