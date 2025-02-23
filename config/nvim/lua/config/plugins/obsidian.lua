return {
  "epwalsh/obsidian.nvim",
  version = "*", -- latest release
  lazy = true,
  -- Only load obsidian.nvim for markdown files in the vault:
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "/.local/share/vimwiki/*.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/.local/share/vimwiki/*.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "my-wiki",
        path = "~/.local/share/vimwiki",
      },
    },
    ui = {
      enable = false
    },

    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "diary",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y/%m/%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, default tags to add to each new daily note created.
      default_tags = { "dailynotes" },
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = "dailynotes.md"
    },

    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },

    follow_url_func = function(url)
      vim.ui.open(url) -- need Neovim 0.10.0+
    end,

    follow_img_func = function(url)
      vim.fn.jobstart({ "xdg-open", url })
    end,

  },
}
