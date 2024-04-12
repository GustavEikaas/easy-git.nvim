# easy-git.nvim

## Motivation

A simplification of common tasks that I repeat a lot during my workflow.

## Work in progress 🚧🏗

I'm a sole believer in making things I would use myself. I will be actively using this plugin while coding for a while to let it develop based on actual needs. 
Feel free to test it out and make suggestions.

## Setup

```lua
-- lazy.nvim

{
  "GustavEikaas/easy-git.nvim"
  dependencies = { 'nvim-telescope/telescope.nvim', },
  config = function()
    local git = require("easy-git")
    git.setup()

    -- Example commands that can be created
    vim.api.nvim_create_user_command('B', git.pick_branch, {})
    vim.api.nvim_create_user_command('GGRF', git.restore_file, {})
    vim.api.nvim_create_user_command("GGRM", git.reset_to_main, {})
    vim.api.nvim_create_user_command("GGR", git.reset_branch, {})
  end
}
```

