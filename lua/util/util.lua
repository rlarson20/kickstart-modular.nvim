local M = {}

-- snagged from alexjercan nvim dots, assume it's just a check for if module exists
M.has = function(name)
  local ok, _ = pcall(require, name)
  return ok
end

return M
