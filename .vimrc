let s:is_win = has('win32') || has('win64')

" ==================== vim options ====================
" encodings
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp,ucs-2
if s:is_win
    set termencoding='cp932'
endif

" use clipboard on yank
set clipboard=unnamed

" show control chars
set list
set listchars=tab:»\ ,trail:·,eol:˅,extends:»,precedes:«,nbsp:·

" show line number
set number

" show status line
set statusline=%m\ %n\ %F\ %r%<%=[%l/%L\ ,\ %c]\ [%{&fileencoding}]\ [%{&fileformat}]\ %y

" tabs
set expandtab
set tabstop=8
set shiftwidth=4
set softtabstop=4

" no folding
set nofoldenable

" hidden warning on not saved
set hidden

" no wrap lines
set nowrap

" search options
set ignorecase
set smartcase
set incsearch
set wrapscan

" show tabline
set showtabline=2
set guioptions-=e

" swap , backup
set swapfile
set nobackup

" syntax
syntax enable


" ==================== key maps ====================
let mapleader=','

nnoremap <C-b> :Unite buffer<CR>
nnoremap <C-q> :@q
nnoremap <C-Left> gT
nnoremap <C-Right> gt


" ==================== key maps ====================
au BufEnter * execute ":lcd " . expand("%:p:h")

" ==================== plugins ====================
" neobundle
filetype off
filetype plugin indent off

if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))

let g:neobundle#install_process_timeout=600

NeoBundle 'Shougo/neobundle.vim'
"NeoBundle 'Shougo/vimproc'
"NeoBundle 'git://github.com/altercation/vim-colors-solarized.git'
NeoBundle 'https://github.com/h1mesuke/vim-alignta.git'
NeoBundle 'https://github.com/tpope/vim-surround.git'
NeoBundle 'https://github.com/PProvost/vim-ps1.git'
NeoBundle 'https://github.com/Shougo/unite.vim.git'
NeoBundle 'https://github.com/thinca/vim-quickrun.git'
"NeoBundle 'https://github.com/Shougo/neocomplcache.vim.git'
NeoBundle 'https://github.com/Shougo/neocomplete.vim.git'
NeoBundle 'https://github.com/Shougo/unite-outline.git'
"NeoBundle 'https://github.com/hallison/vim-markdown.git'
"NeoBundle 'https://github.com/plasticboy/vim-markdown.git'
NeoBundle 'https://github.com/rcmdnk/vim-markdown.git'
"NeoBundle 'https://github.com/thinca/vim-ref.git'
NeoBundle 'https://github.com/nanotech/jellybeans.vim.git'
"NeoBundle 'https://github.com/yuku-t/vim-ref-ri.git'
NeoBundle 'https://github.com/terryma/vim-multiple-cursors.git'
NeoBundle 'https://github.com/tpope/vim-fugitive'
NeoBundle 'https://github.com/mattn/emmet-vim'
NeoBundle 'https://github.com/itchyny/lightline.vim.git'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'https://github.com/Shougo/vimshell.vim.git'
NeoBundle 'https://github.com/take4s5i/previm.git'
NeoBundle 'https://github.com/freitass/todo.txt-vim'

call neobundle#end()
NeoBundleCheck

filetype plugin indent on
filetype on

" ===== unite =====
let g:unite_split_rule="topleft"
let g:unite_enable_split_vertically=0
let g:unite_winwidth= 50
let g:unite_winheight=200

" ===== vim-indent-guides =====
let g:indent_guides_auto_colors=1
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1

" ===== neocomplete =====
let g:neocomplete#enable_at_startup = 1

" ===== jellybeans =====
colorscheme jellybeans

" ===== lightline.vim =====
let g:lightline = {
    \ 'colorscheme' : 'jellybeans'
    \}

" ===== quickrun =====
let g:quickrun_config = {
\   '_' : {
\       'hook/output_encode/enable' : 1,
\       'hook/output_encode/encoding' : '&termencoding'
\   },
\   'ruby':{
\       'hook/output_encode/enable' : 0
\   },
\   'sql' : {
\       'type' : executable('sqlplus') ? 'sql/oracle' : ''
\   },
\   'sql/oracle' : {
\       'command' : 'sqlplus',
\       'cmdopt' : '%{OraConnectionGet()}',
\       'exec' : ['%c -S %o < %s']
\   }
\}

function! OraConnectionSet()
   let g:my_ora_connection = input('oracle connection > ')
endfunction
function! OraConnectionGet()
    if !exists('g:my_ora_connection')
        call OraConnectionSet()
    endif
    return g:my_ora_connection
endfunction

" ===== vimshell =====
let g:vimshell_split_command="tabnew"

let $PATH=substitute($PATH,'\','/','g')

let g:vimshell_prompt='$ '
let g:vimshell_user_prompt = 'MyVimShellUserPrpmpt()'

function! MyVimShellUserPrpmpt()
    let l:uname = s:is_win ? $USERNAME : $USER
    let l:gitinfo = ''
    if executable('git')
        let l:branch =  system('git rev-parse --abbrev-ref HEAD')
        let l:branch = v:shell_error == 0 ? l:branch : ''
        if l:branch != ''
            let l:gitinfo = " [" . substitute(l:branch,'\n','','g') . "]"
        endif
    endif
    return "\n" . l:uname . "@" . hostname() . " " . getcwd() . l:gitinfo
endfunction

if has('gui_running')
    let g:vimshell_editor_command=
                \ substitute(substitute($VIM,'\','/','g'),' ','\\ ','g') .'/' . v:progname
endif

" ===== previm =====
let g:previm_open_cmd = 'start'

