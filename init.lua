-- VS Code の中（vscode-neovim）では vscode.lua だけを読む。画面・検索・git・LSP は VS Code が受け持つので、ここから下は要らない
if vim.g.vscode then
  require("config.vscode")
  return
end

-- 読み込み順: options で leader を決めてからキーマップを張り、最後にプラグインと LSP を設定する
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.plugins")
require("config.lsp")
