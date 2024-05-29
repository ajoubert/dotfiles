return {
  plugin = {
    -- Autocompletion
    {'hrsh7th/nvim-cmp'},         -- Required
    {'hrsh7th/cmp-nvim-lsp'},     -- Required
    {'hrsh7th/cmp-buffer'},       -- Optional
    {'hrsh7th/cmp-path'},         -- Optional
    {'hrsh7th/cmp-nvim-lua'},     -- Optional

    -- Snippets
    {'L3MON4D3/LuaSnip'},             -- Required
    {'rafamadriz/friendly-snippets'}, -- Optional
  },
  postsetup = function()
    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
    require('luasnip.loaders.from_vscode').lazy_load()

    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')
    lspkind.init({
      symbol_map = {
        Copilot = "",
      },
    })
    vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg ="#6CC644" })

    local select_opts = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end
      },
      sources = {
        { name = 'path' },
        { name = "copilot", keyword_length = 0 },
        { name = 'nvim_lsp', keyword_length = 1 },
        { name = 'buffer', keyword_length = 3 },
        { name = 'luasnip', keyword_length = 2 },
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
        ['<C-k>'] = cmp.mapping.select_prev_item(select_opts),
        ['<C-j>'] = cmp.mapping.select_next_item(select_opts),

        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),

        ['<C-Space>'] = cmp.mapping.complete(),

        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-y>'] = cmp.mapping.confirm({select = true}),
      },
    })
  end
}
