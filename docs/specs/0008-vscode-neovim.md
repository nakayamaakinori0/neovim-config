# 0008 VS Code の Vim を VSCodeVim から vscode-neovim に替える

- ステータス: 進行中
- 作成日: 2026-11-26

## 1. 背景

VS Code では VSCodeVim を使っていて、キーマップは VS Code の `settings.json`（`vim.*`）に別で書いている。nvim の設定と 2 か所に分かれていて、片方だけ直してずれる。VSCodeVim は Vim をまねて作ったものなので、`.` リピートやマクロ、`:g` の動きが nvim と少し違う。

vscode-neovim は nvim 本体を裏で動かし、この設定（`init.lua`）をそのまま読む。キーマップを `keymaps.lua` 1 か所にまとめられる。

## 2. 方針

`vim.g.vscode`（vscode-neovim が立てる）で、VS Code の中かどうかを分ける。

| ファイル | VS Code の中での扱い |
|---|---|
| `options.lua` | そのまま読む |
| `keymaps.lua` | 編集のキー（`jj` / `H` / `L` / `<leader>o` など）は共通。プラグインのキーは張らず、同じキーに VS Code のコマンドを割り当てる |
| `autocmds.lua` | ヤンクのハイライトなどは共通。最後の位置へ戻る・ウィンドウを揃えるは読まない（VS Code が受け持つ） |
| `plugins.lua` | vim-surround だけ読む。ほかは画面・検索・git・LSP のもので、VS Code が受け持つ |
| `lsp.lua` | 読まない |

VSCodeVim の `settings.json` にあって、この設定にないキーは次のように扱う。

| VSCodeVim のキー | 扱い | 理由 |
|---|---|---|
| `J` / `K`（10 行移動） | 移さない | 標準の `J`（行をつなぐ）と `K`（ホバー）を潰すため |
| `s`（`ys`） | 移さない | 標準の `s` を潰すため。`ys` をそのまま打つ |
| `<leader>-` / `<leader>\|` / `<leader>v` / `<leader>s`（分割） | 移さない | 標準の `Ctrl+w s` / `Ctrl+w v` が VS Code の分割になる |
| `u` / `Ctrl+r`（VS Code の undo） | 移さない | nvim の undo と混ぜると履歴がずれる |
| `<leader>k`（ホバー） | 移さない | 標準の `K` が VS Code のホバーになる |
| `<leader>b` / `bn` / `bp`（Bookmarks 拡張） | 移さない | `<leader>` + 2 文字は決まりに反する。標準のマーク（`m` / `'`）で代わりにする |
| `<leader>l`（turbo console log） / `<leader>z`（Zen モード） | VS Code の中だけ張る | VS Code の拡張・機能なので nvim には対応するものがない |
| `vim.foldfix` | `j` / `k` を `gj` / `gk` に回す | nvim の `j` / `k` だと、VS Code で畳んだ範囲に入ると開いてしまう |

`jj` は、VS Code の中では挿入モードの入力を VS Code が受けるので、`keymaps.lua` では効かない。`settings.json` の `vscode-neovim.compositeKeys` に書く。

| 案 | 採らなかった理由 |
|---|---|
| VS Code 用のキーを `lua/config/vscode.lua` に分ける | キーマップは `keymaps.lua` 1 か所に書く決まり（ARCHITECTURE 6 章） |
| VS Code の中では `init.lua` を読まず、別の設定にする | 編集のキーを 2 か所に書くことになり、今と同じくずれる |

## 3. 作業

- [x] `init.lua` で、VS Code の中では `lsp.lua` を読まない
- [x] `plugins.lua` で、VS Code の中では vim-surround だけ読む
- [x] `keymaps.lua` に VS Code の中のキーを書く
- [x] `autocmds.lua` で、VS Code の中では最後の位置へ戻る・ウィンドウを揃えるを読まない
- [x] ARCHITECTURE と README に書く
- [x] `settings.json`（`~/dotfiles/vscode/settings.json`）に `vscode-neovim.compositeKeys` の `jj` を足す
- [ ] VS Code で VSCodeVim を無効にする
- [ ] VS Code で動きを確かめる（キー、`gj` / `gk` で畳んだ範囲を飛ばせるか、`,gs` が選択範囲にだけ効くか）
- [ ] `settings.json` の `vim.*` を消す
