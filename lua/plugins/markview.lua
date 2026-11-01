-- Neovim の中で Markdown を整形して表示する。既定は無効で、,mv で切り替える
require("markview").setup({
  preview = {
    enable = false,
  },
})
