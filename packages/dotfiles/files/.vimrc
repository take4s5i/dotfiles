set encoding=utf-8
scriptencoding=utf-8

let s:is_win = has('win32') || has('win64')

" encodings
set fileencodings=utf-8,cp932,euc-jp
if s:is_win
    set termencoding='cp932'
endif
set fileformat=unix
set fileformats=unix,dos
set ambiwidth=double


" display
set list
set listchars=tab:»\ ,trail:.,eol:˅,nbsp:.,extends:»,precedes:«
set number
set backspace=start,eol,indent
set statusline=%m\ %n\ %F\ %r%<%=[%l/%L\ ,\ %c]\ [%{&fileencoding}]\ [%{&fileformat}]\ %y
set laststatus=2
set showtabline=2
set guioptions-=e

" tab
set expandtab
set tabstop=4
set shiftwidth=2
set softtabstop=2
set smartindent
set autoindent

" misc
set completeopt+=noinsert
set hidden
set nowrap
set clipboard=unnamed
set noswapfile
set nobackup
set grepprg=git\ grep\ --no-index\ -I\ --line-number
if has('persistent_undo')
    set noundofile
endif

" search options
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

if has('folding')
    set nofoldenable
endif

let mapleader=','

nnoremap ` @q
nnoremap <Right> gt
nnoremap <Left> gT
nnoremap <Down> :+tabmove<CR>
nnoremap <Up> :-tabmov<CR>
nnoremap se :tabedit ./<CR>
nnoremap so :tabedit %:h/<CR>
nnoremap gf :tabe <cfile><CR>

" repeatable paste
vnoremap p "0p

filetype plugin on
filetype on
syntax enable

augroup ext-ft-map
  autocmd!
  autocmd BufNewFile,BufRead *.vue set ft=html
  autocmd BufNewFile,BufRead *.vtc set ft=vcl
augroup END
