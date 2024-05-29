return {
  plugin = {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },
  postsetup = function()
    require('nvim-treesitter.configs').setup {
      sync_install = false,
      ignore_install = { "" },
      highlight = {
        enable = true,
      },
      indent = { enable = true },
      ensure_installed = {"javascript", "typescript", "tsx", "vue"},
    }
  end,
}
