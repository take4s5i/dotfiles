source ~/.vimrc

" terminal mode
autocmd TermOpen * :startinsert
autocmd WinEnter term:/* :startinsert
tnoremap <C-t>        <cmd>vsplit +term<cr>
tnoremap <C-W>N       <C-\><C-n>
tnoremap <C-W><C-N>   <cmd>new<cr>
tnoremap <C-W>q       <cmd>quit<cr>
tnoremap <C-W><C-Q>   <cmd>quit<cr>
tnoremap <C-W>c       <cmd>close<cr>
tnoremap <C-W>o       <cmd>only<cr>
tnoremap <C-W><C-O>   <cmd>only<cr>
tnoremap <C-W>j       <cmd>wincmd j<cr>
tnoremap <C-W>k       <cmd>wincmd k<cr>
tnoremap <C-W>h       <cmd>wincmd h<cr>
tnoremap <C-W>l       <cmd>wincmd l<cr>
tnoremap <C-W>w       <cmd>wincmd w<cr>
tnoremap <C-W>W       <cmd>wincmd W<cr>
tnoremap <C-W>p       <cmd>wincmd p<cr>
tnoremap <C-W>R       <cmd>wincmd R<cr>
tnoremap <C-W>x       <cmd>wincmd x<cr>
tnoremap <C-W>K       <cmd>wincmd K<cr>
tnoremap <C-W>J       <cmd>wincmd J<cr>
tnoremap <C-W>H       <cmd>wincmd H<cr>
tnoremap <C-W>L       <cmd>wincmd L<cr>
tnoremap <C-W>T       <cmd>wincmd T<cr>
tnoremap <C-W>=       <cmd>wincmd =<cr>
tnoremap <C-W>s :split %:h/<CR>
tnoremap <C-W>v :split %:h/<CR>
tnoremap <C-9> :wincmd -<CR>
tnoremap <C-0> :wincmd +<CR>


