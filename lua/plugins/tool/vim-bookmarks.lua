return {
  {
    "MattesGroeger/vim-bookmarks",
    dependencies = { "tom-anders/telescope-vim-bookmarks.nvim" }, -- Telescopeで連携する場合
    config = function()
      vim.g.bookmark_save_per_working_dir = 1
      vim.g.bookmark_auto_save = 1
      vim.g.bookmark_no_default_key_mappings = 1
      vim.g.bookmark_highlight_lines = 1
      vim.cmd([[
        highlight BookmarkSign guifg=#00DABD guibg=NONE
      ]])
      vim.keymap.set("n", "<localleader>mm", "<cmd>BookmarkToggle<cr>", { desc = "BookmarkToggle" })
      vim.keymap.set("n", "<localleader>mi", "<cmd>BookmarkAnnotate<cr>", { desc = "BookmarkAnnotate" })
      vim.keymap.set("n", "<localleader>ml", "<cmd>BookmarkShowAll<cr>", { desc = "BookmarkShowAll" })
      vim.keymap.set("n", "<localleader>mn", "<cmd>BookmarkNext<cr>", { desc = "BookmarkNext" })
      vim.keymap.set("n", "<localleader>mp", "<cmd>BookmarkPrev<cr>", { desc = "BookmarkPrev" })
      vim.keymap.set("n", "<localleader>md", "<cmd>BookmarkClearAll<cr>", { desc = "BookmarkClearAll" })
    end,
  },
}
