local M = {}

function M.InvokeCodeAction(kind)
  vim.lsp.buf.code_action({
    apply = true,
    filter = function(item)
      return item.kind == kind
    end,
  })
end

function M.ListCodeActions()
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

-- Open terminal in a floating window
function M.MiniTerm()
  local dir = vim.fn.expand('%:p:h')
  local buf = vim.api.nvim_create_buf(true, false)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'cursor',
    row = 1,
    col = 0,
    width = 100,
    height = 50,
    border = 'single',
  })
  vim.fn.termopen(vim.env.SHELL, {
    cwd = dir,
  })
end

return M
