local Term = {}
function Term:new(args)
  local obj = {}
  obj.dirmode = args.dirmode or 'buffer'
  obj.shell = vim.env.SHELL
  obj.buf = nil
  obj.win = nil
  self.__index = self
  return setmetatable(obj, self)
end

function Term:get_dir()
  if self.dirmode == 'buffer' then
    return vim.fn.expand('%:p:h')
  else
    return vim.fn.getcwd()
  end
end

function Term:open()
  local newbuf = not self:available()
  if newbuf then
    self.buf = vim.api.nvim_create_buf(true, false)
  end

  local mergin = { x = 20, y = 5 }
  self.win = vim.api.nvim_open_win(self.buf, true, {
    relative = 'editor',
    row = mergin.y,
    col = mergin.x,
    width = vim.o.columns - mergin.x * 2,
    height = vim.o.lines - mergin.y * 2,
    border = 'single',
  })

  if newbuf then
    vim.fn.termopen(vim.env.SHELL, {
      cwd = self:get_dir(),
    })
  end
end

function Term:close()
  if self.win ~= nil then
    vim.api.nvim_win_close(self.win, true)
  end
  self.win = nil
end

function Term:new_buf()
  vim.fn.termopen(vim.env.SHELL, {
    cwd = self:get_dir(),
  })
end

function Term:available()
  if self.buf == nil then
    return false
  end
  return vim.fn.bufname(self.buf) ~= ''
end

local M = {}
M.terms = {}
function M.get_term(name)
  if M.terms[name] == nil then
    M.terms[name] = Term:new {}
  end
  return M.terms[name]
end

function M.open(name)
  M.get_term(name):open()
end

function M.close(name)
  M.get_term(name):close()
end

return M
