local wk = require("which-key")

local leader_map_vim = vim.api.nvim_eval('g:leader_map')

local maps_nvim = {
  -- g - go
  ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "go to definition" },
  ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "go to declaration" },
  ["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "go to implementation" },
  ["gr"] = { "<cmd>Telescope lsp_references<cr>", "go to references" },

  -- leader + c - code
  ["<leader>c"] = { name = "+code" },
  ["<leader>ca"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
  ["<leader>ch"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
  ["<leader>cu"] = { "<cmd>UndotreeToggle<cr>", "Toggle Undo Tree" },
  ["<leader>cr"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
  ["<leader>ct"] = { "<cmd>TroubleToggle<cr>", "Toggle Diagnostics" },

  -- leader + t - ChatGPT
  ["<leader>t"] = { name = "+ChatGPT" },
  ["<leader>tc"] = { "<cmd>ChatGPT<cr>", "ChatGPT" },
  ["<leader>te"] = { "<cmd>ChatGPTEditWithInstruction<cr>", "Edit with instruction" },
  ["<leader>tg"] = { "<cmd>ChatGPTRun grammar_correction<cr>", "Grammar Correction" },
  ["<leader>tt"] = { "<cmd>ChatGPTRun translate<cr>", "Translate" },
  ["<leader>tk"] = { "<cmd>ChatGPTRun keywords<cr>", "Keywords" },
  ["<leader>td"] = { "<cmd>ChatGPTRun docstring<cr>", "Docstring" },
  ["<leader>ta"] = { "<cmd>ChatGPTRun add_tests<cr>", "Add Tests" },
  ["<leader>to"] = { "<cmd>ChatGPTRun optimize_code<cr>", "Optimize Code" },
  ["<leader>ts"] = { "<cmd>ChatGPTRun summarize<cr>", "Summarize" },
  ["<leader>tf"] = { "<cmd>ChatGPTRun fix_bugs<cr>", "Fix Bugs" },
  ["<leader>tx"] = { "<cmd>ChatGPTRun explain_code<cr>", "Explain Code" },
  ["<leader>tr"] = { "<cmd>ChatGPTRun roxygen_edit<cr>", "Roxygen Edit" },
  ["<leader>tl"] = { "<cmd>ChatGPTRun code_readability_analysis<cr>", "Code Readability Analysis" },

  -- leader + g - git
  ["<leader>g"] = { name = "+git" },
  ["<leader>gb"] = { "<cmd>Git blame<cr>", "Blame" },
  ["<leader>gd"] = { "<cmd>Git diff<cr>", "Diff" },
  ["<leader>gg"] = { "<cmd>GitGutterToggle<cr>", "Toggle Gutter" },
  ["<leader>gl"] = { "<cmd>Telescope git_bcommits<cr>", "Log for current file" },
  ["<leader>gL"] = { "<cmd>Telescope git_commits<cr>", "Complete all logs" },
  ["<leader>gt"] = { "<cmd>silent !tig<cr> :redraw!<cr>", "Tig" },

  -- leader + p - project
  ["<leader>p"] = { name = "+project" },
  ["<leader>pf"] = { "<cmd>Telescope live_grep<cr>", "Search in project" },
  ["<leader>pF"] = { "<cmd>Neotree reveal_force_cwd<cr>", "Reveal in Neotree" },
  ["<leader>po"] = { "<cmd>Telescope find_files<cr>", "Open file" },
  ["<leader>pg"] = { "<cmd>Telescope git_files<cr>", "Git files" },
  ["<leader>pt"] = { "<cmd>Neotree toggle<cr>", "Toggle tree"},

  -- leader + h - help
  ["<leader>h"] = { name = "+other" },
  ["<leader>hh"] = { "<cmd>Telescope help_tags<cr>", "help tags" },
  ["<leader>hR"] = { "<cmd>source $VIM_CONFIG/vimrc<cr>", "Reload neovim" },

  -- leader + f - file operations
  ["<leader>f"] = { name = "+file" },
  ["<leader>ff"] = { "<cmd>Telescope find_files find_command=rg,--ignore,--follow,--files prompt_prefix=🔍<cr>", "Find File" },
  ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
  ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
  ["<leader>fs"] = { "<cmd>Telescope live_grep prompt_prefix=🔍<cr>", "Search in files" },

  -- leader + e - execute
  ["<leader>e"] = { "<cmd>terminal<cr>", "Terminal" },

  -- leader + b - buffers
  ["<leader>b"] = { name = "+buffer" },
  ["<leader>bb"] = { "<cmd>Telescope buffers<cr>", "Switch Buffer" },
}

for k, v in pairs(leader_map_vim) do
  maps_nvim["<leader>"..k] = v
end

-- print(vim.inspect(maps_nvim))
wk.register(maps_nvim)
