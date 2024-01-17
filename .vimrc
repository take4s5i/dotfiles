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
set re=0

" files
set wildmenu
set wildignore=node_modules,node_modules/*
set wildignorecase

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

if executable('fish')
  set shell=fish\ -C\ \"cd\ \$PWD\"
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

" coc remap
inoremap <silent><expr> <c-@> coc#refresh()

filetype plugin on
filetype on
syntax enable
colorscheme jellybeans

let g:lightline = {
  \ 'colorscheme': 'jellybeans',
  \ 'component': {
  \     'cd' : '%.35(%{fnamemodify(getcwd(), ":~")}%)'
  \ },
  \ 'tabline': {
  \     'right' : [['cd']]
  \ }
  \ }

set diffexpr=unified_diff#diffexpr()
let g:user_emmet_leader_key = '<C-e>'
let g:polyglot_disabled = ["jsx"]

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

augroup ext-ft-map
  autocmd!
  autocmd BufNewFile,BufRead *.vue set ft=html
  autocmd BufNewFile,BufRead *.vtc set ft=vcl
  autocmd BufNewFile,BufRead *.astro set ft=astro
augroup END

let g:coc_global_extensions = [
      \ 'coc-eslint',
      \ 'coc-go',
      \ 'coc-prettier',
      \ 'coc-rust-analyzer',
      \ 'coc-tsserver',
      \ 'coc-diagnostic',
      \ 'coc-yaml',
      \ 'coc-cfn-lint',
      \ 'coc-graphql',
      \ 'coc-phpls',
      \ 'coc-deno',
      \ 'coc-lua',
      \ 'coc-vimlsp'
      \ ]

let g:astro_typescript = 'enable'
let g:gh_use_canonical = 0
