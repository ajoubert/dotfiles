return {
  plugin = {
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    { "onsails/lspkind-nvim" }
  },
  postsetup = function()
    require("mason").setup()

    local lspconfig = require('lspconfig')
    local mason_lspconfig = require("mason-lspconfig");
    -- Vue requires extra config to work with typescript
    -- See: https://github.com/vuejs/language-tools
    local mason_registry = require('mason-registry')
    local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'

    -- List all LSPs to install
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
          "tailwindcss",
          "ts_ls",
          "vimls",
          "yamlls",
          "zls"
        }
    })

    -- Custom configuration for some LSPs
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
              }
            }
          }
        })
      end,
      ["ts_ls"] = function()
        lspconfig.ts_ls.setup {
          init_options = {
            plugins = {
              {
                name = '@vue/typescript-plugin',
                location = vue_language_server_path,
                languages = { 'vue' },
              },
            },
          },
          filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        }
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

    -- Mason doesn't support gdscript, requires its own setup
    lspconfig.gdscript.setup {
      filetypes = { "gd", "gdscript", "gdscript3" },
      flags = {
        debounce_text_changes = 150,
      },
      root_dir = lspconfig.util.root_pattern("project.godot", ".git"),
    }

  end,
}
