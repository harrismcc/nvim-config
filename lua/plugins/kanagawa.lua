return {
  {
    'rebelot/kanagawa.nvim',
    priority = 1000, -- make sure to load this before all the other start plugins
  },
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'kanagawa',
    },
  },
}
