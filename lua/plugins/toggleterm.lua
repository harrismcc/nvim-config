return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      {
        "<leader>td",
        "<cmd>ToggleTerm size=25 dir=git_dir direction=horizontal<cr>",
        desc = "Open a horizontal terminal at the current git directory",
      },
    },
    config = true,
  },
}
