# 0003 使われていない設定を消す

- ステータス: 完了
- 作成日: 2026-11-02
- 完了日: 2026-11-02

## 1. 背景

spec 0001 で lazy.nvim の構成から移したとき、LazyVim 由来の設定や外したプラグイン用の設定をそのまま持ってきた。何もしていない設定が残っていると、どれが効いているのかを読み取りにくくなるため、まとめて消す。

## 2. 消すもの

### 何もしていない設定

| 場所 | 設定 | 理由 |
|---|---|---|
| `options.lua` | `autoindent`、`backup`、`conceallevel`、`foldenable`、`inccommand`、`relativenumber`、`spelllang`、`wrap` | Neovim の既定値と同じ（`nvim --clean` と比べて確認） |
| `autocmds.lua` | `wrap_spell` | `wrap` は全体で既に `true` |
| `autocmds.lua` | `json_conceal` | `conceallevel` は全体で既に `0` |

`conceallevel` と `wrap` は、既定値に任せても今と同じ動き（Markdown の記号を隠さない、折り返す）になる。

### 外したプラグイン用の設定

| 場所 | 設定 | 理由 |
|---|---|---|
| `autocmds.lua` | `close_with_q` の対象のうち 9 個 | 今は入っていないプラグイン（plenary のテスト画面、notify、spectre、neotest など）の画面 |
| `options.lua` | `sessionoptions` | セッション管理のプラグイン用 |
| `options.lua` | `foldcolumn`、`foldlevel`、`foldlevelstart`、`fillchars` の fold 用の文字 | `foldmethod` を設定していないので、左端に空の列が増えているだけ |
| `.gitignore` | lazy.nvim 時代の 9 行 | 外したプラグインや使っていないツールのファイル |

### 壊れている・古いファイル

| ファイル | 理由 |
|---|---|
| `Makefile` | 参照している `scripts/run_tests.sh` と `tests/` がない |
| `.akspace/.logs/claude/investigations/2025-08-20_...md` | mason 時代の Vue LSP の調査メモ。spec 0001 の判断と食い違う |
| `.vim-bookmarks`、`lua/plugins/tool/`（git 管理外） | 外した vim-bookmarks のデータと、中身が `.DS_Store` だけのディレクトリ |

### 標準プラグインの無効化

`options.lua` の `vim.g.loaded_gzip` など 7 行を消す。lazy.nvim 時代の起動高速化で効果はごくわずかだった。消すと `.zip` / `.tar.gz` の中身を開く機能と `:Tutor` が使えるようになる。

## 3. 作業

- [x] 上の設定とファイルを消す
- [x] 起動してエラーが出ないこと、`:checkhealth` に新しい問題が出ないことを確認する（ERROR 0 件）
- [x] `.gitignore` を変えた後に、新しく untracked のファイルが出ないことを確認する
- [x] `.md` / `.json` / `.ts` を開いたときの `conceallevel` と `wrap` が変更前と同じことを確認する（変わったのは `foldcolumn` の 1 → 0 だけ）

## 4. 見つけたが今回は扱わないもの

- conform に fish の整形（`fish_indent`）を設定しているが、fish が入っていない。fish を使わないなら消せる
