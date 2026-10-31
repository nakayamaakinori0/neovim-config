-- 読み込み順: options で leader を決めてからキーマップを張り、最後にプラグインと LSP を設定する
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.plugins")
require("config.lsp")
