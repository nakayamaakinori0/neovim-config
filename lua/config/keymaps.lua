-- Basic keymaps
vim.keymap.set("n", "<leader>w", ":w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<cr>", { desc = "Quit window" })
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")
vim.keymap.set("n", "H", "0")
vim.keymap.set("n", "L", "$")
vim.keymap.set("v", "H", "0")
vim.keymap.set("v", "L", "$")
vim.keymap.set("n", "<leader>r", ":%s///gc<Left><Left><Left><Left>", { desc = "Replace in file" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

vim.keymap.set("n", "<leader>e", ":Oil<CR>", { desc = "Open parent directory" })

-- Range indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Split
vim.keymap.set("n", "<leader>s", ":split<CR>", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { desc = "Split window right", remap = true })

vim.keymap.set("n", "<localleader>tt", ":term<CR>", { desc = "Open terminal" })
vim.keymap.set("n", "<localleader>tk", ":Telekasten panel<CR>")

vim.keymap.set("n", "<localleader>gd", function()
  local diffview = require("diffview.lib")
  if diffview.get_current_view() then
    vim.cmd("DiffviewClose")
  else
    vim.cmd("DiffviewOpen")
  end
end, { desc = "Toggle Diffview" })

vim.keymap.set("n", "<leader>fy", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  print("Copied to clipboard: " .. path)
end, { desc = "Copy relative file path" })

vim.keymap.set("n", "<leader>fY", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("Copied to clipboard: " .. path)
end, { desc = "Copy absolute file path" })

vim.keymap.set("n", "<leader>G", function()
  local input = vim.fn.input("Glob (カンマ区切り): ")
  local patterns = vim.split(input, ",", { trimempty = true })
  require("telescope.builtin").live_grep({
    glob_pattern = patterns,
  })
end, { desc = "Grep (フィルタ付き)" })
