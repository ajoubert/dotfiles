vim.o.completeopt = "menuone,noselect"

-- local lsp_installer = require("nvim-lsp-installer")
-- lsp_installer.setup {}
require("mason").setup()
local mason_lspconfig = require("mason-lspconfig");
mason_lspconfig.setup({
    ensure_installed = {
      "ansiblels",
      "bashls",
      "clangd",
      "cmake",
      "cssls",
      "dockerls",
      "docker_compose_language_service",
      "gopls",
      "html",
      "jsonls",
      "lua_ls",
      "pyright",
      "rust_analyzer",
      "tsserver",
      "vimls",
      "yamlls",
      "zls"
    }
})

local lspconfig = require("lspconfig")

mason_lspconfig.setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ["rust_analyzer"] = function ()
        -- require("rust-tools").setup {}
    -- end
    ["lua_ls"] = function()
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            runtime = {
              version = 'Lua 5.3',
            },
            workspace = {
              checkThirdParty = false,
            },
            library = {
              ['/usr/share/nvim/runtime/lua'] = true,
              ['/usr/share/nvim/runtime/lua/lsp'] = true,
              ['/usr/share/awesome/lib'] = true
            },
            diagnostics = {
              enable = true;
              globals = {
                -- Neovim config
                'vim',

                -- AwesomeWM config
                "awesome",
                "client",
                "root"
              };
            }
          }
        }
      })
    end,
    ["yamlls"] = function()
      lspconfig.yamlls.setup({
        settings = {
          yaml = {
            -- Fix mapKeyOrder warning
            keyOrdering = false,
          }
        }
      })
    end
}

-- local pid = vim.fn.getpid()
-- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
-- local omnisharp_bin = "/home/sloth/.local/share/nvim/lsp_servers_manual/omnisharp/run"

-- lspconfig.omnisharp.setup{
--     cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
--     root_dir = lspconfig.util.root_pattern("*.csproj","*.sln");
--     ...
-- }

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = true;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = false;
    ultisnips = true;
    luasnip = true;
  };
}

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    find_files = {
      find_command = { "rg", "--ignore", "-L", "--hidden", "--files" },
    }
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
require('telescope').load_extension('live_grep_args')
