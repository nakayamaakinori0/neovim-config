return {
  "codetour",
  dir = vim.fn.stdpath("config") .. "/lua/custom/codetour",
  lazy = true,
  cmd = { "TourNext", "TourPrev", "TourLoad" },
  keys = {
    { "<localleader>tn", "<cmd>TourNext<cr>", desc = "Next tour step" },
    { "<localleader>tp", "<cmd>TourPrev<cr>", desc = "Previous tour step" },
  },
  config = function()
    require("custom.codetour").setup()
  end,
}
