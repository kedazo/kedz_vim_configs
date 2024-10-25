set nocp
set number
set hlsearch

syntax on
filetype plugin on
filetype on

function! Pipas_Widescreen ()
   exe ":set textwidth=120"
   exe ":set columns=120"
endfunction

function! Pipas_Normalscreen ()
   exe ":set textwidth=80"
   exe ":set columns=80"
endfunction

let g:header_open = "false"
let g:load_doxygen_syntax = 1

function! Pipas_Open_Header ()
   if g:header_open != "false"
       :exe "normal \<C-w>\<Up>:q\<CR>\<CR>"
       let g:header_open = "false"
   else
       let curr_file = expand("%")
       let curr_name = expand("%:r")
       exe "split ".curr_name.".h"
       let g:header_open = "true"
   endif
endfunction

" to forcibly enable 256 term colors
" set t_Co=256

" airline plugin
set laststatus=2

set ttimeoutlen=50
" this looks cool for 256 colors:
" let g:airline_theme = 'powerlineish'
" but this one ok for 8 colors:
let g:airline_theme = 'tomorrow'
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1

" install first: https://github.com/powerline/fonts
" and change gnome-terminal font to
" 'Ubuntu Mono derivative Powerline Regular 12'
let g:airline_powerline_fonts=1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
  endif
  let g:airline_symbols.space = "\ua0"

map <C-F12> :!ctags -R -I --exclude=*doc* --exclude=*debian* --exclude=*stub* --exclude=*ut_* --exclude=*ft_* --languages=c++ --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <C-F11> :!ctags -R -I --exclude=*doc* --exclude=*debian* --exclude=*stub* --exclude=*ut_* --exclude=*ft_* --languages=go --go-kinds=+p --fields=+iaS --extra=+q .<CR>
map <S-F12> :!ctags -R -I --exclude=*doc* --exclude=*debian* --exclude=*stub* --exclude=*ut_* --exclude=*ft_* --languages=c++ --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <S-F11> :!ctags -R -I --exclude=*doc* --exclude=*debian* --exclude=*stub* --exclude=*ut_* --exclude=*ft_* --languages=go --go-kinds=+p --fields=+iaS --extra=+q .<CR>

" map <C-F11> :!indent -nbbo -nut -linux -l85 -ci4 -br -brs -brf *.c *.h<CR>
map <F12> :TlistToggle<CR>
map <F4> :call Pipas_Open_Header()<Esc>
map <F5> dwj

" go language
let s:tlist_def_go_settings = 'go;g:enum;s:struct;u:union;t:type;' .
                           \ 'v:variable;f:function'

set tags+=~/.vim/tags/cpp_stl.tags
set tags+=~/.vim/tags/opt_go_src.tags
" set tags+=~/.vim/tags/qt-4.8.1-ubuntu.tags
" set tags+=~/.vim/tags/qtmobility-1.2.0-ubuntu.tags
" set tags+=~/.vim/tags/cocos2dx-21rc0.tags
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_NamespaceSearch = 1
let OmniCpp_DisplayMode = 1
let OmniCpp_ShowScopeInAbbr = 1
set autoindent
" Mine
set et sw=4 ts=4 sts=4
set et ai sw=4 ts=4 sts=4 tw=80 cino="(0,W2s,i2s,t0,l1,:0"

" two-space indentation
autocmd BufNewFile,BufRead /home/kedz/Work/v*/* set et sw=2 ts=2 sts=2

