-- lspconfig
-- see: https://github.com/neovim/nvim-lspconfig
-- nvim built-inのLSPの設定を簡単に行うためのライブラリ
-- 様々なlanguage server用の設定が事前に用意されている
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
  settings = {
    yaml = {
      schemas = {
        kubernetes = { "k8s/**/*.yaml",
          "*.k8s.yaml" },

      }
    }
  },

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

lspconfig.taplo.setup {
  capabilities = capabilities,

}

lspconfig.golangci_lint_ls.setup {
  capabilities = capabilities,
  init_options = {
    command = {
      "golangci-lint",
      "run",
      "--output.json.path=stdout",
      "--show-stats=false" },

  },
}

lspconfig.typos_lsp.setup {
  capabilities = capabilities,

}

lspconfig.pylsp.setup {
  capabilities = capabilities,

}

-- mason
-- masonはLSPに対応したlanguage serverを管理するためのプラグイン
require('mason').setup()
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls",
    "gopls",
    "yamlls",
    "terraformls",
    "tflint",
    "ts_ls",
    "eslint",
    "intelephense",
    "taplo",
    "golangci_lint_ls",
    "typos_lsp",
    "pylsp",
  },
}

-- Format on Save
-- FIXME: formatに対応していないlanguage serverの場合失敗する
vim.api.nvim_create_autocmd("LspAttach",
  {
    group = vim.api.nvim_create_augroup("lsp",
      { clear = true }),

    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      -- formatに対応していたら保存時にformatする
      if client.supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd("BufWritePre",
          {
            buffer = args.buf,

            callback = function()
              vim.lsp.buf.format { async = false,
                id = args.data.client_id }
            end,

          })
      end
    end
  })
