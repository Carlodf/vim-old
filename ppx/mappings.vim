" VIM MAPPINGS

let mapleader="\\"
let maplocalleader=","

" fast operations on configuration files
nnoremap <leader>ev :sp $MYVIMRC <cr>
nnoremap <leader>es :sp $PPXSET <cr>
nnoremap <leader>ef :sp $PPXFUN <cr>
nnoremap <leader>em :sp $PPXMAP <cr>
nnoremap <leader>sv :source $MYVIMRC <cr>

" Mapping to train
inoremap jk <esc>
nnoremap OA <nop>
nnoremap OB <nop>
nnoremap OC <nop>
nnoremap OD <nop>

" clear search highlight
nnoremap <silent> <leader>/ :nohlsearch <cr>

" easier mappings for moving within splits
nnoremap <c-h> <c-w><c-h>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
" switch split vertical
nnoremap <leader>ssv <c-w>t<c-w>H
" switch split orizontal
nnoremap <leader>sso <c-w>t<c-w>K

" Toggle spell check
nnoremap <leader>sp :setlocal spell! spelllang=en_us<CR>

" Open Mappings
nnoremap <leader>em :e $PPXMAP<CR>
nnoremap <leader>es :e $PPXSET<CR>
nnoremap <leader>ef :e $PPXFUN<CR>

" Open browser with url under cursor
nnoremap <leader>w :call HandleURL()<CR>

" Javacomplete2

" To enable smart (trying to guess import option) inserting class imports with F4, add:
nnoremap <F4> <Plug>(JavaComplete-Imports-AddSmart)
inoremap <F4> <Plug>(JavaComplete-Imports-AddSmart)

"To enable usual (will ask for import option) inserting class imports with F5, add:
nnoremap <F5> <Plug>(JavaComplete-Imports-Add)
inoremap <F5> <Plug>(JavaComplete-Imports-Add)

"To add all missing imports with F6:
nnoremap <F6> <Plug>(JavaComplete-Imports-AddMissing)
inoremap <F6> <Plug>(JavaComplete-Imports-AddMissing)

" To remove all unused imports with F7:
nnoremap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
inoremap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
