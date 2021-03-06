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
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'airblade/vim-gitgutter'
Plug 'tikhomirov/vim-glsl'
Plug 'lumiliet/vim-twig'
Plug 'tpope/vim-fugitive'
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'
Plug 'joonty/vdebug'
Plug 'posva/vim-vue'
Plug 'dag/vim-fish'
Plug 'dhruvasagar/vim-table-mode'
Plug 'editorconfig/editorconfig-vim'
Plug 'JamshedVesuna/vim-markdown-preview'

call plug#end()

map <C-x> :NERDTreeToggle<CR>
" map <f5> :make<CR>
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

set cc=80

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
"let g:ale_linters = {'h': 'gcc', 'c': 'gcc'}
" let g:ale_asm_gcc_options = '-Wall -fPIC -m64'
let g:ale_c_gcc_options = '-Wall -Wextra -Werror -I../includes -I./includes -I include -I libft'
let g:ale_c_clangtidy_options = '-Wall -Wextra -Werror -I../includes -I./includes -I include -I libft'
let g:ale_c_clang_options = '-Wall -Wextra -Werror -I../includes -I./includes -I include -I libft'
let g:ale_c_clang_options = '-Wall -Wextra -Werror -I../includes -I./includes -I include -I libft'
let g:ale_cpp_clang_options = '-Wall -Wextra -Werror -I../includes -I./includes -std=c++11'
let g:ale_cpp_clangcheck_options = '-Wall -Wextra -Werror -I../includes -I./includes -std=c++11'
""}} ALE

"" show invisibles
set listchars=eol:¬,tab:>_,trail:~,extends:>,precedes:<,space:.
"set list!
hi SpecialKey ctermfg=green
hi NonText ctermfg=green
hi EndOfBuffer ctermfg=green
hi SpecialKey guifg=green
hi NonText guifg=green
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
set incsearch

" nnoremap ; :
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

autocmd FileType javascript setlocal cc=120


set novb t_vb=
