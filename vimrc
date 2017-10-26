execute pathogen#infect()

map <C-x> :NERDTreeToggle<CR>
map <f5> :make -C ../ f<CR>
filetype plugin indent on
set tabstop=4
set noexpandtab
set shiftwidth=4

syntax on
set mouse=a
set rnu

"" {{ Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"" let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"" }} Syntastic

" {{ Neocomplete
set fileencodings=utf8,cp1251
let g:neocomplete#enable_at_startup = 1
" }}

colorscheme Kafka

" Search in subsubdir
set path+=**

" Display all matching files when we tab complete
set wildmenu
set laststatus=2

set cc=80

" Man in vim
runtime ftplugin/man.vim

"" {{ ALE
let g:ale_c_gcc_options = '-Wall -Wextra -Werror -I../includes -I./includes'
let g:ale_c_clang_options = '-Wall -Wextra -Werror -I../includes -I./includes'
""}} ALE

"" show invisibles
set listchars=eol:¬,tab:>_,trail:~,extends:>,precedes:<,space:␣
set list

" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
	if exists(':NeoCompleteLock')==2
		exe 'NeoCompleteLock'
	endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
	if exists(':NeoCompleteUnlock')==2
		exe 'NeoCompleteUnlock'
	endif
endfunction

hi SpecialKey ctermfg=black
set hlsearch

nnoremap ; :
