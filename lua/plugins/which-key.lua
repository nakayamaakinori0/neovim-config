-- 押しかけのキーに続くキーマップを一覧で出す。グループ名は keymaps.lua の接頭辞に合わせる
require("which-key").setup({
  spec = {
    { "<localleader>b", group = "buffer" },
    { "<localleader>c", group = "code" },
    { "<localleader>f", group = "file" },
    { "<localleader>g", group = "git" },
    { "<localleader>t", group = "tour/terminal" },
  },
})
