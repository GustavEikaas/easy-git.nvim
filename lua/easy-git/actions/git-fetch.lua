local M = {}

M.period_git_fetch = function(interval)
  local function git_fetch()
    local cmd = "git fetch"
    vim.fn.jobstart(cmd)
  end

  local timer = vim.loop.new_timer()
  timer:start(1000, interval, vim.schedule_wrap(git_fetch))
end

return M
