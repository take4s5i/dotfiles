set encoding=utf-8
scriptencoding=utf-8

let s:is_win = has('win32') || has('win64')

" ==================== vim options ====================
" encodings
set fileencodings=utf-8,cp932,euc-jp
if s:is_win
    set termencoding='cp932'
endif
set fileformat=unix
set fileformats=unix,dos
set ambiwidth=double

" use clipboard on yank
set clipboard=unnamed

" show control chars
set list
set listchars=tab:»\ ,trail:.,eol:˅,nbsp:.,extends:»,precedes:«

" show line number
set number

" backspace
set backspace=start,eol,indent

" show status line
set statusline=%m\ %n\ %F\ %r%<%=[%l/%L\ ,\ %c]\ [%{&fileencoding}]\ [%{&fileformat}]\ %y
set laststatus=2

" tabs
set expandtab
set tabstop=4
set shiftwidth=2
set softtabstop=2

" no folding
if has('folding')
    set nofoldenable
endif

" hidden warning on not saved
set hidden

" no wrap lines
set nowrap

" search options
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

" show tabline
set showtabline=2
set guioptions-=e

" swap , backup
set noswapfile
set nobackup
if has('persistent_undo')
    set noundofile
endif

" indent
set smartindent
set autoindent

" set terminal color
"set t_Co=256

" git grep for :grep
set grepprg=git\ grep\ --no-index\ -I\ --line-number

" ==================== key maps ====================
let mapleader=','

nnoremap <C-b> :Unite buffer<CR>
nnoremap ` @q
nnoremap & @:
" move current window
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
" move window
nnoremap sH <C-w>H
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
" split window
nnoremap ss :split<CR>
nnoremap sv :vsplit<CR>
nnoremap sx :q<CR>
" rorate window
nnoremap sr <C-w>r
nnoremap sR <C-w>R
" toggole split direction to [h]rizontal , [v]ertical.
nnoremap sth <C-w>t<C-w>H
nnoremap stv <C-w>t<C-w>K
" change window size. = : even. | : maximize horizontal. _ : maximize vertical.
nnoremap s= <C-w>=
nnoremap s<Bar> <C-w><Bar>
nnoremap s_ <C-w>_
" resize window
nnoremap s< <C-w><
nnoremap s> <C-w>>
nnoremap s+ <C-w>+
nnoremap s- <C-w>-
" tab
nnoremap stt :tabe %<CR>
nnoremap <Right> gt
nnoremap <Left> gT
nnoremap s0 :tabfirst<CR>
nnoremap s$ :tablast<CR>
nnoremap <Down> :+tabmove<CR>
nnoremap <Up> :-tabmov<CR>
" edit
nnoremap ses :split ./<CR>
nnoremap sev :vertical split ./<CR>
nnoremap set :tabedit ./<CR>
nnoremap sos :split %:h/<CR>
nnoremap sov :vertical split %:h/<CR>
nnoremap sot :tabedit %:h/<CR>
" yank to file
map <C-y> :w! ~/.vimyanks<CR>
map <C-p> :r ~/.vimyanks<CR>
" other
nnoremap gf :tabe <cfile><CR>
nnoremap sp :set paste!<CR>

" repeatable paste
vnoremap p "0p

" complete
imap <C-f> <C-x><C-o>


" ==================== auto cmds ====================
" lcd to the directory of the buffer when a buffer entered.
"au BufEnter * execute ":lcd " . expand("%:p:h")

" ==================== plugins ====================
if isdirectory(expand('~/.vim/bundle/neobundle.vim'))
    " neobundle
    filetype off
    filetype plugin indent off

    if has('vim_starting')
        set nocompatible
        set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif
    call neobundle#begin(expand('~/.vim/bundle/'))

    let g:neobundle#install_process_timeout=600

    if has('lua')
        NeoBundle 'https://github.com/Shougo/neocomplete.vim.git'
    endif

    NeoBundle 'Shougo/neobundle.vim'
    NeoBundle 'sheerun/vim-polyglot'
    NeoBundle 'https://github.com/h1mesuke/vim-alignta.git'
    NeoBundle 'https://github.com/tpope/vim-surround.git'
    NeoBundle 'https://github.com/thinca/vim-quickrun.git'
    NeoBundle 'https://github.com/nanotech/jellybeans.vim.git'
    NeoBundle 'https://github.com/mattn/emmet-vim'
    NeoBundle 'https://github.com/itchyny/lightline.vim.git'
    NeoBundle 'https://github.com/vim-jp/vimdoc-ja.git'
    NeoBundle 'https://github.com/lambdalisue/vim-unified-diff.git'
    NeoBundle 'https://github.com/moznion/vim-ltsv.git'
    NeoBundle 'othree/yajs.vim'
    NeoBundle 'othree/es.next.syntax.vim'

    call neobundle#end()
    NeoBundleCheck

    filetype plugin on
    filetype on
    syntax enable

    " ===== vim-poyglot =====
    let g:polyglot_disabled = ['javascript']

    " ===== neocomplete =====
    let g:neocomplete#enable_at_startup = 1

    " ===== emmet-vim ==== "
    let g:user_emmet_leader_key = '<C-e>'

    colorscheme jellybeans

    " ===== lightline.vim =====
    let g:lightline = {
        \ 'colorscheme' : 'jellybeans',
        \ 'component' : {
        \     'cd' : '%.35(%{fnamemodify(getcwd(), ":~")}%)'
        \ },
        \ 'tabline' : {
        \     'right' : [['cd']]
        \}
        \}
    function! LightlineUpdate()
        call lightline#init()
        call lightline#colorscheme()
        call lightline#update()
    endfunction

    " ===== vim-unified-diff =====
    set diffexpr=unified_diff#diffexpr()

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
    \       'type' : executable('mysql') ? 'sql/mysql' :
    \                executable('sqlplus') ? 'sql/oracle' : ''
    \   },
    \   'sql/oracle' : {
    \       'command' : 'sqlplus',
    \       'cmdopt' : '%{OraConnectionGet()}',
    \       'exec' : ['%c -S %o < %s']
    \   },
    \   'sql/mysql' : {
    \       'command' : 'mysql',
    \       'cmdopt' : '%{MysqlConnectionGet()}',
    \       'exec' : [ '%c %o < %s' ]
    \   },
    \  'javascript': {
    \    'type': executable('node') ? 'javascript/nodejs':
    \            executable('phantomjs') ? 'javascript/phantomjs':
    \            executable('js') ? 'javascript/spidermonkey':
    \            executable('d8') ? 'javascript/v8':
    \            executable('jrunscript') ? 'javascript/rhino':
    \            executable('cscript') ? 'javascript/cscript': '',
    \  }
    \}
endif

" ===== end plugins =====

" load local settings
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
  autocmd BufReadPre .vimprojects set ft=vim
augroup END

augroup ext-ft-map
  autocmd!
  autocmd BufNewFile,BufRead *.vue set ft=html
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimprojects', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction
