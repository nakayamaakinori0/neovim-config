# 0001 Neovim リアーキテクチャ計画

- ステータス: 進行中
- 作成日: 2026-11-01

## 1. 背景と方針

- AI がコードの大半を書く時代になり、エディタに求められる役割は「速く書く」から「AI の出力を読んで判断し、局所的に直す」へ移った
- Claude Code などのエージェントはターミナルで動くため、同じ画面で完結するターミナルエディタと相性が良い
- Vim を選ぶ理由は「編集が速いから」ではなく、**AI の出力を読んで判断する場所として軽く、邪魔をしないこと**
- 方針：**Neovim 本体の機能を最大限使い、プラグインは最低限にする**
  - ノートや設定は無印寄りにする
  - 業務コード（TypeScript / Python）のために LSP・整形・検索・git 差分は確保する

## 2. 現状

| 項目 | 内容 |
|---|---|
| Neovim | v0.12.6（2026-11-01 時点で Homebrew 版が既に 0.12 系） |
| プラグイン管理 | lazy.nvim（`plugins/{code,core,git,markdown,tool,ui}` から import） |
| プラグイン数 | 25 個 + 自作 `custom/codetour` |
| 課題 | lazy.nvim の約束事（`opts` / `config` / 遅延読み込み / import）が多く使いにくい |
| 課題 | `lazy-lock.json` が `.gitignore` に入っていて git 管理されていない（確認済み） |
| 課題 | `checker` が通知オフのまま裏で更新チェックしている |

## 3. 目標構成

- Neovim **0.12 系**に上げる
- プラグイン管理は lazy.nvim をやめ、本体の **`vim.pack`** を使う
  - `vim.pack.add()` / `update()` / `del()` の 3 関数のみ
  - ロックファイルを git 管理して再現性を確保する
  - `setup()` は自分で明示的に呼ぶ（暗黙の動きをなくす）
- 新構成は **`NVIM_APPNAME=nvim-min`**（`~/.config/nvim-min/`）として別に作り、今の設定と並行運用してから切り替える

### 目標のプラグイン構成（8 個前後）

| 用途 | プラグイン | 理由 |
|---|---|---|
| ファイル検索・grep | telescope | 業務規模のリポジトリでは必須 |
| git 差分表示 | gitsigns | AI が変えた箇所を行単位で確認するため |
| LSP 設定データ | nvim-lspconfig | 自分で `vim.lsp.config` を書くなら不要 |
| 整形 | conform | prettier / biome などによる整形 |
| Lua 開発の型補完 | lazydev | Lua を書くなら必須 |
| 囲み編集 | vim-surround | 本体に代替がない |
| カラースキーム | tokyonight か solarized のどちらか 1 つ | |
| 自作 | codetour / notes | |

## 4. 現行プラグインの仕分け

### 本体機能で置き換える

| 現行 | 置き換え先 |
|---|---|
| blink-cmp | `vim.lsp.completion` / 0.12 の `'autocomplete'` オプション |
| lualine | 標準のステータスライン |
| bufferline | `:ls` と `:b`、または telescope のバッファ検索 |
| vim-bookmarks | 本体のマーク（`mA` などの大文字マークはファイルをまたげる） |
| winresizer | `<C-w>+` / `<C-w>>` にカウントを付ける |
| nvim-tree | netrw。ファジー検索があればツリーの出番は減る |
| which-key | キー操作を覚えたら不要 |
| mason / mason-lspconfig | 言語サーバーを npm / brew で直接入れる（要検討、未決事項参照） |
| telekasten | 自作の notes プラグイン（別紙「notes プラグイン自作計画」） |

### 外す（重複・任意）

| 現行 | 理由 |
|---|---|
| scrollbar / satellite | **機能が重複**。最低限の方針なら両方外す |
| nvim-web-devicons | nvim-tree などの依存。それらを外せば不要 |
| indent-blankline / vim-colorizer | あれば便利という位置づけ |
| markview / markdown-preview | 必要になったら戻す |
| treesitter | 任意。従来の syntax と LSP の semantic tokens でも実用上困らない |

## 5. 移行手順

### Phase 1：Neovim 本体を 0.12 に上げる

- [ ] 今の設定の `.gitignore` を確認し、`lazy-lock.json` をコミットする（プラグインを戻せるようにするため）
- [x] `which nvim` で入手元を確認する → `/opt/homebrew/bin/nvim`（Homebrew）
- [x] `brew upgrade neovim` を実行し、`nvim --version` で 0.12 系になったことを確認する → 既に v0.12.6
- [x] 今の設定で起動し、`:checkhealth` でエラーがないか確認する → ERROR は lazy.nvim の luarocks 未導入のみ（luarocks を使うプラグインはないので無視）。`vim.deprecated` は OK
- [ ] コンテナ内の Neovim も Dockerfile 側でバージョンを上げる（ホストとずれないように）

### Phase 2：最小構成を新規に作る

- [ ] `~/.config/nvim-min/` を作り、`NVIM_APPNAME=nvim-min nvim` で起動できるようにする
- [ ] `vim.pack` で目標のプラグインを追加し、ロックファイルを git 管理する
- [ ] LSP（TypeScript、必要なら Python）を `vim.lsp.config` / `vim.lsp.enable` で設定する
- [ ] LSP 補完を本体機能で有効にする
- [ ] conform で整形を設定する

### Phase 3：並行運用して検証する

- [ ] 最小構成で 1 週間ほど業務をこなす
- [ ] 本当に足りなかったものだけをメモし、戻すかどうかを判断する

### Phase 4：切り替える

- [ ] 最小構成をメインの `~/.config/nvim/` に移す
- [ ] 旧設定はブランチやタグで残しておく

## 6. 注意点

- **0.12 には破壊的変更がある**：診断（diagnostics）、Treesitter の挙動、API の名前変更など。本体のバイナリは旧設定と共有なので、上げた直後に旧設定が壊れる可能性がある
- **`vim.pack` は実験的機能**：公式ドキュメントに警告がある。個人の設定なら許容範囲だが、仕様変更の可能性を意識しておく
- **`vim.pack` にないもの**：依存関係の解決（読み込み順は `vim.pack.add()` に渡す配列の順で決まる）と遅延読み込み。プラグインが数個なら不要
- **nodenv 環境**：グローバルに入れた言語サーバー（`typescript-language-server` など）は Node のバージョンを切り替えると再インストールが必要になる

## 7. 未決事項

- [ ] カラースキームは tokyonight と solarized のどちらにするか
- [ ] vim-fugitive を残すか（git 操作は Zellij の別ペインの `git` / lazygit で足りるか）
- [ ] mason を外すか（コンテナ内で Neovim を使う運用では mason 経由のほうが楽な場面がある）
- [ ] treesitter を入れるか（TS/TSX のパーサーは本体に同梱されていない）
- [ ] harpoon2 / bookmarks.nvim は本体のマークで足りるか
