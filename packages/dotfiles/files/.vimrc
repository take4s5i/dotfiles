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
set showtabline=0
set guioptions-=e
set signcolumn=yes

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

let mapleader=' '

nnoremap ` @q
nnoremap <silent><leader>e :e %:h/<CR>
nnoremap <silent><leader>n :bn<CR>
nnoremap <silent><leader>p :bp<CR>
nnoremap <silent><leader>b :b #<CR>
nnoremap <silent><leader>d :bd<CR>

filetype plugin on
filetype on
syntax enable

augroup ext-ft-map
  autocmd!
  autocmd BufNewFile,BufRead *.vue set ft=html
  autocmd BufNewFile,BufRead *.vtc set ft=vcl
augroup END

