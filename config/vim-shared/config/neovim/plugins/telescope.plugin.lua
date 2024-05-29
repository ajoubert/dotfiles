return {
  plugin = {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.5'
  },
  postsetup = function()
    local telescope = require("telescope")
    local telescopeConfig = require("telescope.config")
    if not table.unpack then
      --- Lua 5.1 compatibility already handled, I don't need the deprecation
      --- message
      ---@diagnostic disable-next-line: deprecated
      table.unpack = unpack
    end
    local vimgrep_arguments = { table.unpack(telescopeConfig.values.vimgrep_arguments) }

    -- Follow symbolic links
    table.insert(vimgrep_arguments, "-L")

    telescope.setup({
      defaults = {
        vimgrep_arguments = vimgrep_arguments,
      },
    })
  end,
}
