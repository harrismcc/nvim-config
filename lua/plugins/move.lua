local opts = {
  noremap = true,
  silent = true,
}
return {
  "fedepujol/move.nvim",
  lazy = false,
  keys = {
    { "<A-j>", ":MoveBlock(1)<CR>", "v" },
    { "<A-Up>", ":MoveBlock(1)<CR>", "v", opts },
    -- { "v", "<A-Up>", ":MoveBlock(1)<CR>" },
  },
}
