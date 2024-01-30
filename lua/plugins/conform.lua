-- Used for formatters that regular mason doesn't have or can't handle
return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      hcl = { "packer_fmt" },
      nix = { "nixfmt" },
    },
  },
}
