local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local function loadPluginsData()
  local r = { plugins = {}, postsetups = {} }
  local lscmd = 'ls '..os.getenv('VIM_CONFIG')..'/config/neovim/plugins/*.plugin.lua'
  local filepaths = io.popen(lscmd)
  if not filepaths then
    return r
  end
  for filepath in filepaths:lines() do
      local plugin_config = dofile(filepath)
      table.insert(r.plugins, plugin_config.plugin)
      if plugin_config.postsetup then
        table.insert(r.postsetups, plugin_config.postsetup)
      end
  end
  filepaths:close()
  return r
end

local pluginsData = loadPluginsData()

require("lazy").setup(pluginsData.plugins)

-- Normally defined in shared/config.vim, but lazy overrides it
-- Necessary to put back for ftplugin and such to work
vim.o.runtimepath = vim.o.runtimepath .. ",$VIM_CONFIG"

for _, postsetup in ipairs(pluginsData.postsetups) do
  postsetup()
end
