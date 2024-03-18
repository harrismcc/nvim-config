return {
  'kdheepak/lazygit.nvim',
  keys = {
    { '<leader>gg', '<Cmd>LazyGit<CR>', desc = 'Show LazyGit Window' },
  },
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  -- optional for floating window border decoration
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}
