local M = {}
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local function workspace_selection(prompt_bufnr, _)
  actions.select_default:replace(function()
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    local dir_path = vim.fs.normalize("~/workspace/" .. selection[1]:sub(3))
    vim.fn.chdir(dir_path)
    require('oil').open(dir_path)
  end)
  return true
end

local workspace_dirs = function()
  local opts = {
    attach_mappings = workspace_selection,
    find_command = { "find", ".", "-maxdepth", "1", "-type", "d" },
    cwd = vim.fs.normalize("~/workspace"),
  }
  require('telescope.builtin').find_files(opts)
end

M.setup = function()
  vim.keymap.set("n", "<space>ew", workspace_dirs, { desc = "Open workspace directory" })
end

return M
