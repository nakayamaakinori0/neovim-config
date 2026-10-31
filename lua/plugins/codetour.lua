-- 自作プラグイン。lua/custom/codetour にあるので vim.pack では管理しない
require("custom.codetour").setup()

vim.keymap.set("n", "<localleader>tn", "<cmd>TourNext<cr>", { desc = "Next tour step" })
vim.keymap.set("n", "<localleader>tp", "<cmd>TourPrev<cr>", { desc = "Previous tour step" })
