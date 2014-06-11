"フォントの設定
set guifont=Consolas:h10 guifontwide=MS_Gothic:h10

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
set statusline=%m\ %n\ %F\ %r%<%=[%l/%L\ ,\ %c]\ [%{&fileencoding}]\ %y

"タブの設定　スペースインデントのインデント幅4
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

"NeoComplCacheを起動
let g:neocomplcache_enable_at_startup = 1

" neobundleの設定
set nocompatible
filetype off
 
if has('vim_starting')
    set runtimepath+=~/vimfiles/bundle/neobundle.vim/
    call neobundle#rc(expand('~/vimfiles/bundle/'))
endif
 
"NeoBundleInstallでのタイムアウト時間を設定
let g:neobundle#install_process_timeout=600

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'git://github.com/altercation/vim-colors-solarized.git'
NeoBundle 'git://github.com/h1mesuke/vim-alignta.git'
NeoBundle 'git://github.com/tpope/vim-surround.git'
NeoBundle 'https://github.com/PProvost/vim-ps1.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'https://github.com/thinca/vim-quickrun.git'
NeoBundle 'https://github.com/Shougo/neocomplcache.vim.git'
NeoBundle 'https://github.com/Shougo/unite-outline.git'
NeoBundle 'https://github.com/hallison/vim-markdown.git'
NeoBundle 'https://github.com/thinca/vim-ref.git'

filetype plugin on
filetype indent on

"カラースキームsolarizedの設定
let g:solarized_bold=0
let g:solarized_italic=0
colorscheme solarized

"バックアップファイルとswpファイルの場所を変更
set swapfile
set nobackup

"Uniteの設定
let g:unite_split_rule="topleft"
let g:unite_enable_split_vertically=0
let g:unite_winwidth= 50
let g:unite_winheight=200

"なぜかaligntaが読み込まれないので手動で読込
runtime! plugin/**/*.vim

"開いているファイルをカレントディレクトリにする
au BufEnter * execute ":lcd " . expand("%:p:h")


"キーバインド
nnoremap <C-b> :Unite buffer file file/new<CR>

"バッファ切り替え時に保存を促す警告を出さない
set hidden

"ウィンドウに収まらない行を折り返さない
set nowrap
