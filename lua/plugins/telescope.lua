-- ファジーファインダー: ファイル検索、grep、バッファ一覧
local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    mappings = {
      i = {
        ["<C-Down>"] = actions.cycle_history_next,
        ["<C-Up>"] = actions.cycle_history_prev,
        ["<C-f>"] = actions.preview_scrolling_down,
        ["<C-b>"] = actions.preview_scrolling_up,
      },
      n = {
        ["q"] = actions.close,
      },
    },
  },
})
-- make 前（初回インストール直後）でも起動を止めないため pcall で読む
pcall(telescope.load_extension, "fzf")
