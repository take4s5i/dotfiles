local Project = {}
function Project:new(args)
  local obj = {}
  obj.projectconfig = args.projectconfig
  obj.path = args.path
  obj.loaded = false
  self.__index = self
  return setmetatable(obj, self)
end

function Project:load(silent)
  local allowed = self:is_allowed(silent)
  if allowed == false then
    if silent ~= true then
      print('Project is not allowed')
    end
    return
  end

  if self.loaded == true then
    return
  end

  local files = { '.nvim/init.lua', '.nvim/init.vim', '.vimrc' }
  local file = ''

  for _, f in pairs(files) do
    file = vim.fn.findfile(f, self.path)
    if file ~= '' then
      vim.cmd.source(file)
      self.loaded = true
      return
    end
  end
end

function Project:allow()
  if self.path == nil then
    print('Project not found.')
    return
  end

  self.projectconfig:allow_project(self.path)
  self:load()
end

function Project:is_allowed(silent)
  if self.path == nil then
    if silent ~= true then
      print('Project not found.')
    end
    return nil
  end

  return self.projectconfig:is_allowed_project(self.path)
end

function Project:revoke()
  if self.path == nil then
    print('Project not found.')
    return
  end

  self.projectconfig:revoke_project(self.path)
end

local ProjectConfig = {}
function ProjectConfig:new(args)
  local obj = {}
  obj.root_patterns = args.root_patterns or { '.git' }
  obj.allowed_projects = {}
  obj.allowed_project_file = vim.env.HOME .. '/.nvim_allowed_projects'
  self.__index = self
  return setmetatable(obj, self)
end

function ProjectConfig:find_project(cwd)
  cwd = cwd or vim.fn.getcwd()
  local root = ''
  local pat = ''
  for _, v in ipairs(self.root_patterns) do
    local dir = vim.fn.finddir(v, cwd .. ';')
    if dir ~= '' then
      root = dir
      pat = v
      break
    end

    local file = vim.fn.findfile(v, cwd .. ';')
    if file ~= '' then
      root = file
      pat = v
      break
    end
  end

  if root ~= '' then
    root = root:gsub('/' .. pat .. '$', '')
  end

  return Project:new {
    projectconfig = self,
    path = root == '' and nil or root,
  }
end

function ProjectConfig:allow_project(prj)
  if self:is_allowed_project(prj) then
    return
  end

  table.insert(self.allowed_projects, prj)
  self:save_allowed_projects()
end

function ProjectConfig:revoke_project(prj)
  local new = {}
  for _, v in ipairs(self.allowed_projects) do
    if v ~= prj then
      table.insert(new, v)
    end
  end
  self.allowed_projects = new
  self:save_allowed_projects()
end

function ProjectConfig:is_allowed_project(prj)
  for _, allowed_prj in ipairs(self.allowed_projects) do
    if allowed_prj == prj then
      return true
    end
  end
  return false
end

function ProjectConfig:load_allowed_projects()
  local f = io.open(self.allowed_project_file, 'r')
  if f == nil then
    return
  end

  local allowed_projects = {}
  local line = f:read()
  while line do
    table.insert(allowed_projects, line)
    line = f:read()
  end

  self.allowed_projects = allowed_projects
  f:close()
end

function ProjectConfig:save_allowed_projects()
  local f = io.open(self.allowed_project_file, "w")
  if f == nil then
    return nil
  end

  f:write(table.concat(self.allowed_projects, "\n"))
  f:close()
end

local M = {}
function M.setup(args)
  M.projectconfig = ProjectConfig:new(args)
  M.projectconfig:load_allowed_projects()

  M.project = M.projectconfig:find_project(args.cwd)
  M.project:load(true)

  vim.api.nvim_create_user_command("ProjectAllow", M.allow, {})
  vim.api.nvim_create_user_command("ProjectRevoke", M.revoke, {})
  vim.api.nvim_create_user_command("ProjectIsAllowed", M.is_allowed, {})
  vim.api.nvim_create_user_command("ProjectList", M.list, {})
end

function M.allow()
  M.project:allow()
end

function M.is_allowed()
  print(M.project:is_allowed())
end

function M.revoke()
  M.project:revoke()
end

function M.list()
  for _, value in ipairs(M.projectconfig.allowed_projects) do
    print(value)
  end
end

return M
