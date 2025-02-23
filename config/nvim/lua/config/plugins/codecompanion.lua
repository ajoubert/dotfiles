return { {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require('codecompanion').setup({
      display = {
        diff = {
          enabled = true,
          layout = "horizontal",
          provider = "mini_diff",
        },
      },
      strategies = {
        chat = {
          adapter = "anthropic"
        },
        inline = {
          adapter = "anthropic"
        }
      },
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "cmd: echo $ANTHROPIC_API_KEY"
            }
          })
        end,
      }
    })
    vim.keymap.set("n", "<Leader>cc", "<cmd>CodeCompanionActions<CR>", { desc = "CodeCompanion actions" })
  end
} }
