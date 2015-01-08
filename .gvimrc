"フォントの設定
set guifont=Consolas:h10 guifontwide=Ricty\ Diminished:h10
"
"メニュー、ツールバーの設定(UTF8化するとメニューが化けるので一旦削除して再表示)
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim
set guioptions-=T

" resetting colorscheme on system gvimrc
colorscheme jellybeans
