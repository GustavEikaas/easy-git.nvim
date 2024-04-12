local M = {}

local function exec_command(cmd)
  local handle = io.popen(cmd)
  if handle == nil then
    error("Exec failed" .. cmd)
  end
  local value = handle:read("*a")
  handle:close()
  return value
end

--- Discards changes in the current buffer
---@param source string|nil
M.git_restore_curr_buffer = function(source)
  source = type(source) == "string" and source or "origin/main"
  local file_path = vim.fn.expand("%")
  local value = exec_command("git restore --source=" .. source .. " " .. file_path)
  if value then
    vim.notify("File restored from " .. source .. value)
    vim.cmd("checktime")
  end
end

--- Discards changes on the branch and cleans untracked files before pulling changes
M.reset_branch = function()
  local value = exec_command("git reset --hard")
  exec_command("git clean -f -d")
  if value then
    vim.notify("Changes reset")
    vim.cmd("checktime")
  end
  vim.notify("Pulling changes")
  vim.fn.jobstart("git pull")
end

--- Discards changes on current branch and returns to main
---@param main_branch string|nil Name for master/main branch
M.reset_to_main = function(main_branch)
  main_branch = type(main_branch) == "string" and main_branch or "main"
  M.reset_branch()
  exec_command("git checkout " .. main_branch)
  vim.notify("Checked out to " .. main_branch)
end

return M
