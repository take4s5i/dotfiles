" windowsかどうかを示す変数
let s:is_win = has('win32') || has('win64')

"フォントの設定
set guifont=Consolas:h10 guifontwide=Ricty\ Diminished:h10

"文字コードの設定
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp,ucs-2

"メニュー、ツールバーの設定(UTF8化するとメニューが化けるので一旦削除して再表示)
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim
set guioptions-=T

"クリップボードを使えるようにする
set clipboard=unnamed

"コントロール文字の表示設定
set list
set listchars=tab:»\ ,trail:·,eol:˅,extends:»,precedes:«,nbsp:·
set number
set statusline=%m\ %n\ %F\ %r%<%=[%l/%L\ ,\ %c]\ [%{&fileencoding}]\ [%{&fileformat}]\ %y

"タブの設定　スペースインデントのインデント幅4
set expandtab
set tabstop=8
set shiftwidth=4
set softtabstop=4

" foldingを無効にする
set nofoldenable

"NeoComplCacheを起動
let g:neocomplcache_enable_at_startup = 1

" neobundleの設定
filetype off
filetype plugin indent off

if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))

"NeoBundleInstallでのタイムアウト時間を設定
let g:neobundle#install_process_timeout=600

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
"NeoBundle 'git://github.com/altercation/vim-colors-solarized.git'
NeoBundle 'git://github.com/h1mesuke/vim-alignta.git'
NeoBundle 'git://github.com/tpope/vim-surround.git'
NeoBundle 'https://github.com/PProvost/vim-ps1.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'https://github.com/thinca/vim-quickrun.git'
NeoBundle 'https://github.com/Shougo/neocomplcache.vim.git'
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

call neobundle#end()
NeoBundleCheck

filetype plugin indent on
filetype on

"カラースキームjellybeansの設定
syntax enable
colorscheme jellybeans

"バックアップファイルとswpファイルの場所を変更
set swapfile
set nobackup

"Uniteの設定
let g:unite_split_rule="topleft"
let g:unite_enable_split_vertically=0
let g:unite_winwidth= 50
let g:unite_winheight=200

" vim-indent-guides
let g:indent_guides_auto_colors=1
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1

"開いているファイルをカレントディレクトリにする
au BufEnter * execute ":lcd " . expand("%:p:h")

"キーバインド
nnoremap <C-b> :Unite buffer file file/new<CR>
nnoremap <C-q> :@q

"バッファ切り替え時に保存を促す警告を出さない
set hidden

"ウィンドウに収まらない行を折り返さない
set nowrap

" search options
set ignorecase
set smartcase
set incsearch
set wrapscan

"tablineを出す
set showtabline=2
set guioptions-=e

" lightline.vim
let g:lightline = {
    \ 'colorscheme' : 'jellybeans'
    \}

" quickrun configuration
let g:quickrun_config = {
\   '_' : {
\       'hook/output_encode/enable' : s:is_win ? 1 : 0,
\       'hook/output_encode/encoding' : s:is_win ? 'cp932:utf-8' : '&fileencoding'
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

" set and get function for oracle connection string
function! OraConnectionSet()
   let g:my_ora_connection = input('oracle connection > ')
endfunction
function! OraConnectionGet()
    if !exists('g:my_ora_connection')
        call OraConnectionSet
    endif
    return g:my_ora_connection
endfunction

runtime! plugin/**/*.vim

