return {
  "chrisgrieser/nvim-chainsaw",
  lazy = false,
  keys = {
    { "<leader>cc", "", desc = "Comment Shortcuts" },
    {
      "<leader>ccm",
      function()
        require("chainsaw").messageLog()
      end,
      desc = "Message Log",
    },
    {
      "<leader>ccv",
      function()
        require("chainsaw").variableLog()
      end,
      desc = "Variable Log",
    },
    {
      "<leader>cco",
      function()
        require("chainsaw").objectLog()
      end,
      desc = "Object Log",
    },
    {
      "<leader>cca",
      function()
        require("chainsaw").assertLog()
      end,
      desc = "Assert Log",
    },
    {
      "<leader>ccb",
      function()
        require("chainsaw").beepLog()
      end,
      desc = "Beep Log",
    },
    {
      "<leader>cct",
      function()
        require("chainsaw").timeLog()
      end,
      desc = "Time Log",
    },
    {
      "<leader>ccd",
      function()
        require("chainsaw").removeLogs()
      end,
      desc = "Delete All Logs",
    },
  },
}
