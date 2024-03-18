return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    -- TODO: I want to remap this to f but I can't and it's upsetting to me
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, {noremap= true, desc = "Flash"}},
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "remote flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
