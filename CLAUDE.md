# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## コードベースの概要

このリポジトリは独立したNeovim設定です。lazy.nvimプラグインマネージャーを使用して構築されています。

## アーキテクチャ

### 設定の構造
- `init.lua`: エントリーポイント。`config.lazy`を読み込む
- `lua/config/`: LazyVimの基本設定
  - `lazy.lua`: プラグインマネージャーの設定とプラグインの読み込み
  - `options.lua`: Vimのオプション設定（PHP LSPの設定など）
  - `keymaps.lua`: カスタムキーマップ
  - `autocmds.lua`: オートコマンド
- `lua/plugins/`: カスタムプラグイン設定

### プラグイン管理
プラグインは
`lua/plugins/`ディレクトリ内の個別ファイルで管理されています。各ファイルは特定のプラグインまたは機能群を担当しています。

重要: MasonとMason-lspconfigはv1.xに固定されています（v2.0.0の破壊的変更を避けるため）。

### 主要なプラグインファイル
- `core.lua`: コアプラグイン（UI、検索、Git統合など）
- `coding.lua`: コーディング関連（Treesitter、LSP、補完、フォーマット）
- `ui.lua`: UI強化プラグイン（Noice、通知、セッション管理など）
- `telekasten.lua`: Telekasten (Zettelkasten) プラグイン設定
- `avante.lua`: AI支援プラグイン（現在はGemini使用、Claude/DeepSeekも設定済み）
- `conform.lua`: コードフォーマッター設定
- `diffview.lua`: Git diff表示
- `scrollbar.lua`: スクロールバー表示
- `vim-bookmarks.lua`: ブックマーク機能
- `mason-lspconfig.lua`: LSPサーバー管理（自動インストール無効）

## 開発コマンド

### Neovim設定の適用
- 設定変更後: `:source $MYVIMRC` または Neovim を再起動
- プラグイン更新: `:Lazy update`
- プラグイン同期: `:Lazy sync`

### コードフォーマット
- 手動フォーマット: `<leader>cf` (自動フォーマットは無効)
- 対応言語と使用フォーマッター:
  - Lua: `stylua`
  - JavaScript/TypeScript/Vue: `prettier`
  - Shell: `shfmt`
  - Fish: `fish_indent`

## フォーマット設定

### StyLua（Lua用）
- `stylua.toml`で設定
- インデント: スペース2つ
- 列幅: 120文字

### Conform.nvim
- `<leader>cf`でフォーマット実行
- 自動フォーマットは無効化
- 対応言語: Lua, JavaScript/TypeScript, Vue, Shell, Fish

## カスタムキーマップの主要な変更
- `jj`: インサートモードからノーマルモードへ
- `H`/`L`: 行の最初/最後へ移動
- `Tab`/`Shift-Tab`: バッファ間移動
- `<leader>tk`: Telekastenパネル表示
- `<leader>td`: 現在の日付挿入
- `<leader>gd`: Diffviewの切り替え
- `<leader>fp`: 相対ファイルパスをクリップボードにコピー

## LSP設定
- PHP: Intelephenseを使用（`vim.g.lazyvim_php_lsp = "intelephense"`）
- 自動LSPインストール: 無効（`automatic_installation = false`）

## AI支援設定
- Avante.nvim: 現在Gemini（gemini-2.5-flash-preview-04-17）を使用
- 設定ファイル: `lua/plugins/avante.lua`で他のプロバイダー（Claude, DeepSeek）も設定済み

## 注意事項
このNeovim設定はLazyVimからの移行により、独立した設定となっています。LazyVimの機能はすべて明示的に設定されており、LazyVimに依存していません。
