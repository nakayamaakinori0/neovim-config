# 0006 Markdown のプラグイン（markdown-preview.nvim、markview.nvim）を外す

- ステータス: 完了
- 作成日: 2026-11-26
- 完了日: 2026-11-26

## 1. 背景

作業はすべてターミナルで済ませる方針にした。Markdown のプレビューはターミナルの leaf で見る。

spec 0002 で 2 つを戻したが、どちらも leaf で足りる。

| プラグイン | 0002 で戻した理由 | 今いらない理由 |
|---|---|---|
| markdown-preview.nvim | Mermaid の図などをブラウザで確認したい | ブラウザを開くので方針と合わない。leaf も Mermaid の図をターミナルの中で描ける（`leaf --inline` で `graph TD; A-->B` が箱と矢印で出ることを確かめた） |
| markview.nvim | Neovim の中で Markdown を整形して見たい | 書くのは Neovim、見るのは leaf と分けたので、Neovim の中で整形する必要がない |

## 2. 方針

2 つとも外す。Markdown は Neovim で書き、leaf（`watch = true` で保存すると表示が変わる）で見る。

| 案 | 採らなかった理由 |
|---|---|
| 残しておく | 使わない道具が残り、markdown-preview はビルド（Node 同梱バイナリの取得）の保守も要る |

## 3. 作業

- [x] `plugins.lua` から 2 つと markdown-preview のビルド処理を外し、`vim.pack.del` でロックファイルからも消す
- [x] `lua/plugins/markdown-preview.lua` と `lua/plugins/markview.lua` を消す
- [x] `keymaps.lua` から `,mp` と `,mv` を消し、which-key の `,m` のグループも消す
- [x] README と ARCHITECTURE の記述を直す
