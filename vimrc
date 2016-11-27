set nocompatible
filetype plugin indent on
syntax enable

set sw=2

set spell
setlocal spell spelllang=en_us

let g:tex_flavor='latex'
let fts = ['tex']
if index(fts, &filetype) == -1
	set iskeyword+=:
	let g:vimtex_viewer_zathura = 1
	let g:vimtex_view_general_viewer = 'zathura'
	let g:vimtex_quickfix_autojump = 1
	let g:vimtex_quickfix_mode = 1
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
