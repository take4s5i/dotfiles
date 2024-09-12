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
  vim.o.foldlevel = 5
end

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
vim.keymap.set('t', '<C-W>s', ':split %:h/<CR>', { noremap = true })
vim.keymap.set('t', '<C-W>v', ':split %:h/<CR>', { noremap = true })
vim.keymap.set('t', '<C-9>', ':wincmd -<CR>', { noremap = true })
vim.keymap.set('t', '<C-0>', ':wincmd +<CR>', { noremap = true })

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

vim.g.polyglot_disabled = { 'jsx' }

vim.cmd.augroup('ext-ft-map')
vim.cmd.autocmd('BufNewFile,BufRead *.vue set ft=html')
vim.cmd.autocmd('BufNewFile,BufRead *.vtc set ft=vcl')
vim.cmd.autocmd('BufNewFile,BufRead *.astro set ft=astro')
vim.cmd.augroup('END')

vim.g.astro_typescript = 'enable'
vim.g.gh_use_canonical = 0

-- lsp

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
  capabilities = capabilities,
}

lspconfig.gopls.setup {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
  capabilities = capabilities,
}

lspconfig.yamlls.setup {
  capabilities = capabilities,
}

lspconfig.terraformls.setup {
  capabilities = capabilities,
}

lspconfig.tflint.setup {
  capabilities = capabilities,
}

lspconfig.ts_ls.setup {
  capabilities = capabilities,
}

lspconfig.eslint.setup {
  capabilities = capabilities,
}

lspconfig.intelephense.setup {
  capabilities = capabilities,
}

require('mason').setup()
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "gopls", "yamlls", "terraformls", "tflint", "ts_ls", "eslint", "intelephense" }
}

function InvokeCodeAction(kind)
  vim.lsp.buf.code_action({
    apply = true,
    filter = function(item)
      return item.kind == kind
    end,
  })
end

function ListCodeActions(kind)
  local bufnr = vim.api.nvim_get_current_buf()
  local params = vim.lsp.util.make_range_params()

  params.context = {
    triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
    diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr),
  }

  vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function(error, results, context, config)
    print(vim.inspect(results))
  end)
end

vim.keymap.set('n', 'gdf', function() vim.lsp.buf.definition({ loclist = true }) end, { silent = true })
vim.keymap.set('n', 'gtd', function() vim.lsp.buf.hover() end, { silent = true })
vim.keymap.set('n', 'gim', function() vim.lsp.buf.implementation() end, { silent = true })
vim.keymap.set('n', 'grf', function() vim.lsp.buf.references({ loclist = true }) end, { silent = true })
vim.keymap.set('n', 'grn', function() vim.lsp.buf.rename() end, { silent = true })
vim.keymap.set('n', 'gfa', function() InvokeCodeAction('source.fixAll') end, { silent = true })
vim.keymap.set('n', 'gfm', function() vim.lsp.buf.format { async = false } end, { silent = true })
vim.keymap.set('n', 'goi', function() InvokeCodeAction('source.organizeImports') end, { silent = true })
vim.keymap.set('n', 'gcm', function() vim.lsp.buf.code_action { context = { only = 'refactor' } } end, { silent = true })
--  vim.keymap.set('n', 'gbf', '<cmd>CocList buffers<CR>', { silent = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(args)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format { async = false, id = args.data.client_id }
      end,
    })
  end
})

local snippy = require('snippy')
local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      snippy.expand_snippet(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Up>'] = cmp.mapping.scroll_docs(-4),  -- Up
    ['<Down>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-q>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<C-y>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'snippy' },
    { name = 'buffer' },
  },
}
