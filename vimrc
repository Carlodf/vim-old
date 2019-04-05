"Vundle {{{1
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
" calls vundle and set the root installation path for plugins
call vundle#begin('~/.vim/bundles')

"Plugins {{{2
Plugin 'VundleVim/Vundle.vim' "plugin manager
Plugin 'tpope/vim-fugitive' "wrapper for git
Plugin 'Valloric/YouCompleteMe'
Plugin 'ctrlpvim/ctrlp.vim' " fuzzy file finder
Plugin 'tpope/vim-surround' " surround things
Plugin 'tpope/vim-vinegar' "files browsing
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'nvie/vim-flake8'
Plugin 'fatih/vim-go'
Plugin 'bogado/file-line'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


set encoding=utf-8

" Configuration files {{{1
let $MYVIMRC = $HOME . '/.vim/vimrc'
let $PPXSET = $HOME . '/.vim/ppx/settings.vim'
let $PPXFUN = $HOME . '/.vim/ppx/functions.vim'
let $PPXMAP = $HOME . '/.vim/ppx/mappings.vim'
let $PPXTMP = $HOME . '/.vim/tmp'

" SETTINGS
source $PPXSET
" FUNTIONS
source $PPXFUN
" MAPPINGS
source $PPXMAP

" }}}

" JAVA STUFF {{{1
augroup java
    autocmd!
    :au FileType java setlocal omnifunc=javacomplete#Complete
    :au FileType java nnoremap <buffer> <leader>gd :JavaSearch <CR>
augroup END

" }}}

" AUTOCOMANDS {{{1

augroup vimfile
    autocmd!
    :au FileType vim set foldmethod=marker
augroup END

" YCM bindings for cpp
augroup cpp
    autocmd!
    :au FileType cpp nnoremap <buffer> <leader>gd :YcmCompleter GoToDefinition<CR>
    :au FileType cpp nnoremap <buffer> <leader>gh :YcmCompleter GoToInclude<CR>
    :au FileType cpp nnoremap <buffer> <leader>gt :YcmCompleter GetType<CR>
    :au FileType cpp nnoremap <buffer> <leader>gf :YcmCompleter FixIt<CR>
    :au FileType cpp nnoremap <buffer> <leader>rc :!brazil-build desktop -j8 -q release<CR>
    :au FileType cpp nnoremap <buffer> <leader>rt :!brazil-build desktop -j8
                \ -q release tests<CR>
    :au FileType cpp inoremap <buffer> {<cr> {<cr>}<esc>O
augroup END

augroup python
    autocmd!
    :au FileType python nnoremap <buffer> <leader>gd :YcmCompleter GoToDefinition<CR>
    :au FileType python nnoremap <buffer> <leader>gb :YcmCompleter GoToDeclaration<CR>
    :au FileType python nnoremap <buffer> <leader>gi :YcmCompleter GetDoc<CR>
    :au FileType python nnoremap <buffer> <leader>gf :YcmCompleter GoToReferences<CR>
    :au FileType python nnoremap <buffer> <leader>rc :!brazil-build<CR>
augroup END

augroup golang
    autocmd!
    :au FileType go nnoremap <buffer> <leader>gd :GoDef<CR>
    :au FileType go nnoremap <buffer> <leader>gv :GoVet<CR>
    :au FileType go nnoremap <buffer> <leader>rr :GoRun<CR>
    :au FileType go nnoremap <buffer> <leader>rb :GoBuild<CR>
    :au FileType go nnoremap <buffer> <leader>ri :GoInstall<CR>
    :au FileType go nnoremap <buffer> <leader>rt :GoTest<CR>
    :au FileType go nnoremap <buffer> <leader>bb :!brazil-build<CR>
    :au FileType go set foldmethod=syntax
augroup END

augroup proto
    autocmd!
    :au FileType proto nnoremap <buffer> <leader>rc :!brazil-build desktop -j8 -q release<CR>
    :au FileType proto nnoremap <buffer> <leader>rt :!brazil-build desktop -j8
                \ -q release tests<CR>
    :au FileType proto inoremap <buffer> {<cr> {<cr>}<esc>O
augroup END

augroup thrax
    autocmd!
    :au BufRead,BufNewFile *.grm set filetype=thraxgrm
augroup END

augroup fer
    autocmd!
    :au BufRead,BufNewFile *.fe set filetype=frame_expansion
augroup END

let vim_markdown_preview_hotkey='<leader>p'

augroup markdown
    autocmd!
    :au FileType markdown set textwidth=80
    :au FileType markdown set wrap linebreak nolist
    :au FileType markdown set conceallevel=2
augroup END

augroup filetypes
    autocmd!
    :au BufNewFile,BufRead *.tsv set filetype=tsv
augroup END
" FUNCTIONS {{{1

" Opens url in w3m
function! OpenInBrowser(url)
    if !empty(a:url)
        echo 'opening: ' . a:url
        execute '!w3m ' . a:url
        echo 'done!'
    endif
endfunction

" Open prowser with url under cursor
nnoremap <leader>gw "zyiW:call OpenInBrowser(@z)<CR>


" Toggle Windows to max height
function! ToggleFullscreenWindows()
    if &winheight == 1
        let &winheight=9999
        let &winminheight=0
        set noequalalways
    else
        let &winheight=1
        let &winminheight=0
        set equalalways
    endif
endfunction

" Toggle Windows to max height
nnoremap <leader>tf :call ToggleFullscreenWindows()<CR>

" define a grep operator to be used with movements
function! s:GrepOperator(type)
    let saved_unamed_register = @@
    if a:type ==# 'v'
        execute "normal! `<v`>y"
    elseif a:type ==# 'char'
        execute "normal! `[v`]y"
    else
        return
    endif

    silent execute "grep! -R " . shellescape(@@) . " ."
    copen
    let @@ = saved_unamed_register
    :redraw!
endfunction

let g:S = 0  "result in global variable S
function! Sum(number)
  let g:S = g:S + a:number
    return a:number
endfunction
" grep operators to be used with motions
nnoremap <leader>s :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>s :<c-u>call <SID>GrepOperator(visualmode())<cr>

