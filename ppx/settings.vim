" VIM SETTINGS

" Check sourced files {{{1

let ppx_settings = 1                    "this file is been sourced
let skip_defaults_vim = 1               "do not source defaults.vim

"}}}


" Options {{{1

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start
" keep 200 lines of command line history
set history=200
set ttimeout                            " time out for key codes
" wait up to 100ms after Esc for special key
set ttimeoutlen=100
" Show @@@ in the last line if it is truncated.
set display=truncate
" Show a few lines of context around the cursor
set scrolloff=3
" Do not recognize octal numbers for Ctrl-A and Ctrl-X
set nrformats-=octal
set ul=1000     " maximum number of changes that can be undone
" Indentation and tabs settings
set tabstop=4                           " number of columns for <Tab>
set softtabstop=4                       " <Tab> columns for editing operations
set shiftwidth=4                        " number of spaces for indentation
set expandtab                           " replace <Tab> with spaces
augroup tsv
    autocmd!
    :au FileType tsv set noexpandtab
augroup END
" Copy indent from current line when starting a new line
set autoindent
set ttyfast                             " indicates fast terminal connection
" capital K will open vim help for the word under the cursor
set keywordprg=:help

if has('vertsplit')
    set splitright
endif


if v:version > 703 || (v:version == 703 && has('patch541'))
    " remove comment leader when joining lines
    set formatoptions+=j
endif


if has('diff')
    set diffopt=filler,vertical         " options settings for diff-mode
endif


if has('cmdline_info')
    set ruler                           " show the cursor position all the time
    set showcmd                         " display incomplete commands
endif


if has('wildmenu')
" display completion matches in a status line
    set wildmenu
" When more than one match, list all matches and complete first match.
    set wildmode=list,full
endif


" When there is a previous search pattern, highlight all its matches.
if has('extra_search')
    set hlsearch
" Do incremental searching when it's possible to timeout.
    if has('reltime')
" Display the match for a search pattern when halfway
" typing it.
      set incsearch
    endif
endif

" }}}


" Visualization options {{{1

set laststatus=2                        " Always show status line
set number                              " show line number
set relativenumber                      " show relative line number
set list                                " shoe invisible characters
set listchars=tab:▸\ ,eol:¬,extends:»,precedes:«,trail:•,nbsp:‡
" Highlight columns 80 and 120
let &colorcolumn="80,".join(range(120,120),",")

" Switch syntax highlighting on when the terminal has colors
if &t_Co > 2
    syntax on
    set background=dark
    colorscheme badwolf
endif



if has('syntax')
    set cursorline                      " higlight cursor line
endif

" Airline plugin settings

let g:airline_theme= 'wombat'
let g:airline_powerline_fonts = 1

" }}}


" managing various vim meta-data files (viminfo, backup, swp, undo) {{{1
"
if exists($ppxtmp) && isdirectory($ppxtmp)

    " echo an error message if the info file is not readable
    if !empty(glob(expand($ppxtmp . '/viminfo')))
        if !filereadable(expand($ppxtmp . '/viminfo'))
            echoerr expand('warning: ' . $ppxtmp . '/viminfo not readable')
        endif
    endif

    set viminfo+=n$ppxtmp/viminfo " set custom directory for info files

    if exists('$sudo_user')
        set nobackup                    " avoid root-owned files
        set nowritebackup               " avoid root-owned files
        set noswapfile                  " avoid root-owned files
    else
        set backupdir = $ppxtmp/backup  " custom dir for backup files
        set directory = $ppxtmp/swp     " custom dir for swap files
    endif

    if has('persistent_undo')
        " automatically save undo history to an undo file
        set udf
        set udir = $ppxtmp/undo/        " custom dir for undo files
    endif
endif

let g:ycm_filetype_blacklist = { 'golang': 1 }
let g:ycm_autoclose_preview_window_after_completion=1

"}}}
