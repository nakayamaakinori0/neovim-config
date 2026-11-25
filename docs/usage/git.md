# git の差分を読む

AI が書いた変更や過去のコミットを、左右に並べて読む。Neovim 本体の `nvim.difftool` を `git difftool -d` から開く。プラグインは使わない。

差分を見るのは `git difftool -d` に揃える。gitsigns は、変わった行の印と、その場所への移動・元に戻す・blame にだけ使う。

## 見たい範囲を指定して開く

ターミナル（herdr の pane）で打つ。範囲の書き方は `git diff` と同じ。

```sh
git difftool -d HEAD                 # 手元の変更（まだコミットしていないもの）
git difftool -d origin/main          # リモートと手元
git difftool -d <commit>^ <commit>   # 1 つのコミット
git difftool -d main...<branch>      # ブランチ（PR と同じ範囲）
```

新しい nvim が立ち上がり、上に左右の diff（左が変更前）、下に変わったファイルの一覧が出る。一覧の頭の文字は `M` が変更、`A` が追加、`D` が削除。

| キー | 動作 |
|---|---|
| `]q` / `[q` | 次 / 前のファイルへ（一覧の行で `Enter` でもよい） |
| `]c` / `[c` | ファイルの中で次 / 前の変更へ |
| `:qa` | 終わる（元のターミナルに戻る） |

手元の変更を見ているときは、右が実際のファイルなので、そのまま直して `:w` できる。

名前を変えたファイルは「名前を変えた」とは出ず、前の名前が `D`、新しい名前が `A` として別々に並ぶ。

## 使うための設定（~/.gitconfig）

```ini
[diff]
	tool = nvim_difftool
[difftool]
	prompt = false
[difftool "nvim_difftool"]
	cmd = nvim -c \"packadd nvim.difftool\" -d \"$LOCAL\" \"$REMOTE\"
```

`~/.gitconfig` は dotfiles で管理していないので、別の Mac ではこれを書き足す。

## 開いているファイルの変わった行（gitsigns）

| キー | 動作 |
|---|---|
| `]h` / `[h` | 次 / 前の変わった部分へ |
| `,gr` | その部分だけ元に戻す |
| `,gb` | その行の blame |

## ステージ・コミット・rebase など

ターミナルで git コマンドを打つ。

衝突したら、そのファイルを nvim で開いて `/<<<<<<<` で印を探し、手で直す。直したら `git add <file>` して `git rebase --continue`（merge なら `git commit`）。
