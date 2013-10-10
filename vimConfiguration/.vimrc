"Some stuff from http://amix.dk/vim/vimrc.html , https://github.com/mony960/dotfiles/blob/master/.vimrc , vim wiki , etc
set fileencoding=utf-8
set encoding=utf8
set ffs=unix

"Pathogen Settings
filetype off
execute pathogen#infect()
syntax on " enable syntax highlighting
filetype plugin on
filetype indent on

set showmatch " Show matching brackets when text indicator is over them
set nocompatible " don't try to be strictly vi-like
set modelines=0 " don't use modelines (for security)
set viminfo='20,\"50 " use a viminfo file,...
set history=200 " limit history
set hlsearch " highlight search results
set ruler " show the cursor position
set showcmd " display incomplete commands
set title " show title
" set cmdheight=2 " Height of the command bar
set incsearch " find as entering pattern
set t_Co=256 " uses 256 colors
set ignorecase " case insensitive patterns,...
set smartcase " when only lowercase is used
set pastetoggle=<F2> " F2 toggles indenting when pasting
set wildmenu " use command-line completion menu,...
set wildmode=longest:full " with wildmode
set bs=indent,eol,start " allow backspacing over everything
set autoindent " enable auto-indentation
set tabstop=2 " no. of spaces for tab in file
set shiftwidth=2 " no. of spaces for step in autoindent
set softtabstop=2 " no. of spaces for tab when editing
set expandtab " expand tabs into spaces
set smarttab " smart tabulation and backspace
set mouse=a " enable mouse in all modes
set list lcs=trail:·,tab:»· ",eol:¶
set number " show line numbers
set nobackup " turn backup off
set noswapfile " turn swap off
set ai " Auto indent
set si " Smart indent
set wrap " Wrap lines

" Set the leader key
let mapleader = ","
let g:tex_flavor='latex'

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
"for Gnu prolog the one I use
map <leader>pl :! prolog --consult-file %<cr>
"for the other prolog
"map <leader>pl :! prolog -f %<cr>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   execute 'normal! g`"zvzz' |
        \ endif
augroup END

setlocal ofu=syntaxcomplete#Complete " enable syntax based omni completion
setlocal foldmethod=syntax " folding uses syntax for folding
setlocal nofoldenable " don't start with folded lines

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

"Spelling
let g:myLang = 0
let g:myLangList = ['pt','en','nospell']
function! MySpellLang()
"loop through languages - nospell always at last place
    if g:myLang == 0 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
    if g:myLang == 1 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
    if g:myLang == ( len(g:myLangList) - 1) | setlocal nospell | endif
    echomsg 'language:' g:myLangList[g:myLang]
    let g:myLang = g:myLang + 1
    if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
endfunction
"Press F8 to switch between languages
map <F8> :call MySpellLang()<CR>

"copy and paste
map <C-c> "+y<CR>
map <C-v> "+p<CR>

"if in insertion mode, go to normal mode execute a command and then return to insertion mode.
"Does save the cursor position when in insertion.
imap <C-S>  <C-\><C-O>:w<cr>

"Colors Settings
:colorscheme molokai

" easier moving of code blocks
vnoremap < <gv
vnoremap > >gv

"Quick editing
nnoremap <leader>rc :vsplit $MYVIMRC<cr>
nnoremap <leader>mk :vsplit Makefile<cr>
nnoremap <leader>r :!make <cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                 "
"            Start of plugin tweaks               "
"                                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""

"NERDTree
noremap <F3> :NERDTreeToggle<cr>
inoremap <F3> <esc>:NERDTreeToggle<cr>
let g:NERDTreeWinSize = 40
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDChristmasTree = 1
let NERDTreeChDirMode = 2
let NERDTreeMapJumpFirstChild = 'gK'
let NERDTreeHighlightCursorline = 1 "use cursorline
let NERDTreeMapActivateNode='<CR>' "use return/enter key
autocmd vimenter * if !argc() | NERDTree | endif "NERDTREE starts up automatically if no arguments were specified
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif "Close vim if the only window left open is a NERDTree

" Taglist key
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 40
noremap <F4> :TlistToggle<cr>
inoremap <F4> <esc>:TlistToggle<cr>

"UltiSnips keybindings
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<A-s-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"YCM keybindings
let g:ycm_key_list_select_completion = ['<DOWN>']
let g:ycm_key_list_previous_completion = ['<UP>']
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_key_detailed_diagnostics = '<leader>d'

" Syntastic
noremap <F2> :SyntasticCheck<CR>
inoremap <F2> <esc>:SyntasticCheck<CR>
let g:syntastic_c_checker='youcompleteme'
let g:syntastic_enable_signs = 1
let g:syntastic_check_on_open = 1
let g:syntastic_disabled_filetypes = ['html', 'rst']
let g:syntastic_stl_format = '[%E{%e Errors}%B{, }%W{%w Warnings}]'
let g:syntastic_jsl_conf = '$HOME/.vim/jsl.conf'
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol='✗'
let g:syntastic_style_warning_symbol='⚠'
let g:syntastic_check_on_wq=1
let g:syntastic_auto_loc_list=1
let g:syntastic_mode_map = { 'mode': 'active',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': ['html'] }
let g:syntastic_enable_highlighting = 1
"let g:syntastic_python_checker = 'pylint'

" Switch to working directory of the open file
autocmd BufEnter * lcd %:p:h
