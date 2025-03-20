-- Encoding settings
vim.cmd.lang('ja_JP.UTF-8')
vim.o.encoding = 'utf-8'
vim.scriptencoding = 'utf-8'

local is_win = vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1

-- Encodings
vim.o.fileencodings = 'utf-8,cp932,euc-jp'
if is_win then
  vim.o.termencoding = 'cp932'
end
vim.o.fileformat = 'unix'
vim.o.fileformats = 'unix,dos'
vim.o.ambiwidth = 'double'
vim.o.re = 0

-- File-related settings
vim.o.wildmenu = true
vim.o.wildignore = 'node_modules,node_modules/*'
vim.o.wildignorecase = true
vim.o.wildmode = 'list:longest,full'

-- Display settings
vim.o.list = true
vim.o.listchars = 'tab:» ,trail:.,eol:˅,nbsp:.,extends:»,precedes:«'
vim.o.number = true
vim.o.backspace = 'start,eol,indent'
vim.o.statusline = '%m %n %F %r%<%=[%l/%L , %c] [%{&fileencoding}] [%{&fileformat}] %y'
vim.o.laststatus = 2
vim.o.showtabline = 2
-- vim.o.guioptions = vim.o.guioptions:gsub('e', '')
vim.o.signcolumn = 'yes'

-- Tab settings
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.smartindent = true
vim.o.autoindent = true

-- Misc settings
vim.o.equalalways = false
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.completeopt = vim.o.completeopt .. ',noinsert'
vim.o.hidden = true
vim.o.wrap = false
vim.o.clipboard = 'unnamed'
vim.o.swapfile = false
vim.o.backup = false
vim.o.grepprg = 'rg --vimgrep'
if vim.fn.has('persistent_undo') == 1 then
  vim.o.undofile = false
end
if vim.fn.has('nvim') == 1 then
  vim.o.clipboard = 'unnamedplus'
end
if vim.fn.executable('fish') == 1 then
  vim.o.shell = 'fish -C "cd $PWD"'
end

-- Search options
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.wrapscan = true
vim.o.hlsearch = true

-- Folding settings
if vim.fn.has('folding') == 1 then
  vim.o.foldmethod = 'indent'
  vim.o.foldlevel = 7
end

vim.g.polyglot_disabled = { 'jsx' }
vim.cmd.filetype('plugin on')
vim.cmd.filetype('on')
vim.cmd.syntax('enable')
vim.cmd.colorscheme('jellybeans')

vim.g.lightline = {
  colorscheme = 'jellybeans',
  component = {
    cd = '%.35(%{fnamemodify(getcwd(), ":~")}%)',
  },
  tabline = {
    right = {
      { 'cd' },
    },
  },
}

vim.cmd.augroup('ext-ft-map')
vim.cmd.autocmd('BufNewFile,BufRead *.vue set ft=html')
vim.cmd.autocmd('BufNewFile,BufRead *.vtc set ft=vcl')
vim.cmd.autocmd('BufNewFile,BufRead *.astro set ft=astro')
vim.cmd.autocmd('BufNewFile,BufRead .envrc set ft=sh')
vim.cmd.augroup('END')

vim.api.nvim_create_user_command('Setqflist', (function()
  vim.diagnostic.setqflist {}
  vim.cmd.copen()
end), {})

vim.api.nvim_create_user_command('Setloclist', (function()
  vim.diagnostic.setloclist {}
  vim.cmd.lopen()
end), {})

-- update qflist and loclist on diagnostics change
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  callback = function(args)
    vim.diagnostic.setloclist {
      open = false,
    }
  end,
})

vim.g.astro_typescript = 'enable'
vim.g.gh_use_canonical = 0

-- load local config
vim.opt.rtp:append(vim.fn.getcwd() .. '/.nvim')

-- additional config
require('dotfiles/keymap')
require('dotfiles/lsp')
require('dotfiles/cmp')

-- CopilotChat
require('CopilotChat').setup {

}
vim.api.nvim_create_user_command("NvimConfig", "e ~/.config/nvim/init.lua", {})
