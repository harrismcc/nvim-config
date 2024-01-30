-- return {
--   "williamboman/mason.nvim",
--   opts = function(_, opts)
--     table.insert(opts.ensure_installed, "prettierd")
--     table.insert(opts.ensure_installed, "eslint_d")
--     table.insert(opts.ensure_installed, "prismals")
--   end,
-- }

return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      -- Linters
      "prettierd",
      "eslint_d",
      "cpplint",

      --LSPs
      "arduino-language-server",
      "clangd",
    },
  },
}
