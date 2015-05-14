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

" show status line
set statusline=%m\ %n\ %F\ %r%<%=[%l/%L\ ,\ %c]\ [%{&fileencoding}]\ [%{&fileformat}]\ %y
set laststatus=2

" tabs
set expandtab
set tabstop=8
set shiftwidth=4
set softtabstop=4

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

" show tabline
set showtabline=2
set guioptions-=e

" swap , backup
set noswapfile
set nobackup
if has('persistent_undo')
    set noundofile
endif

" set terminal color
"set t_Co=256

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
nnoremap s] gt
nnoremap s[ gT
nnoremap s} :execute 'tabmove ' . ((tabpagenr() + tabpagenr('$')) % tabpagenr('$'))<CR>
nnoremap s{ :execute 'tabmove ' . ((tabpagenr() - 2 + tabpagenr('$')) % tabpagenr('$'))<CR>
" edit
nnoremap ses :split ./<CR>
nnoremap sev :vertical split ./<CR>
nnoremap set :tabedit ./<CR>
nnoremap sEs :split %:h<CR>
nnoremap sEv :vertical split %:h<CR>
nnoremap sEt :tabedit %:h<CR>


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

    if v:version > 702
        NeoBundle 'https://github.com/Shougo/vimshell.vim.git'
        NeoBundle 'https://github.com/Shougo/unite.vim.git'
    endif

    if has('lua')
        NeoBundle 'https://github.com/Shougo/neocomplete.vim.git'
    endif

    NeoBundle 'Shougo/neobundle.vim'
    "NeoBundle 'Shougo/vimproc'
    NeoBundle 'https://github.com/altercation/vim-colors-solarized.git'
    NeoBundle 'https://github.com/h1mesuke/vim-alignta.git'
    NeoBundle 'https://github.com/tpope/vim-surround.git'
    NeoBundle 'https://github.com/PProvost/vim-ps1.git'
    NeoBundle 'https://github.com/thinca/vim-quickrun.git'
    NeoBundle 'https://github.com/rcmdnk/vim-markdown.git'
    NeoBundle 'https://github.com/nanotech/jellybeans.vim.git'
    NeoBundle 'https://github.com/mattn/emmet-vim'
    NeoBundle 'https://github.com/itchyny/lightline.vim.git'
    NeoBundle 'https://github.com/vim-jp/vimdoc-ja.git'

    call neobundle#end()
    NeoBundleCheck

    filetype plugin on
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

    " ===== solarized =====
    syntax enable
    let g:solarized_termcolors = 16
    let g:solarized_termtrans  = 1
    let g:solarized_bold       = 0
    let g:solarized_underline       = 0
    let g:solarized_italic       = 0
    set background=dark
    colorscheme solarized

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
        let l:showgitinfo = 0
        if l:showgitinfo && executable('git')
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

    " ===== agit =====
    let g:agit_diff_option = '-w --find-renames=100%'

    endif
" ===== end plugins =====

" ===== indent =====
command! -nargs=1 Indent call SetIndent(<q-args>)

function! ExecSetCmd(setl,setg,cmd)
    if a:setl
    execute 'setlocal ' . a:cmd
    endif
    if a:setg
    execute 'set ' . a:cmd
    endif
endfunction

function! SetIndent(str)
    let cnt = 0
    let setl = 1
    let setg = 0

    for s in split(a:str,'\zs')
        if s =~# '\d\|\-'
            if cnt % 3 == 0
            call ExecSetCmd(setl,setg,'tabstop=' . s)
            elseif cnt % 3 == 1
            call ExecSetCmd(setl,setg,'softtabstop=' . s)
            else
            call ExecSetCmd(setl,setg,'shiftwidth=' . s)
            endif
            let cnt = cnt + 1
        elseif s =~# 'e'
            call ExecSetCmd(setl,setg,'expandtab')
        elseif s =~# 'n'
            call ExecSetCmd(setl,setg,'noexpandtab')
        elseif s =~# 'l'
            let cnt = 0
            let setl = 1
        elseif s =~# 'L'
            let cnt = 0
            let setl = 0
        elseif s =~# 'g'
            let cnt = 0
            let setg = 1
        elseif s =~# 'G'
            let cnt = 0
            let setg = 0
        elseif s =~# 'r'
            retab
        elseif s =~# 'R'
            retab!
        endif
    endfor
endfunction

