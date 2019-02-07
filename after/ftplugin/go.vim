" Important, gocode must be installed and built from
" https://github.com/mdempsky/gocode

setlocal completeopt+=menuone,noselect,noinsert
setlocal omnifunc=gocomplete#Complete

" Auto open completion on dot
function! OpenCompletion()
    if !pumvisible() && (v:char == '.')
        call feedkeys("\<C-x>\<C-o>", "n")
    endif
endfunction

autocmd InsertCharPre * call OpenCompletion()

