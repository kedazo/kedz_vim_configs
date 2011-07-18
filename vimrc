set nocp
set number
set hlsearch

syntax on
filetype plugin on
filetype on

map <C-F12> :!ctags -R -I --exclude=*stub* --languages=c++ --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
" map <C-F11> :!indent -nbbo -nut -linux -l85 -ci4 -br -brs -brf *.c *.h<CR>
map <F12> :TlistToggle<CR>

set tags+=~/.vim/tags/lmt_0.22.11.tags
set tags+=~/.vim/tags/qt_4.7.4_git20110517.tags
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_NamespaceSearch = 1
set autoindent
set et sw=4 ts=4 sts=4
" set et ai sw=4 ts=4 sts=4 tw=80 cino="(0,W2s,i2s,t0,l1,:0"

