"フォントの設定
set guifont=Consolas:h10 guifontwide=Ricty\ Diminished:h10

if has('mac')
  set guifont=Consolas:h15 guifontwide=Ricty\ Diminished:h15
"
"メニュー、ツールバーの設定(UTF8化するとメニューが化けるので一旦削除して再表示)
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim
set guioptions-=T

" resetting colorscheme on system gvimrc
colorscheme jellybeans

" ressetting lightline
let g:lightline.colorscheme = 'jellybeans'
call LightlineUpdate()

" resize window size
set lines=500
set columns=500
