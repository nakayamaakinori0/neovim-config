# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## コードベースの概要

Neovim 0.12 の設定。プラグイン管理は本体の `vim.pack`。方針は「本体機能を最大限使い、プラグインは最低限」（`docs/specs/0001-neovim-rearchitecture.md`）。
構成・プラグイン・キーマップの一覧は `README.md` にある。

## 開発計画（spec）
- 新しい開発は `docs/specs/` に spec を Markdown で追加してから進める
- ファイル名は `NNNN-<kebab-case-title>.md`（4 桁連番）。詳細は `docs/specs/README.md`

## 使い方メモ
- Neovim の使い方メモは `docs/usage/<kebab-case-topic>.md` に話題ごとに書く（番号なし）。追加したら `docs/usage/README.md` の一覧にも足す

## 書き方の決まり
- プラグインを足すときは `lua/config/plugins.lua` の `vim.pack.add()` に追加し、`lua/plugins/<name>.lua` で `setup()` を明示的に呼ぶ
- `vim.pack` は依存を解決しないので、依存されるプラグインを配列の前に置く
- build が要るプラグインは `plugins.lua` の `PackChanged` autocmd に書く
- LSP は `lua/config/lsp.lua` に `vim.lsp.config` / `vim.lsp.enable` で書く
- キーマップはすべて `lua/config/keymaps.lua` に書く。プラグインの関数は押したときに `require` する（keymaps.lua はプラグインより先に読まれるため）。LSP のキーマップは同ファイルの `LspAttach` でバッファごとに張る
- CLI ツール（LSP サーバー・フォーマッター）は brew で入れる。npm のグローバルインストールと mason は使わない

## 開発コマンド
- 設定の反映: `:restart`
- プラグイン更新: `:lua vim.pack.update()`（確認バッファで `:write`）
- 整形: `stylua init.lua lua/`（`stylua.toml`: スペース 2、列幅 120）
- 起動確認: `nvim --headless +qa` でエラーが出ないこと
