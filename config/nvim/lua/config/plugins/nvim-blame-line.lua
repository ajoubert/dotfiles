return {
  {
    'tveskag/nvim-blame-line',
    config = function()
      vim.api.nvim_create_autocmd('BufEnter', {
        desc = 'Shows blame line when entering buffer',
        command = "EnableBlameLine"
      })
    end
  }
}
