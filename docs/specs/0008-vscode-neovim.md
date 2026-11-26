# 0008 VS Code の Vim を VSCodeVim から vscode-neovim に替える

- ステータス: 進行中
- 作成日: 2026-11-26

## 1. 背景

VS Code では VSCodeVim を使っていて、キーマップは VS Code の `settings.json`（`vim.*`）に別で書いている。nvim の設定と 2 か所に分かれていて、片方だけ直してずれる。VSCodeVim は Vim をまねて作ったものなので、`.` リピートやマクロ、`:g` の動きが nvim と少し違う。

vscode-neovim は nvim 本体を裏で動かし、この設定（`init.lua`）を読む。VS Code のキーマップも nvim の設定の中に書ける。

## 2. 方針

`init.lua` の頭で `vim.g.vscode`（vscode-neovim が立てる）を見て、VS Code の中なら `lua/config/vscode.lua` だけを読んで終わる。画面・検索・git・LSP は VS Code が受け持つので、ほかの config は読まない。

`vscode.lua` は options / keymaps / autocmds と共通にしない。leader、編集のキー（`H` / `L` / `<leader>o` など）、ヤンクのハイライト、vim-surround の読み込みも `vscode.lua` に自前で書く。VS Code の中で何が効いているかを、`vscode.lua` だけ読めば分かるようにするため。編集のキーが 2 か所に重なるが、7 行ほどなので、まとめるより分けておくほうを取る。

キーは nvim と同じキーに、VS Code のコマンドを割り当てる（`<leader><space>` → Quick Open、`,gs` → 選んだ範囲をステージ、など）。

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

`jj` は、VS Code の中では挿入モードの入力を VS Code が受けるので、`vscode.lua` に書いても効かない。`settings.json` の `vscode-neovim.compositeKeys` に書く。

| 案 | 採らなかった理由 |
|---|---|
| 同じ `init.lua` を読み、`plugins.lua` / `keymaps.lua` / `autocmds.lua` / `lsp.lua` の中を `if vim.g.vscode` で分ける | 分岐が 4 ファイルに散らばり、VS Code の中で何が効いているかを追いにくい。最初はこの形で書いたが、`vscode.lua` に分け直した |
| 編集のキーと options を共通にして、`vscode.lua` からも読む | 共通部分を変えると VS Code の中にも効いてしまい、VS Code の中を `vscode.lua` だけで読めなくなる |

## 3. 作業

- [x] `lua/config/vscode.lua` を作り、`init.lua` の頭で VS Code の中ならこれだけ読む
- [x] ARCHITECTURE、README、CLAUDE.md に書く
- [x] `settings.json`（`~/dotfiles/vscode/settings.json`）に `vscode-neovim.compositeKeys` の `jj` を足す
- [x] `settings.json` の `vim.*` を消す
- [ ] VS Code で VSCodeVim を無効にする
- [ ] VS Code で動きを確かめる（キー、`gj` / `gk` で畳んだ範囲を飛ばせるか、`,gs` が選択範囲にだけ効くか）
