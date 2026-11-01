-- 押しかけのキーに続くキーマップを一覧で出す。グループ名は keymaps.lua の接頭辞に合わせる
require("which-key").setup({
  spec = {
    { "<leader>c", group = "code" },
    { "<leader>f", group = "file" },
    { "<leader>g", group = "git" },
    { "<leader>gh", group = "hunks" },
    { "<localleader>b", group = "buffer" },
    { "<localleader>m", group = "markdown" },
    { "<localleader>t", group = "tour/terminal" },
  },
})
