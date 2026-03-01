-- TODO/FIXME/NOTE等のコメントをハイライト
return {
  "folke/todo-comments.nvim",
  keys = {
    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
  },
}
