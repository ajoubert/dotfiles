return {
  plugin = {
    'prettier/vim-prettier',
    build = 'yarn install --frozen-lockfile --production',
    ft = {'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'}
  },
  postsetup = function()
    -- Global variables
    vim.g['prettier#autoformat'] = 1
    vim.g['prettier#autoformat_require_pragma'] = 0
    vim.g['prettier#config#print_width'] = '80'
    vim.g['prettier#config#tab_width'] = '2'
    vim.g['prettier#config#use_tabs'] = 'false'
    vim.g['prettier#config#parser'] = ''
    vim.g['prettier#config#config_precedence'] = 'prefer-file'
    vim.g['prettier#config#prose_wrap'] = 'preserve'
    vim.g['prettier#config#html_whitespace_sensitivity'] = 'css'
    vim.g['prettier#config#require_pragma'] = 'false'
    vim.g['prettier#config#end_of_line'] = vim.g['prettier#config#end_of_line'] or 'lf'
  end,
}
