vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

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
      "tailwindcss",
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

require('luasnip.loaders.from_vscode').lazy_load()

local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')
lspkind.init({
  symbol_map = {
    Copilot = "",
  },
})
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})

local select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    {name = 'path'},
    {name = "copilot", keyword_length = 0},
    {name = 'nvim_lsp', keyword_length = 1},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '...',
      show_labelDetails = true,
    }),
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),

    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    ['<C-f>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<C-b>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),
  },
})
