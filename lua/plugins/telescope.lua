-- ファジーファインダー: ファイル検索、grep、バッファ一覧
local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

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

vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Grep" })
vim.keymap.set("n", "<leader>:", builtin.command_history, { desc = "Command History" })
vim.keymap.set("n", "<leader><space>", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<localleader>bt", builtin.buffers, { desc = "Buffers" })

vim.keymap.set("n", "<leader>G", function()
  local input = vim.fn.input("Glob (カンマ区切り): ")
  builtin.live_grep({ glob_pattern = vim.split(input, ",", { trimempty = true }) })
end, { desc = "Grep (フィルタ付き)" })
