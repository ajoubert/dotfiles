require("config.lazy")

vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"

vim.keymap.set("n", "<Leader><Leader>x", "<cmd>source %<CR>", { desc = "Source file" })
vim.keymap.set("n", "<Leader>x", ":.lua<CR>", { desc = "Run current line" })
vim.keymap.set("v", "<Leader>x", ":lua<CR>", { desc = "Run selection" })
vim.keymap.set("n", "-", ":Oil<CR>", { desc = "Open Oil.nvim" })
vim.keymap.set("n", "<Leader>t", ":lua require('obsidian')<CR>:ObsidianToday<CR>", { desc = "Open daily note" })
vim.keymap.set("n", "<Leader>T", ":lua require('obsidian')<CR>:ObsidianQuickSwitch tasks<CR>",
  { desc = "Open tasks" })
vim.keymap.set("n", "<Leader><Leader>t", ":lua require('obsidian')<CR>:ObsidianDailies<CR>", { desc = "Open daily note" })
vim.keymap.set("n", "<Leader>O", ":lua require('obsidian')<CR>:ObsidianQuickSwitch<CR>", { desc = "Search for note" })

-- Highlight when yanking (copying) text
-- Try it with `yap` in normal mode
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
