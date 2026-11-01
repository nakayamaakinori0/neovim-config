# 全文検索から置換する

プラグインは使わず、本体の quickfix で行う。

## おすすめ: telescope で絞り込んでから置換する

1. `<leader>/`（live_grep）で検索し、結果を目で確認する
2. `<C-q>` で結果を quickfix に送る
3. `:cdo s/foo/bar/gc | update` で置換して保存する

telescope の live_grep は `.gitignore` を守るので、`node_modules` や `dist` は対象にならない。

## `:grep` で検索する

```vim
:grep foo
:copen
:cdo s/foo/bar/gc | update
```

**注意**: 今の `grepprg` は Neovim の既定値 `rg --vimgrep -uu` で、`.gitignore` を無視し隠しファイルも検索する。`node_modules` まで置換されるので、業務リポジトリでは telescope のほうを使う。

## コマンド

| コマンド | 意味 |
|---|---|
| `:cdo {cmd}` | quickfix の各行で `{cmd}` を実行する |
| `:cfdo {cmd}` | quickfix の各ファイルで 1 回ずつ実行する（例: `:cfdo %s/foo/bar/g \| update`） |
| `s/foo/bar/gc` | 置換。`c` を付けると 1 件ずつ確認する（`y` で置換、`n` で飛ばす、`a` で残り全部、`q` で中止） |
| `update` | 変更があれば保存する |
| `:copen` / `:cclose` | quickfix の一覧を開く / 閉じる |
| `:cnext` / `:cprev` | 次 / 前の結果へ移動する |

## 置換を取り消す

ファイルごとに `u` で戻す。複数ファイルをまとめて戻すなら git を使う（`git checkout -- .` または `git restore -p`）。
