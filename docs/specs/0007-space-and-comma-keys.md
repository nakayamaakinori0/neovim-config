# 0007 キーを「よく使う: Space + 1 文字、たまに使う: , + 2 文字」に揃える

- ステータス: 完了
- 作成日: 2026-11-26
- 完了日: 2026-11-26

## 1. 背景

キーの割り当ては、よく使うものを `<leader>`（`<Space>`）+ 1 文字、たまに使うものを `,`（localleader）+ 2 文字にする考えで作ってきた。ただ、この決まりはどこにも書いておらず、LazyVim から持ってきた `<leader>` + 2〜3 文字のキーが残っていた。

| 今のキー | 動作 |
|---|---|
| `<leader>cf` | 整形 |
| `<leader>fy` / `<leader>fY` | ファイルのパスをコピー（相対 / 絶対） |
| `<leader>ghs` / `ghS` / `ghr` / `ghR` | ハンクやファイルをステージする / 元に戻す |
| `<leader>ghb` | その行の blame |
| `<leader>rn` / `ca` / `cd` / `ds` / `ws`（LSP） | 名前の変更 / コードアクション / 診断 / ファイルの記号 / プロジェクトの記号 |

## 2. 方針

どれもたまに使うものなので、`,` + 2 文字に移す。決まりは `CLAUDE.md` と `docs/ARCHITECTURE.md` に書く。

| 今のキー | 移す先 |
|---|---|
| `<leader>cf` | `,cf` |
| `<leader>fy` / `<leader>fY` | `,fy` / `,fY` |
| `<leader>ghs` / `ghS` / `ghr` / `ghR` | `,gs` / `,gS` / `,gr` / `,gR` |
| `<leader>ghb` | `,gb` |
| `<leader>rn` / `ca` / `cd` / `ds` / `ws` | `,rn` / `,ca` / `,cd` / `,ds` / `,ws` |

which-key のグループも `<leader>c` / `f` / `g` / `gh` をやめ、`,c` / `,f` / `,g` にする。

| 案 | 採らなかった理由 |
|---|---|
| よく使うものだけ `<Space>` + 1 文字に縮める | どれもたまにしか使わない |

## 3. 作業

- [x] `keymaps.lua` のキーを移す
- [x] `plugins/which-key.lua` のグループを直す
- [x] `CLAUDE.md` と `docs/ARCHITECTURE.md` に決まりを書く。ARCHITECTURE に残っていた `,m`（Markdown、spec 0006 で消した）も消す
- [x] README と `docs/usage/git.md` のキーを直す
