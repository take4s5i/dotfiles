lang en_US.UTF-8
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
set splitright
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

if has('nvim')
  set clipboard=unnamedplus
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
" general
vnoremap <silent> p "_s<C-R>+<esc>

" file & buffer
nnoremap ` @q
nnoremap <silent><leader>e :e %:h/<CR>
nnoremap <silent><leader>d :bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap <silent><leader>n :split<bar>enew<CR>
nnoremap <silent><leader>q :q<CR>
nnoremap <silent><leader>t :vsplit +term<CR>
nnoremap <silent><leader>s :split %:h/<CR>
nnoremap <silent><leader>v :vsplit %:h/<CR>
nnoremap <silent><leader>l :lopen<CR>
nnoremap <silent><leader>c :copen<CR>
noremap <silent><Right> :bn<CR>
noremap <silent><Left> :bp<CR>

" win resize
nnoremap <Home> <cmd>vertical res +1<CR>
nnoremap <End> <cmd>vertical res -1<CR>
nnoremap <PageUp> <cmd>res +1<CR>
nnoremap <PageDown> <cmd>res -1<CR>

" coc remap 
inoremap <silent><expr> <C-q> coc#refresh()
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Coc maps
nmap <silent> gdf <Plug>(coc-definition)
nmap <silent> gtd <Plug>(coc-type-definition)
nmap <silent> gim <Plug>(coc-implementation)
nmap <silent> grf <Plug>(coc-references)
nmap <silent> grn <Plug>(coc-rename)
nmap <silent> gfa  <cmd>call CocAction('fixAll')<CR>
nmap <silent> gfm  <cmd>call CocAction('format')<CR>
nmap <silent> goi  <cmd>call CocAction('organizeImport')<CR>
nmap <silent> gcm  <cmd>CocCommand<CR>

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

" Remap <Up> and <Down> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <Down> coc#float#has_scroll() ? coc#float#scroll(1) : "\<Down>"
  nnoremap <silent><nowait><expr> <Up> coc#float#has_scroll() ? coc#float#scroll(0) : "\<Up>"
  inoremap <silent><nowait><expr> <Down> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <Up> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <Down> coc#float#has_scroll() ? coc#float#scroll(1) : "\<Down>"
  vnoremap <silent><nowait><expr> <Up> coc#float#has_scroll() ? coc#float#scroll(0) : "\<Up>"
endif


function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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
