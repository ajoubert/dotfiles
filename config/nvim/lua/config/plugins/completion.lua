return { {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  enabled = true,

  version = 'v0.*',

  opts = {
    keymap = {
      preset = 'default',
      ['<C-y>'] = {
        'select_and_accept',
        'fallback'
      },
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation', 'fallback' },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },
    completion = {
      documentation = {
        auto_show = true,
      },

      ghost_text = {
        enabled = false,
      },
    },

    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer', 'codecompanion' },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        codecompanion = {
          name = "CodeCompanion",
          module = "codecompanion.providers.completion.blink",
        },
      }
    },

    signature = { enabled = true }
  },
} }
