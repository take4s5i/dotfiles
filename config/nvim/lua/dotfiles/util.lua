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

return M
