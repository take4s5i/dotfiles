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

function Term:set(args)
  self.dirmode = args.dirmode or self.dirmode
end

function Term:get_win()
  local win = self.win
  if win == nil then
    return nil
  end

  if not vim.api.nvim_win_is_valid(win) then
    self.win = nil
    return nil
  end

  return win
end

function Term:open()
  local win = self:get_win()
  if win ~= nil then
    return
  end

  local cwd = self:get_dir()
  local newbuf = not self:available()
  if newbuf then
    self.buf = vim.api.nvim_create_buf(true, false)
  end

  local mergin = { x = 20, y = 3 }
  self.win = vim.api.nvim_open_win(self.buf, true, {
    relative = 'editor',
    row = math.floor(vim.o.lines / 3 * 2),
    col = mergin.x,
    width = vim.o.columns - mergin.x * 2,
    height = math.ceil(vim.o.lines / 3) - mergin.y,
    border = 'single',
  })

  if newbuf then
    vim.fn.termopen(vim.env.SHELL, {
      cwd = cwd,
    })
  end
end

function Term:close()
  if self.win == nil then
    return
  end
  local win = self.win
  self.win = nil

  if vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
  end
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
M.current_term = nil
function M.get_term(name, args)
  if M.terms[name] == nil then
    M.terms[name] = Term:new(args or {})
  else
    M.terms[name]:set(args or {})
  end
  return M.terms[name]
end

function M.open(name, args)
  if M.current_term ~= nil then
    M.close(M.current_term)
  end

  M.current_term = name
  M.get_term(name, args):open()
end

function M.close(name)
  M.get_term(name):close()
  M.current_term = nil
end

function M.forcus_opened_win()
  if M.current_term == nil then
    return
  end

  local win = M.get_term(M.current_term):get_win()
  if win == nil then
    return
  end
  vim.api.nvim_tabpage_set_win(0, win)
end

function M.closeAll()
  for k, v in pairs(M.terms) do
    M.close(k)
  end
end

return M
