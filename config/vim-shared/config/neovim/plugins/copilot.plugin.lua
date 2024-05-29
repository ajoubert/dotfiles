return {
  plugin = {
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
  },
}
