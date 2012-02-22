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

function! Pipas_Open_Header ()
   if g:header_open != "false"
       :exe "normal \<C-w>\<Up>:q\<CR>\<CR>"
       echo "normal \<C-w\>\<Up\>:q\<CR\>"
       let g:header_open = "false"
   else
       let curr_file = expand("%")
       let curr_name = expand("%:r")
       exe "split ".curr_name.".h"
       let g:header_open = "true"
   endif
endfunction

map <C-F12> :!ctags -R -I --exclude=*stub* --exclude=*test* --languages=c++ --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
" map <C-F11> :!indent -nbbo -nut -linux -l85 -ci4 -br -brs -brf *.c *.h<CR>
map <F12> :TlistToggle<CR>
map <F4> :call Pipas_Open_Header()<Esc>

set tags+=~/.vim/tags/lmt_0.22.11.tags
set tags+=~/.vim/tags/qt_4.7.4_git20110517.tags
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_NamespaceSearch = 1
set autoindent
set et sw=4 ts=4 sts=4
" set et ai sw=4 ts=4 sts=4 tw=80 cino="(0,W2s,i2s,t0,l1,:0"

