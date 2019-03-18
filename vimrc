"execute pathogen#infect()
call plug#begin('~/.vim/plugged')

" Plugins
Plug 'scrooloose/nerdtree'
Plug 'joom/vim-commentary'
Plug 'w0rp/ale'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'terryma/vim-multiple-cursors'
Plug 'drmikehenry/vim-headerguard'
"Plug 'wolfgangmehner/c-support'
Plug 'Shougo/neocomplete.vim'
"Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'airblade/vim-gitgutter'
Plug 'gorodinskiy/vim-coloresque'
Plug 'tikhomirov/vim-glsl'
Plug 'kovetskiy/vim-bash'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/Tagbar'
Plug 'easymotion/vim-easymotion'
Plug 'dag/vim-fish'
Plug 'dhruvasagar/vim-table-mode'
Plug 'shaneharper/vim-rtags'

call plug#end()

map <C-x> :NERDTreeToggle<CR>
map <f5> :make -C ../ f<CR>
filetype plugin indent on
set tabstop=4
set noexpandtab
set shiftwidth=4

syntax on
set mouse=a
set rnu

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

"set cc=80

" Man in vim
runtime ftplugin/man.vim

"" {{.h filetype to c
if has("autocmd")
    " Enable file type detection
    filetype on
    autocmd BufNewFile,BufRead *.h,*.c setfiletype c
endif
"" }}

"" {{ ALE
autocmd BufNewFile,BufRead *.h :set filetype=c
let g:ale_linters = {'c': 'gcc'}
let g:ale_c_gcc_options = '-Wall -Wextra -Werror -I../includes -I./includes -I include'
let g:ale_c_clang_options = '-Wall -Wextra -Werror -I../includes -I./includes'
let g:ale_cpp_clang_options = '-Wall -Wextra -Werror -I../includes -I./includes -std=c++11 -I ~/large/new_android/frameworks/native/include -I ~/large/new_android/frameworks/base/libs/androidfw/include -I ~/large/new_android/frameworks/base/libs/services/include -I ~/large/new_android/frameworks/native/opengl/include'
let g:ale_cpp_clangcheck_options = '-Wall -Wextra -Werror -I../includes -I./includes -std=c++11 -I ~/large/new_android/frameworks/native/include -I ~/large/new_android/frameworks/base/libs/androidfw/include -I ~/large/new_android/frameworks/base/libs/services/include -I ~/large/new_android/frameworks/native/opengl/include'
""}} ALE

"" show invisibles
set listchars=eol:¬,tab:>_,trail:~,extends:>,precedes:<,space:␣
"set list
hi SpecialKey ctermfg=black
hi NonText ctermfg=black
hi EndOfBuffer ctermfg=black
hi SpecialKey guifg=black
hi NonText guifg=black
hi EndOfBuffer guifg=black

set backspace=2

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

set hlsearch

nnoremap J gt
nnoremap K gT
set clipboard=unnamedplus

"" {{ HEADER_GUARD
function! g:HeaderguardName()
  return toupper(expand('%:t:gs/[^0-9a-zA-Z_]/_/g'))
endfunction

function! g:HeaderguardLine1()
  return "#ifndef " . g:HeaderguardName()
endfunction

function! g:HeaderguardLine2()
  return "# define " . g:HeaderguardName()
endfunction

function! g:HeaderguardLine3()
  return "#endif"
endfunction

"" }}

"" {{ SNIPPETS
set runtimepath+=~/.vim/my-snippets/
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"
"" }}

"" Markdown
let g:vim_markdown_folding_disabled = 1

"" TagBar
nmap <F8> :TagbarToggle<CR>
nmap <F7> :!ctags --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -R .

let mapleader = " "

nnoremap <leader>gn :GitGutterNextHunk<CR>
nnoremap <leader>gN :GitGutterPrevHunk<CR>
nnoremap <leader>gu :GitGutterUndoHunk<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bj :bn<CR>
nnoremap <leader>bp :bn<CR>
nnoremap <leader>bk :bn<CR>
nnoremap <leader>bl :buffers<CR>
nnoremap <leader>tn :tabnew 
nnoremap <Leader>1 1gt
nnoremap <Leader>2 2gt
nnoremap <Leader>3 3gt
nnoremap <Leader>4 4gt
nnoremap <Leader>5 5gt
nnoremap <Leader>6 6gt
nnoremap <Leader>7 7gt
nnoremap <Leader>8 8gt
nnoremap <Leader>9 9gt
nnoremap <Leader>0 10gt

" search selected fragment
vnoremap <Leader>n "ny/<C-r>n<CR>gv

nnoremap <Leader>co :copen<CR>
nnoremap <Leader>cc :cclose<CR>

vnoremap <Leader>gr "ny:grep -nr "<C-r>n" .

nnoremap <Leader>sl :set list<CR>
nnoremap <Leader>sL :set list!<CR>

nnoremap <Leader>sp :set paste<CR>
nnoremap <Leader>sP :set paste!<CR>

set incsearch

command -nargs=* Glg Git! lg <args>

inoremap jj <Esc>
