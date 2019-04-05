" VIM FUNCTIONS

" Auto toggle paste mode, the insert mode mapping is somehow part of the
" automation trick, it is not meant to be actually manually typed
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" deletes triling whitespaces
function! s:StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let saved_search_history=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/= saved_search_history
    call cursor(l, c)
endfunction
nnoremap <silent> <leader>dts :call <SID>StripTrailingWhitespaces()<CR>

function! HandleURL()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;()]*')
  let s:uri = shellescape(s:uri, 1)
  echom s:uri
  if s:uri != ""
    silent exec "!open -a 'Google Chrome' '".s:uri."'"
    :redraw!
  else
    echo "No URI found in line."
  endif
endfunction
