-- 読み込み順: options で leader を決めてからキーマップを張り、最後にプラグインと LSP を設定する
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.plugins")
-- VS Code の中（vscode-neovim）では LSP を VS Code が受け持つので、nvim 側では起動しない
if not vim.g.vscode then
  require("config.lsp")
end
