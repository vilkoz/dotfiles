execute pathogen#infect()

map <C-x> :NERDTreeToggle<CR>
map <f5> :make f<CR>
filetype plugin indent on
set tabstop=4
set noexpandtab
set shiftwidth=4

syntax on
set mouse=a
set rnu

" {{ Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" }} Syntastic

" {{ Neocomplete
set fileencodings=utf8,cp1251
let g:neocomplete#enable_at_startup = 1
" }}

colorscheme Kafka

" Search in subsubdir
set path+=**

" Display all matching files when we tab complete
set wildmenu
