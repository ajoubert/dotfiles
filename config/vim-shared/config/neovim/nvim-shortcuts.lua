local wk = require("which-key")

local maps_nvim = {
  { "<leader>wo", desc = "close-all-windows-except-current" },
  { "<leader>w|", desc = "split-window-right" },

  -- g - go
  { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "go to definition" },
  { "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "go to declaration" },
  { "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "go to implementation" },
  { "gr", "<cmd>Telescope lsp_references<cr>", desc = "go to references" },

  -- leader + c - code
  { "<leader>c", group = "code" },
  { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
  { "<leader>ch", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Hover" },
  { "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
  { "<leader>ct", "<cmd>TroubleToggle<cr>", desc = "Toggle Diagnostics" },
  { "<leader>cu", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undo Tree" },

  -- leader + t - ChatGPT
  { "<leader>t", group = "ChatGPT" },
  { "<leader>ta", "<cmd>ChatGPTRun add_tests<cr>", desc = "Add Tests" },
  { "<leader>tc", "<cmd>ChatGPT<cr>", desc = "ChatGPT" },
  { "<leader>td", "<cmd>ChatGPTRun docstring<cr>", desc = "Docstring" },
  { "<leader>te", "<cmd>ChatGPTEditWithInstruction<cr>", desc = "Edit with instruction" },
  { "<leader>tf", "<cmd>ChatGPTRun fix_bugs<cr>", desc = "Fix Bugs" },
  { "<leader>tg", "<cmd>ChatGPTRun grammar_correction<cr>", desc = "Grammar Correction" },
  { "<leader>tk", "<cmd>ChatGPTRun keywords<cr>", desc = "Keywords" },
  { "<leader>tl", "<cmd>ChatGPTRun code_readability_analysis<cr>", desc = "Code Readability Analysis" },
  { "<leader>to", "<cmd>ChatGPTRun optimize_code<cr>", desc = "Optimize Code" },
  { "<leader>tr", "<cmd>ChatGPTRun roxygen_edit<cr>", desc = "Roxygen Edit" },
  { "<leader>ts", "<cmd>ChatGPTRun summarize<cr>", desc = "Summarize" },
  { "<leader>tt", "<cmd>ChatGPTRun translate<cr>", desc = "Translate" },
  { "<leader>tx", "<cmd>ChatGPTRun explain_code<cr>", desc = "Explain Code" },

  -- leader + g - git
  { "<leader>g", group = "git" },
  { "<leader>gL", "<cmd>Telescope git_commits<cr>", desc = "Complete all logs" },
  { "<leader>gb", "<cmd>Git blame<cr>", desc = "Blame" },
  { "<leader>gd", "<cmd>Git diff<cr>", desc = "Diff" },
  { "<leader>gg", "<cmd>GitGutterToggle<cr>", desc = "Toggle Gutter" },
  { "<leader>gl", "<cmd>Telescope git_bcommits<cr>", desc = "Log for current file" },
  { "<leader>gt", "<cmd>silent !tig<cr> :redraw!<cr>", desc = "Tig" },

  -- leader + p - project
  { "<leader>p", group = "project" },
  { "<leader>pF", "<cmd>Neotree reveal_force_cwd<cr>", desc = "Reveal in Neotree" },
  { "<leader>pf", "<cmd>Telescope live_grep<cr>", desc = "Search in project" },
  { "<leader>pg", "<cmd>Telescope git_files<cr>", desc = "Git files" },
  { "<leader>po", "<cmd>Telescope find_files find_command=rg,--ignore,--follow,--files prompt_prefix=🔍<cr>", desc = "Find File" },
  { "<leader>pt", "<cmd>Neotree toggle<cr>", desc = "Toggle tree" },

  -- leader + h - help
  { "<leader>h", group = "help" },
  { "<leader>hh", "<cmd>Telescope help_tags<cr>", desc = "help tags" },
  { "<leader>hR", "<cmd>source $VIM_CONFIG/vimrc<cr>", desc = "Reload neovim" },

  -- leader + f - file operations
  { "<leader>f", group = "file" },
  { "<leader>ff", "<cmd>Telescope find_files find_command=rg,--ignore,--follow,--files prompt_prefix=🔍<cr>", desc = "Find File" },
  { "<leader>fn", "<cmd>enew<cr>", desc = "New File" },
  { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },
  { "<leader>fs", "<cmd>Telescope live_grep prompt_prefix=🔍<cr>", desc = "Search in files" },

  -- leader + e - execute
  { "<leader>e", "<cmd>terminal<cr>", desc = "Terminal" },

  -- leader + b - buffers
  { "<leader>b", group = "buffer" },
  { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Switch Buffer" },
}

-- Add vim-shared leader mappings
local leader_map_vim = vim.api.nvim_eval('g:leader_map')
for group, commands in pairs(leader_map_vim) do
  for letter, desc in pairs(commands) do
    if letter == "name" then
      table.insert(maps_nvim, { "<leader>"..group, desc = desc })
    else
      table.insert(maps_nvim, { "<leader>"..group..letter, desc = desc })
    end
  end
end

wk.add(maps_nvim)
