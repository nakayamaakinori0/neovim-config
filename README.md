# Neovim 設定

Neovim 本体の機能を最大限使い、プラグインは最低限にした設定。方針は [docs/specs/0001](docs/specs/0001-neovim-rearchitecture.md)。

## 必要なもの

- Neovim 0.12 以上
- CLI ツールはすべて brew で入れる（npm のグローバルインストールは使わない）

```sh
brew install neovim tree-sitter-cli \
  lua-language-server typescript typescript-language-server vue-language-server vscode-langservers-extracted \
  stylua shfmt prettier eslint eslint_d
```

## 構成

```
init.lua                 # 読み込み順だけを書く
nvim-pack-lock.json      # vim.pack のロックファイル（git 管理）
lua/config/
  options.lua            # オプション
  keymaps.lua            # キーマップ（プラグイン・LSP の分も含めてすべて）
  autocmds.lua           # オートコマンド
  plugins.lua            # vim.pack.add() と各プラグイン設定の読み込み
  lsp.lua                # vim.lsp.config / vim.lsp.enable、補完
lua/plugins/<name>.lua   # プラグインごとの setup()
lua/custom/codetour/     # 自作プラグイン
docs/specs/              # 開発計画（NNNN-<title>.md）
```

## プラグイン

| プラグイン | 用途 |
|---|---|
| solarized.nvim | カラースキーム |
| telescope.nvim（+ plenary, fzf-native） | ファイル検索・grep・バッファ一覧 |
| gitsigns.nvim | git 差分を行単位で表示 |
| vim-fugitive | `:Git` |
| vim-surround | 囲み編集 |
| nvim-lspconfig | LSP サーバーの既定設定 |
| lazydev.nvim | Neovim の Lua API の補完 |
| conform.nvim | 整形（保存時、Python 以外） |
| nvim-treesitter（main） | パーサーのインストールのみ。ハイライトは本体 |

補完は本体の `vim.lsp.completion`（入力中に自動表示、`<C-y>` で確定）。ファイラーは netrw のツリー表示（`<leader>e` で左に開閉）。

## LSP

| 言語 | サーバー |
|---|---|
| TypeScript / JavaScript | `ts_ls`（プロジェクトの `node_modules/typescript` を使う） |
| Vue | `vue_ls`（HTML/CSS）+ `ts_ls`（`<script>`） |
| ESLint | `eslint`（プロジェクトの eslint を使う） |
| Lua | `lua_ls` |

TypeScript 7 のプロジェクトと `node_modules` がない場所では `ts_ls` が動かない（tsserver がないため）。理由と移行方針は spec 0001 を参照。

## よく使う操作

| 操作 | 方法 |
|---|---|
| プラグイン更新 | `:lua vim.pack.update()` → 確認バッファで `:write` |
| プラグイン削除 | `plugins.lua` から消して `:lua vim.pack.del({ "名前" })` |
| 更新を戻す | `git checkout -- nvim-pack-lock.json` → `:restart` → `:lua vim.pack.update(nil, { target = "lockfile" })` |
| パーサー更新 | `:TSUpdate` |
| 整形 | `<leader>cf` |

## 主なキーマップ

| キー | 動作 |
|---|---|
| `<leader><space>` / `<leader>/` / `<leader>G` | ファイル検索 / grep / glob 付き grep |
| `<Tab>` / `<S-Tab>` / `,bx` | 次 / 前のバッファ / バッファを閉じる |
| `,bt` | バッファ一覧（telescope） |
| `gd` / `gr` / `K` | 定義 / 参照 / ホバー |
| `]h` / `[h` / `<leader>ghp` | 次 / 前のハンク / ハンクのプレビュー |
| `<leader>gs` | `:Git` |
| `v` の中で `an` / `in` | treesitter のノード単位で選択を広げる / 狭める |
