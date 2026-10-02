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

" don't query the terminal's cursor style/blink: gnome-terminal's late replies
" (^[P1$r0 q^[\ and ^[[?12;4$y) leaked onto the screen while startup was busy
" with coc/airline (vim 9.1.0016).  Only cost: vim can't restore the cursor shape.
set t_RS= t_RC=

" airline plugin
set laststatus=2

set ttimeoutlen=50
" this looks cool for 256 colors:
" let g:airline_theme = 'powerlineish'
" but this one ok for 8 colors:
let g:airline_theme = 'tomorrow'
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=0

" install first: https://github.com/powerline/fonts
" and change gnome-terminal font to
" 'Ubuntu Mono derivative Powerline Regular 12'
let g:airline_powerline_fonts=1
" don't render empty sections (leftover separators around inactive chunks)
let g:airline_skip_empty_sections=1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
  endif
  let g:airline_symbols.space = "\ua0"
  " pre-v0.12 line-number glyph (branch icon, no colon; v0.12 uses " :")
  let g:airline_symbols.linenr = ""

" airline v0.12 changed the right side to ':%l/%L' + maxlinenr'≡' + colnr'℅'
" restore the old look: percent + line:col packed tight, no padding
function! Pipas_Airline_Old_Statusline()
  let g:airline_section_z = airline#section#create(['windowswap', '%3p%%' . g:airline_symbols.space, '%{g:airline_symbols.linenr}%l:%v'])
  " keep the current-function chunk, drop the redundant filetype (cpp)
  let g:airline_section_x = airline#section#create_right(['coc_current_function', 'bookmark', 'scrollbar', 'tagbar', 'taglist', 'vista', 'gutentags', 'gen_tags', 'omnisharp', 'grepper', 'codeium'])
endfunction
autocmd User AirlineAfterInit call Pipas_Airline_Old_Statusline()

map <C-F12> :!ctags -R -I --exclude=*doc* --exclude=*debian* --exclude=*stub* --exclude=*ut_* --exclude=*ft_* --languages=c++ --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <C-F11> :!ctags -R -I --exclude=*doc* --exclude=*debian* --exclude=*stub* --exclude=*ut_* --exclude=*ft_* --languages=go --go-kinds=+p --fields=+iaS --extra=+q .<CR>
map <S-F12> :!ctags -R -I --exclude=*doc* --exclude=*debian* --exclude=*stub* --exclude=*ut_* --exclude=*ft_* --languages=c++ --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <S-F11> :!ctags -R -I --exclude=*doc* --exclude=*debian* --exclude=*stub* --exclude=*ut_* --exclude=*ft_* --languages=go --go-kinds=+p --fields=+iaS --extra=+q .<CR>

" map <C-F11> :!indent -nbbo -nut -linux -l85 -ci4 -br -brs -brf *.c *.h<CR>
" clangd compile DB (compile_commands.json):
"  C-F10 incremental (appends changed TUs), S-F10 full regeneration.
"  NB: bear on a no-op make writes an EMPTY compile_commands.json - use -B for full.
map <C-F10> :!bear --append -- make -j$(nproc)<CR>
map <S-F10> :!bear -- make -B -j$(nproc)<CR>
map <F12> :TlistToggle<CR>
map <F4> :call Pipas_Open_Header()<Esc>
map <F5> dwj

" go language
let s:tlist_def_go_settings = 'go;g:enum;s:struct;u:union;t:type;' .
                           \ 'v:variable;f:function'

set tags+=~/.vim/tags/cpp_stl.tags
set tags+=~/.vim/tags/qt-6.11.0.tags
" set tags+=~/.vim/tags/qt-4.8.1-ubuntu.tags
" set tags+=~/.vim/tags/qtmobility-1.2.0-ubuntu.tags
" set tags+=~/.vim/tags/cocos2dx-21rc0.tags
set autoindent
" Mine
set et sw=4 ts=4 sts=4
set et ai sw=4 ts=4 sts=4 tw=80 cino="(0,W2s,i2s,t0,l1,:0"

" two-space indentation
autocmd BufNewFile,BufRead /home/kedz/Work/v*/* set et sw=2 ts=2 sts=2

" --- coc.nvim --- LSP: clangd (C/C++) + gopls (Go), VSCode-style completion.
" vim-go's own gopls mappings/doc off: coc owns gd/K/etc. in Go buffers.
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0

" coc config lives HERE, not in ~/.config/coc/settings.json (see :h coc#config)
call coc#config('inlayHint.enableParameter', v:false)

set updatetime=300
set shortmess+=c
set signcolumn=yes

" popup colors: the terminal is dark, but &background defaults to light, so
" coc computed a near-white float bg with pale text.  coc defines its groups
" with `hi default`, so setting them here (before the plugin loads) wins.
" (`set background=dark` deliberately NOT used - it would re-tint the editor's
" own syntax colors; these groups fix only the popups.)
hi CocFloating   ctermbg=236 guibg=#303040
hi CocMenuSel    ctermbg=60  guibg=#414863
hi CocPumDetail  ctermfg=110 guifg=#88b4f2
hi CocFloatSbar  ctermbg=236 guibg=#303040
hi CocFloatThumb ctermbg=240 guibg=#585858

" completion popup: opens by itself only on . -> :: (coc-settings.json
" "suggest.autoTrigger": "trigger"), otherwise on demand:
"  C-Space (the terminal sends it as NUL = <C-@>) or the old omni C-x C-o.
" Tab/S-Tab navigate, CR accepts.
inoremap <silent><expr> <TAB>    coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <silent><expr> <S-TAB>  coc#pum#visible() ? coc#pum#prev(1) : "\<S-TAB>"
inoremap <silent><expr> <CR>     coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <C-Space> coc#refresh()
inoremap <silent><expr> <C-@>     coc#refresh()
inoremap <silent><expr> <C-x><C-o> coc#refresh()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> K  <Plug>(coc-doHover)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ac <Plug>(coc-codeaction-cursor)
nmap <leader>qf <Plug>(coc-fix-current)

