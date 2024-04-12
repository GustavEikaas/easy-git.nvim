local M = {}

local function trim(s)
  return s:match "^%s*(.-)%s*$"
end

local function exec_command(cmd)
  local handle = io.popen(cmd)
  if handle == nil then
    error("Exec failed" .. cmd)
  end
  local value = {}
  for line in handle:lines() do
    if string.find(line, "HEAD") == nil then
      table.insert(value, trim(line))
    end
  end
  handle:close()
  return value
end
M.pick_branch = function()
  os.execute("git fetch --all")
  local branches = exec_command("git branch")
  if #branches == 0 then
    vim.notify("No branches available")
    return
  end
  local picker = require("easy-git.picker")
  picker.picker(nil, branches, function(branch)
    vim.notify("Switching branch " .. branch)
    os.execute("git checkout " .. branch)
  end, "Pick branch")
end

return M
