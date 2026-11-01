# 0002 外したプラグインを戻す（Markdown 表示・プレビュー、which-key）

- ステータス: 完了
- 作成日: 2026-11-02
- 完了日: 2026-11-02

## 1. 背景

spec 0001 で外したプラグインのうち、使ってみて必要だった 3 つを戻す。

| プラグイン | 戻す理由 |
|---|---|
| markview.nvim | spec や使い方メモ（`docs/`）を Markdown で書くようになり、表や見出しを整形して読みたい |
| markdown-preview.nvim | Mermaid の図などをブラウザで確認したい |
| which-key.nvim | 0001 では「キー操作を覚えたら不要」としたが、`<leader>` や `,` に続くキーを一覧で確認したい |

## 2. 方針

| プラグイン | 使い方 |
|---|---|
| markview.nvim | 既定は無効。`,mv` で切り替える（以前と同じ） |
| markdown-preview.nvim | `,mp` でブラウザのプレビューを開閉する（以前と同じ） |
| which-key.nvim | `<leader>` や `,` を押して少し待つと、続くキーの一覧が出る |

- 設定は以前（lazy.nvim 時代）のものを引き継ぐ。キーマップは `keymaps.lua` に書く
- markdown-preview のビルドは、以前の `npx yarn install` をやめて `mkdp#util#install()` にする。Node を同梱したビルド済みバイナリを落とすので、nodenv で Node のバージョンを切り替えても動く。ビルドは `plugins.lua` の `PackChanged` で、インストール時と更新時に行う
- which-key のグループ名は、以前のもの（`<leader>s` や `<leader>x` など、今はないキー）を捨て、今の `keymaps.lua` の接頭辞に合わせて付け直す

## 3. 作業

- [x] `vim.pack.add()` に 3 つを追加する
- [x] `lua/plugins/` に 3 つの設定ファイルを作る
- [x] `,mv` と `,mp` を `keymaps.lua` に足す
- [x] markdown-preview のビルドを `PackChanged` に足す
- [x] 起動して動作を確認する（`,mv` で markview の表示が付く、`,mp` でプレビューのサーバーが起動し HTTP 200 を返す、which-key が読み込まれる）
- [x] README のプラグイン一覧とキーマップ、spec 0001 の仕分け表を更新する
