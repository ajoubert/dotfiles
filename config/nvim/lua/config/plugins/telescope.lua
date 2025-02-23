return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    require('telescope').setup {
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "-L" },
          theme = "ivy"
        }
      }
    }
    vim.keymap.set("n", "<space>fd", require('telescope.builtin').find_files, { desc = "Find files" })
    vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags, { desc = "Open help" })
    vim.keymap.set("n", "<space>en", function()
      require('telescope.builtin').find_files {
        cwd = vim.fn.stdpath("config")
      }
    end, { desc = "Open config" })
    vim.keymap.set("n", "<space>ep", function()
      -- JoinPath expects a string, but stdpath could be an array. Getting the first element if that's the case
      local stdpathoutput = vim.fn.stdpath("data")
      local datapath = type(stdpathoutput) == "string" and stdpathoutput or stdpathoutput[1]
      require('telescope.builtin').find_files {
        cwd = vim.fs.joinpath(datapath, "lazy")
      }
    end, { desc = "Open Lazy package" })
    vim.keymap.set("n", "<space>ed", function()
      require('telescope.builtin').find_files {
        cwd = vim.fs.normalize("~/.dotfiles/")
      }
    end, { desc = "Open dotfiles" })
    vim.keymap.set("n", "<space>eD", function()
      require('telescope.builtin').find_files {
        cwd = vim.fs.normalize("~/workspace/dockerfiles/")
      }
    end, { desc = "Open dockerfiles" })

    vim.keymap.set("n", "<space>eo", function()
      require('telescope.builtin').find_files {
        cwd = vim.fs.normalize("~/.local/share/vimwiki/")
      }
    end, { desc = "Open wiki" })
    require('telescope').load_extension('fzf')
    require "config.telescope.multigrep".setup()
    require "config.telescope.workspaces".setup()
  end
}
