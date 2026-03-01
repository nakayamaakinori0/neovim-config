return {
  "tpope/vim-fugitive",
  event = { "VeryLazy" },
  config = function()
    -- Optional: Set up any custom keybindings or configurations here
    vim.api.nvim_set_keymap("n", "<leader>gs", ":Git<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>gc", ":Git commit<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>gc", ":Git commit<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>gp", ":Git push<CR>", { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap("n", "<leader>gd", ":Gvdiffsplit<CR>", { noremap = true, silent = true })
  end,
}
