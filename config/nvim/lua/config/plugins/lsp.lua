---@diagnostic disable: missing-fields
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            {
              path = "${3rd}/luv/library", words = { "vim%.uv" }
            },
          },
        },
      },
      'saghen/blink.cmp',
    },
    config = function()
      -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- This causes issue with lua nvim for some reason
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Find list of all possible lsps with :help lspconfig-all
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup { capabilities = capabilities }
      lspconfig.html.setup { capabilities = capabilities }
      lspconfig.erlangls.setup { capabilities = capabilities }
      lspconfig.lemminx.setup { capabilities = capabilities }
      lspconfig.cssls.setup { capabilities = capabilities }
      lspconfig.volar.setup {
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        init_options = {
          vue = {
            -- Hybrid mode caused an error, falling back to using volar for everything
            hybridMode = false,
          }
        },
        capabilities = capabilities
      }

      -- -- Automatically format on save if lsp supports it
      -- -- No longer necessary, using conform as an alternative (for better prettier etc support)
      -- vim.api.nvim_create_autocmd('LspAttach', {
      --   callback = function(args)
      --     local client = vim.lsp.get_client_by_id(args.data.client_id)
      --     if not client then return end
      --     if client.supports_method('textDocument/formatting') then
      --       -- Format the current buffer on save
      --       vim.api.nvim_create_autocmd('BufWritePre', {
      --         buffer = args.buf,
      --         callback = function()
      --           vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
      --         end,
      --       })
      --     end
      --   end,
      -- })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end
          if client.supports_method('textDocument/definition') then
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
          end
          if client.supports_method('textDocument/declaration') then
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
          end
          if client.supports_method('textDocument/references') then
            vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
          end
          if client.supports_method('textDocument/implementation') then
            vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Go to implementations" })
          end
          if client.supports_method('textDocument/codeAction') then
            vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
          end
          if client.supports_method('textDocument/rename') then
            vim.keymap.set("n", "<Leader>cr", vim.lsp.buf.rename, { desc = "Rename under cursor" })
          end
        end,
      })
    end,
  }
}
