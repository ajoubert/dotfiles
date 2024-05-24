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

local chatgpt = {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  config = function()
    require("chatgpt").setup()
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim"
  }
}

local completion = {
  -- Autocompletion
  {'hrsh7th/nvim-cmp'},         -- Required
  {'hrsh7th/cmp-nvim-lsp'},     -- Required
  {'hrsh7th/cmp-buffer'},       -- Optional
  {'hrsh7th/cmp-path'},         -- Optional
  {'hrsh7th/cmp-nvim-lua'},     -- Optional

  -- Snippets
  {'L3MON4D3/LuaSnip'},             -- Required
  {'rafamadriz/friendly-snippets'}, -- Optional
}

local themes = {
  { "dracula/vim", as = "dracula" },
  "ellisonleao/gruvbox.nvim"
}

local copilot = {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "BufEnter",
  config = function()
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        yaml = true,
        help = true,
        gitcommit = true,
        gitrebase = true,
      },
    })
  end,
}

local copilot_cmp = {
  "zbirenbaum/copilot-cmp",
  config = function ()
    require("copilot_cmp").setup()
  end
}
local mason = { "williamboman/mason.nvim" }
local mason_lspconfig = { "williamboman/mason-lspconfig.nvim" }
local nvim_lspconfig = { "neovim/nvim-lspconfig" }
local lspKind = { "onsails/lspkind-nvim" }
local undotree = { "mbbill/undotree" }
local gitgutter = { "airblade/vim-gitgutter" }
local fugitive = { "tpope/vim-fugitive" }
-- rhubarb - The missing :Gbrowse for fugitive.vim and Github
local rhubarb = { "tpope/vim-rhubarb" }

local trouble = {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
}

local prettier = { 'prettier/vim-prettier',
  build = 'yarn install --frozen-lockfile --production',
  ft = {'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'}
}

-- Global variables
vim.g['prettier#autoformat'] = 1
vim.g['prettier#autoformat_require_pragma'] = 0
vim.g['prettier#config#print_width'] = '80'
vim.g['prettier#config#tab_width'] = '2'
vim.g['prettier#config#use_tabs'] = 'false'
vim.g['prettier#config#parser'] = ''
vim.g['prettier#config#config_precedence'] = 'prefer-file'
vim.g['prettier#config#prose_wrap'] = 'preserve'
vim.g['prettier#config#html_whitespace_sensitivity'] = 'css'
vim.g['prettier#config#require_pragma'] = 'false'
vim.g['prettier#config#end_of_line'] = vim.g['prettier#config#end_of_line'] or 'lf'

local neo_tree = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  }
}

local telescope = {
  "nvim-telescope/telescope.nvim",
  tag = '0.1.5'
}

local treesitter = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
}
local which_key_nvim = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
}

local plugins = {
  chatgpt,
  copilot,
  copilot_cmp,
  completion,
  themes,
  fugitive,
  gitgutter,
  lspKind,
  mason,
  mason_lspconfig,
  neo_tree,
  nvim_lspconfig,
  prettier,
  rhubarb,
  telescope,
  trouble,
  undotree,
  which_key_nvim,
  treesitter,
}

require("lazy").setup(plugins)

-- Normally defined in shared/config.vim, but lazy overrides it
-- Necessary to put back for ftplugin and such to work
vim.o.runtimepath = vim.o.runtimepath .. ",$VIM_CONFIG"

vim.o.background = "dark"

require('nvim-treesitter.configs').setup {
  sync_install = false,
  ignore_install = { "" },
  highlight = {
    enable = true,
  },
  indent = { enable = true },
  ensure_installed = {"javascript", "typescript", "tsx", "vue"},
}

require("gruvbox").setup({
    overrides = {
        SignColumn = {bg = "#282828"},
        DiagnosticSignError = {bg = "#282828", fg = "#f54832"},
        DiagnosticSignWarn = {bg = "#282828", fg= "#fabd2f"},
        DiagnosticSignInfo = {bg = "#282828", fg= "#83a598"},
        DiagnosticSignHint = {bg = "#282828", fg= "#8ec07c"},
        GitGutterAdd = {bg = "#282828"},
        GitGutterChange = {bg = "#282828"},
        GitGutterDelete = {bg = "#282828"},
    }
})

require("chatgpt").setup()

local lspconfig = require('lspconfig')

lspconfig.gdscript.setup{
  filetypes = { "gd", "gdscript", "gdscript3" },
  flags = {
    debounce_text_changes = 150,
  },
  root_dir = lspconfig.util.root_pattern("project.godot", ".git"),
}

vim.cmd("colorscheme gruvbox")
