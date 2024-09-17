local util = require('dotfiles/util')
local term = require('dotfiles/term')

vim.g.mapleader = ' '

-- General key mappings
vim.keymap.set('v', 'p', '"_s<C-R>+<esc>', { noremap = true, silent = true })

-- File & buffer key mappings
vim.keymap.set('n', '`', '@q', { noremap = true })
vim.keymap.set('n', '<leader>e', ':e %:h/<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>d', ':bp|bd#<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>n', ':tabnew ./<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>N', ':tabnew %:p<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>t', ':term<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>s', ':split %:h/<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>v', ':vsplit %:h/<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>l', ':lopen<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>c', ':copen<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>b', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>f', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>r', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Right>', ':cnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Left>', ':cprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Tab>', '<C-^>', { noremap = true })
vim.keymap.set('n', '<C-j>', ':bn<CR>', { noremap = true })
vim.keymap.set('n', '<C-k>', ':bp<CR>', { noremap = true })
vim.keymap.set('n', '<C-l>', ':tabnext<CR>', { noremap = true })
vim.keymap.set('n', '<C-h>', ':tabprev<CR>', { noremap = true })

-- floating terminal
local modes = { 'n', 't' }
for _, mode in ipairs(modes) do
  for i = 1, 4, 1 do
    vim.keymap.set(mode, '<C-y>' .. i, function() term.open('buffer_' .. i, { dirmode = 'buffer' }) end,
      { noremap = true })
  end
  for i = 5, 9, 1 do
    vim.keymap.set(mode, '<C-y>' .. i, function() term.open('editor_' .. i, { dirmode = 'editor' }) end,
      { noremap = true })
  end
  vim.keymap.set(mode, '<C-y>0', function() term.closeAll() end, { noremap = true })
  vim.keymap.set(mode, '<C-y><C-y>', function() term.forcus_opened_win() end, { noremap = true })
end

-- Terminal key mappings
vim.keymap.set('t', '<C-l>', '<cmd>tabnext<CR>', { noremap = true })
vim.keymap.set('t', '<C-h>', '<cmd>tabprev<CR>', { noremap = true })
vim.cmd.autocmd('TermOpen * startinsert')
vim.cmd.autocmd('WinEnter term:/* startinsert')
vim.keymap.set('t', '<C-t>', '<cmd>vsplit +term<cr>', { noremap = true })
vim.keymap.set('t', '<C-W>N', '<C-\\><C-n>', { noremap = true })
vim.keymap.set('t', '<C-W><C-N>', '<cmd>new<cr>', { noremap = true })
vim.keymap.set('t', '<C-W>q', '<cmd>quit<cr>', { noremap = true })
vim.keymap.set('t', '<C-W><C-Q>', '<cmd>quit<cr>', { noremap = true })
vim.keymap.set('t', '<C-W>c', '<cmd>close<cr>', { noremap = true })
vim.keymap.set('t', '<C-W>o', '<cmd>only<cr>', { noremap = true })
vim.keymap.set('t', '<C-W><C-O>', '<cmd>only<cr>', { noremap = true })
vim.keymap.set('t', '<C-W>j', '<cmd>wincmd j<cr>', { noremap = true })
vim.keymap.set('t', '<C-W>k', '<cmd>wincmd k<cr>', { noremap = true })
vim.keymap.set('t', '<C-W>h', '<cmd>wincmd h<cr>', { noremap = true })
vim.keymap.set('t', '<C-W>l', '<cmd>wincmd l<cr>', { noremap = true })
vim.keymap.set('t', '<C-W>w', '<cmd>wincmd w<cr>', { noremap = true })
vim.keymap.set('t', '<C-W>W', '<cmd>wincmd W<cr>', { noremap = true })
vim.keymap.set('t', '<C-W>p', '<cmd>wincmd p<cr>', { noremap = true })
vim.keymap.set('t', '<C-W>R', '<cmd>wincmd R<cr>', { noremap = true })
vim.keymap.set('t', '<C-W>x', '<cmd>wincmd x<cr>', { noremap = true })
vim.keymap.set('t', '<C-W>K', '<cmd>wincmd K<cr>', { noremap = true })
vim.keymap.set('t', '<C-W>J', '<cmd>wincmd J<cr>', { noremap = true })
vim.keymap.set('t', '<C-W>H', '<cmd>wincmd H<cr>', { noremap = true })
vim.keymap.set('t', '<C-W>L', '<cmd>wincmd L<cr>', { noremap = true })
vim.keymap.set('t', '<C-W>T', '<cmd>wincmd T<cr>', { noremap = true })
vim.keymap.set('t', '<C-W>=', '<cmd>wincmd =<cr>', { noremap = true })
vim.keymap.set('t', '<C-W>s', '<cmd>split %:h/<CR>', { noremap = true })
vim.keymap.set('t', '<C-W>v', '<cmd>split %:h/<CR>', { noremap = true })
vim.keymap.set('t', '<C-9>', '<cmd>wincmd -<CR>', { noremap = true })
vim.keymap.set('t', '<C-0>', '<cmd>wincmd +<CR>', { noremap = true })
vim.keymap.set('t', '<C-j>', '<cmd>bn<CR>', { noremap = true })
vim.keymap.set('t', '<C-k>', '<cmd>bp<CR>', { noremap = true })
vim.keymap.set('t', '<C-l>', '<cmd>tabnext<CR>', { noremap = true })
vim.keymap.set('t', '<C-h>', '<cmd>tabprev<CR>', { noremap = true })

-- Fold key mappings
vim.keymap.set('n', '+', 'zr', { noremap = true })
vim.keymap.set('n', '-', 'zm', { noremap = true })
vim.keymap.set('n', '(', 'zX', { noremap = true })
vim.keymap.set('n', ')', 'zO', { noremap = true })

-- Window resize key mappings
vim.keymap.set('n', '<Home>', '<cmd>vertical resize +1<CR>', { noremap = true })
vim.keymap.set('n', '<End>', '<cmd>vertical resize -1<CR>', { noremap = true })
vim.keymap.set('n', '<PageUp>', '<cmd>resize +1<CR>', { noremap = true })
vim.keymap.set('n', '<PageDown>', '<cmd>resize -1<CR>', { noremap = true })

-- LSP key mappings
vim.keymap.set('n', 'gdf', function() vim.lsp.buf.definition({ loclist = true }) end, { silent = true })
vim.keymap.set('n', 'gtd', function() vim.lsp.buf.hover() end, { silent = true })
vim.keymap.set('n', 'gim', function() vim.lsp.buf.implementation() end, { silent = true })
vim.keymap.set('n', 'grf', function() vim.lsp.buf.references({ loclist = true }) end, { silent = true })
vim.keymap.set('n', 'grn', function() vim.lsp.buf.rename() end, { silent = true })
vim.keymap.set('n', 'gfa', function() util.InvokeCodeAction('source.fixAll') end, { silent = true })
vim.keymap.set('n', 'gfm', function() vim.lsp.buf.format { async = false } end, { silent = true })
vim.keymap.set('n', 'goi', function() util.InvokeCodeAction('source.organizeImports') end, { silent = true })
vim.keymap.set('n', 'gcm', function() vim.lsp.buf.code_action { context = { only = 'refactor' } } end, { silent = true })
--  vim.keymap.set('n', 'gbf', '<cmd>CocList buffers<CR>', { silent = true })
