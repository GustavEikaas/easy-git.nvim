local M = {}

local function merge_tables(table1, table2)
  local merged = {}
  for k, v in pairs(table1) do
    merged[k] = v
  end
  for k, v in pairs(table2) do
    merged[k] = v
  end
  return merged
end

--- Fetches remote branches every x minutes
M.setup = function(opts)
  local merged_options = merge_tables(require("easy-git.options"), opts or {})
  if merged_options.period_git_fetch.enabled then
    require("easy-git.actions.git-fetch").period_git_fetch(merged_options.period_git_fetch.interval)
  end
end

local reset = require("easy-git.actions.restore")
M.reset_branch = reset.reset_branch
M.restore_current_file = reset.git_restore_curr_buffer
M.reset_to_main = reset.reset_to_main

M.pick_branch = require("easy-git.actions.pick-branch").pick_branch

return M
