return {
  plugin = {
    {"dracula/vim", as = "dracula" },
    "ellisonleao/gruvbox.nvim"
  },
  postsetup = function()
    vim.o.background = "dark"
    require("gruvbox").setup({
        overrides = {
            SignColumn = {bg = "#282828"},
            DiagnosticSignError = {bg = "#282828", fg = "#f54832"},
            DiagnosticSignWarn = {bg = "#282828", fg= "#fabd2f"},
            DiagnosticSignInfo = {bg = "#282828", fg= "#83a598"},
            DiagnosticSignHint = {bg = "#282828", fg= "#8ec07c"},
            GitGutterAdd = {bg = "#282828"},
            GitGutterChange = {bg = "#282828"},
            GitGutterDelete = {bg = "#282828"},
        }
    })
    vim.cmd("colorscheme gruvbox")
  end,
}

