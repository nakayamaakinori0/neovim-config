# ARCHITECTURE

この Neovim 設定の全体の構造と、各部分が何を担当しているかをまとめる。読む順番は [読み方ガイドライン.md](読み方ガイドライン.md) を参照。

## 1. 方針

**Neovim 0.12 の本体機能でできることは本体に任せ、プラグインは本体にない機能だけに使う。**（[spec 0001](specs/0001-neovim-rearchitecture.md)）

| 機能 | 担当 | 本体 / プラグイン |
|---|---|---|
| プラグイン管理 | `vim.pack` | 本体 |
| LSP の起動 | `vim.lsp.config` / `vim.lsp.enable` | 本体 |
| 補完 | `vim.lsp.completion` | 本体 |
| ハイライト・インデント | `vim.treesitter` | 本体（パーサーの入手だけ nvim-treesitter） |
| ファイルツリー | netrw | 本体 |
| 全文検索からの置換 | `:grep` + quickfix（`:cdo`） | 本体 |
| コメントアウト | `gc` | 本体 |
| ファジー検索 | telescope | プラグイン |
| Git | gitsigns、fugitive | プラグイン |
| 整形 | conform | プラグイン |
| Markdown の表示 | markview、markdown-preview | プラグイン |
| キーの一覧表示 | which-key | プラグイン |

## 2. 起動の流れ

`init.lua` は読み込む順番だけを書いている。

```
init.lua
 ├─ 1. config/options.lua   leader（<Space>）と localleader（,）を決める。オプション
 ├─ 2. config/keymaps.lua   すべてのキーマップ（プラグインと LSP の分も）
 ├─ 3. config/autocmds.lua  オートコマンド
 ├─ 4. config/plugins.lua   vim.pack.add() でプラグインを読み込み、plugins/<name>.lua を順に require
 │     └─ plugins/solarized.lua, telescope.lua, … , codetour.lua
 └─ 5. config/lsp.lua       LSP サーバーを有効にし、つながったときの処理を登録
```

順番の理由は次のとおり。

- **options が最初**: leader を決める前にキーマップを張ると、`<leader>` が既定の `\` で登録されてしまうため
- **keymaps がプラグインより前**: それでも動くように、プラグインの関数はキーを押したときに `require` している（6 章）
- **lsp が最後**: `vim.lsp.config` の既定値を nvim-lspconfig（プラグイン）から読むため

## 3. ファイルの担当

```
init.lua                  読み込み順だけ
nvim-pack-lock.json       プラグインのコミットを固定するロックファイル（vim.pack が書く）
stylua.toml               Lua の整形ルール（スペース 2、列幅 120）
lua/config/
  options.lua             オプションと netrw の設定
  keymaps.lua             キーマップすべて
  autocmds.lua            オートコマンド（グループ名は user_ で始まる）
  plugins.lua             プラグインの一覧、build 処理、setup ファイルの読み込み
  lsp.lua                 診断表示、LSP サーバーの設定と有効化、補完
lua/plugins/<name>.lua    プラグインごとの setup()。キーマップは書かない
lua/custom/codetour/      自作プラグイン（.tours/ のツアーを :TourLoad で読む）
docs/specs/               開発計画（NNNN-<title>.md）
docs/usage/               使い方メモ（<topic>.md）
```

## 4. プラグイン管理（vim.pack）

`lua/config/plugins.lua` が担当する。

| 仕組み | 内容 |
|---|---|
| 追加 | `vim.pack.add({ ... })` に URL を足す。初回起動時に `~/.local/share/nvim/site/pack/core/opt/` へ clone される |
| 固定 | `nvim-pack-lock.json` にコミットが記録される。git で管理しているので、別のマシンでも同じ版になる |
| 依存 | **解決しない**。依存されるプラグイン（plenary）を配列の前に置く |
| build | `PackChanged` autocmd で、インストール・更新のときにだけ実行する（fzf-native の `make`、markdown-preview のバイナリ取得、treesitter の `:TSUpdate`） |
| 設定 | `vim.pack.add()` の後に `require("plugins.<name>")` を並べ、各ファイルで `setup()` を呼ぶ |

遅延読み込みはしない。プラグインが 14 個と少なく、起動時間への影響が小さいため。

## 5. LSP と補完

`lua/config/lsp.lua` が担当する。

**nvim-lspconfig はデータとしてだけ使う。** このプラグインの `lsp/<server>.lua`（cmd・filetypes・root_markers の既定値）を本体の `vim.lsp.config` が自動で読む。`require("lspconfig").xxx.setup()` は使っていない。

| サーバー | 対象 | 中身 |
|---|---|---|
| `ts_ls` | ts / js / vue | プロジェクトの `node_modules/typescript` を使う。`.vue` は `@vue/typescript-plugin` 経由 |
| `vue_ls` | vue | テンプレートと CSS。`<script>` の型は `ts_ls` に転送する |
| `eslint` | js / ts / vue | プロジェクトの eslint を使う |
| `lua_ls` | lua | lazydev が Neovim の API を補う |

Vue ファイルを開いたときの関係:

```
.vue ファイル
 ├─ vue_ls ───── テンプレート・CSS
 │     └─ <script> の型の問い合わせ ──→ ts_ls
 └─ ts_ls ────── @vue/typescript-plugin（brew の vue-language-server 同梱）
                  └─ プロジェクトの node_modules/typescript
```

LSP がバッファにつながると（`LspAttach`）、2 か所で処理が走る。

| 場所 | グループ | やること |
|---|---|---|
| `lsp.lua` | `lsp_attach` | 補完を有効にする（入力中に自動表示）、カーソル下の単語のハイライト |
| `keymaps.lua` | `lsp_keymaps` | `gd` / `gr` などのキーマップを、そのバッファにだけ張る |

**制約**: TypeScript 7 のプロジェクトと、`node_modules` がない場所では `ts_ls` が動かない（tsserver がないため）。TS 7.1 で `tsc --lsp` に移るかを検討する（spec 0001）。

## 6. キーマップ

**`lua/config/keymaps.lua` 1 か所にすべて書く。** 各プラグインの setup ファイルにはキーマップを書かない。

| 決まり | 理由 |
|---|---|
| 標準のキーを上書きするのは `jj` と `H` / `L` だけ | 標準のキー操作をそのまま覚えるため。上書きするときは理由をコメントに書く |
| プラグインの関数は `function() require(...)... end` で包む | keymaps.lua はプラグインより先に読まれるため |
| LSP のキーは `LspAttach` でバッファごとに張る | 全体に張ると、LSP のないファイルで本体の `gd` などを潰すため |
| 接頭辞ごとにグループにする | which-key の表示名を `plugins/which-key.lua` で付けている |

| 接頭辞 | グループ |
|---|---|
| `<leader>c` | code（整形、コードアクション、診断） |
| `<leader>f` | file（パスのコピー） |
| `<leader>g` / `<leader>gh` | git / ハンク |
| `,b` / `,m` / `,t` | バッファ / Markdown / ツアーとターミナル |

## 7. 外部ツール

LSP サーバー・フォーマッター・tree-sitter CLI は **brew で入れる**（`~/dotfiles/Brewfile`）。npm のグローバルインストールと mason は使わない。nodenv で Node のバージョンを切り替えると、npm で入れたコマンドが見つからなくなるため。

| ツール | 使う場所 |
|---|---|
| lua-language-server、typescript-language-server、vue-language-server、vscode-langservers-extracted | `lsp.lua` |
| stylua、shfmt、eslint_d | `plugins/conform.lua` |
| tree-sitter-cli | `plugins/treesitter.lua`（パーサーのビルド） |

## 8. 状態ファイルの置き場所

設定リポジトリの外に置かれ、git には入らない。

| 中身 | 場所 |
|---|---|
| プラグイン本体 | `~/.local/share/nvim/site/pack/core/opt/` |
| treesitter のパーサー | `~/.local/share/nvim/site/parser/` |
| undo の履歴（`undofile`） | `~/.local/state/nvim/undo/` |
| ログ | `~/.local/state/nvim/` |
