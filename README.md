# 🚀 My Neovim Configuration

**LazyVimから完全独立した、テスト駆動開発対応のNeovim設定**

---

## 📋 目次

1. [概要](#-概要)
2. [特徴](#-特徴)
3. [セットアップ](#-セットアップ)
4. [使い方](#-使い方)
5. [カスタマイズ](#-カスタマイズ)
6. [テスト](#-テスト)
7. [プラグイン一覧](#-プラグイン一覧)
8. [キーマップ](#-キーマップ)
9. [トラブルシューティング](#-トラブルシューティング)
10. [貢献・質問](#-貢献質問)

---

## 🎯 概要

この設定は、以下のような人のために作られました：

- **LazyVimを使っていたけど、独立した設定にしたい**
- **自分好みにカスタマイズしたいけど、安全にやりたい**
- **設定を変更する度に壊れるのが怖い**
- **テスト駆動開発でNeovim設定を管理したい**

### 🏗️ アーキテクチャ

```
~/.config/nvim/
├── init.lua                 # エントリーポイント
├── lua/
│   ├── config/             # 基本設定
│   │   ├── options.lua     # Vim オプション
│   │   ├── keymaps.lua     # キーマップ
│   │   ├── autocmds.lua    # オートコマンド
│   │   └── lazy.lua        # プラグイン管理
│   └── plugins/            # プラグイン設定
│       ├── core.lua        # コアプラグイン
│       ├── coding.lua      # コーディング関連
│       ├── ui.lua          # UI強化
│       ├── avante.lua      # AI支援
│       ├── conform.lua     # フォーマッター
│       ├── diffview.lua    # Git diff
│       ├── telekasten.lua  # ノート管理
│       └── ...
├── tests/                  # テスト関連
│   ├── test_minimal.lua    # 高速テスト
│   ├── test_config.lua     # 全体テスト
│   └── README.md           # テスト説明
├── scripts/                # 実行スクリプト
│   └── run_tests.sh        # テスト実行
├── Makefile               # 便利コマンド
├── TEST_GUIDE.md          # テストガイド
├── TEST_CHEATSHEET.md     # クイックリファレンス
└── README.md              # このファイル
```

---

## ✨ 特徴

### 🎯 **完全独立**
- **LazyVimからの脱却完了** - もうLazyVimに依存しません
- **透明性** - すべての設定が明示的で理解しやすい
- **カスタマイズ性** - 自分好みに変更しやすい

### 🧪 **テスト駆動開発対応**
- **自動テスト** - 設定の正常性を自動チェック
- **継続的品質保証** - 変更による破綻を即座に検出
- **安心の設定変更** - テストがあるから怖くない

### 🚀 **高機能**
- **AI支援** - Avante.nvim (Gemini/Claude/DeepSeek)
- **LSP完備** - 言語サーバーサポート
- **Git統合** - Diffview, Gitsigns
- **ノート管理** - Telekasten (Zettelkasten)
- **検索強化** - Telescope
- **UI美化** - 現代的なインターフェース

### 💡 **初心者フレンドリー**
- **詳細ドキュメント** - 設定の意味を理解できる
- **段階的学習** - 少しずつカスタマイズ可能
- **トラブル対応** - 問題解決ガイド完備

---

## 📦 セットアップ

### 📋 前提条件

以下のソフトウェアが必要です：

```bash
# 必須
- Neovim >= 0.9.0
- Git
- Node.js (LSP用)

# 推奨
- ripgrep (rg) - 高速検索
- fd - ファイル検索
- make - テスト実行用
```

### 🔧 インストール手順

#### 1️⃣ **既存設定のバックアップ**

```bash
# 既存のNeovim設定をバックアップ
mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d)
mv ~/.local/share/nvim ~/.local/share/nvim.backup.$(date +%Y%m%d)
```

#### 2️⃣ **この設定をクローン**

```bash
# この設定をダウンロード
git clone <あなたのリポジトリURL> ~/.config/nvim
cd ~/.config/nvim
```

#### 3️⃣ **初回セットアップ**

```bash
# Neovimを起動（プラグインが自動インストールされる）
nvim

# プラグインの同期（Neovim内で実行）
:Lazy sync
```

#### 4️⃣ **テスト実行**

```bash
# 設定が正しく動作するかテスト
make test-minimal

# 全機能テスト
make test
```

#### 5️⃣ **完了！**

```
🎉 セットアップ完了！
✅ 基本機能が利用可能
✅ テストが通る
✅ プラグインが正常動作
```

### 🛠️ 必要ソフトウェアの個別インストール

#### **macOS**

```bash
# Homebrewを使用
brew install neovim git node ripgrep fd make

# または公式インストーラー
# https://neovim.io/
```

#### **Ubuntu/Debian**

```bash
# APTを使用
sudo apt update
sudo apt install neovim git nodejs npm ripgrep fd-find make

# Neovimが古い場合はSnap版
sudo snap install nvim --classic
```

#### **Windows**

```bash
# WSL2 + Ubuntu推奨
# または Scoop
scoop install neovim git nodejs ripgrep fd make
```

---

## 🎮 使い方

### 🚀 基本操作

#### **Neovimの起動**

```bash
# 通常起動
nvim

# ファイルを指定して起動
nvim myfile.txt

# フォルダを指定して起動
nvim .
```

#### **重要なキーマップ**

| キー | 機能 | 説明 |
|------|------|------|
| `<Space>` | リーダーキー | すべてのカスタムコマンドの起点 |
| `<C-h/j/k/l>` | ウィンドウ移動 | 左/下/上/右のウィンドウに移動 |
| `jj` | ノーマルモード | インサートモードから素早く脱出 |
| `H` / `L` | 行の端 | 行の最初/最後に移動 |

#### **ファイル操作**

| キー | 機能 |
|------|------|
| `<leader>ff` | ファイル検索 |
| `<leader>fg` | 文字列検索 |
| `<leader>fb` | バッファ一覧 |
| `<leader>fr` | 最近のファイル |
| `<leader>e` | ファイルエクスプローラー |

#### **Git操作**

| キー | 機能 |
|------|------|
| `<leader>gd` | Diffview表示/非表示 |
| `<leader>gs` | Git status |
| `<leader>gc` | Git commits |
| `]h` / `[h` | 次/前の変更箇所 |

### 🤖 AI支援機能

この設定には**Avante.nvim**が含まれており、AI支援でコーディングできます：

#### **使用可能なAI**
- **Gemini** (現在のデフォルト)
- **Claude** 
- **DeepSeek**

#### **使い方**
1. ファイルを開く
2. AI に質問したいコードを選択
3. コマンドパレットからAvante機能を実行

### 📝 ノート管理 (Telekasten)

Zettelkasten方式でノートを管理できます：

| キー | 機能 |
|------|------|
| `<leader>tk` | Telekastenパネル |
| `<leader>td` | 今日の日付挿入 |

### 🎨 UI機能

- **Which-key** - キーマップのヘルプ表示
- **Bufferline** - タブ風バッファ表示
- **Lualine** - 美しいステータスライン
- **Dashboard** - 起動画面
- **Noice** - モダンなメッセージ表示

---

## 🔧 カスタマイズ

### 📝 設定ファイルの編集

#### **基本設定の変更**

```lua
-- lua/config/options.lua
vim.opt.number = true          -- 行番号表示
vim.opt.relativenumber = true  -- 相対行番号
vim.opt.tabstop = 2           -- タブ幅
vim.opt.expandtab = true      -- タブをスペースに
```

#### **キーマップの追加**

```lua
-- lua/config/keymaps.lua
vim.keymap.set("n", "<leader>hello", function()
  print("Hello, World!")
end, { desc = "挨拶する" })
```

#### **新しいプラグインの追加**

```lua
-- lua/plugins/my_plugin.lua
return {
  "author/plugin-name",
  config = function()
    require("plugin-name").setup({
      -- 設定をここに
    })
  end,
}
```

### 🎯 よくあるカスタマイズ

#### **テーマの変更**

```lua
-- lua/plugins/core.lua
{
  "folke/tokyonight.nvim",
  -- ↓ を他のテーマに変更
  -- "catppuccin/nvim",
  -- "EdenEast/nightfox.nvim",
}
```

#### **フォントサイズの調整**

```lua
-- lua/config/options.lua
if vim.g.neovide then
  vim.g.neovide_scale_factor = 1.2  -- Neovide使用時
end
```

#### **AI プロバイダーの変更**

```lua
-- lua/plugins/avante.lua
provider = "claude",  -- "gemini" から "claude" に変更
```

### 🧪 カスタマイズ時のテスト

設定を変更した後は必ずテストを実行：

```bash
# 高速テスト
make test-minimal

# 問題があれば詳細テスト
make test

# 新機能のテストを追加
echo 'assert_keymap_exists("n", "<leader>hello", "挨拶キーマップ")' >> tests/test_custom.lua
```

---

## 🧪 テスト

### 🎯 テストの重要性

この設定の最大の特徴は**テスト駆動開発**への対応です：

- **安心の変更** - テストがあるから設定変更が怖くない
- **品質保証** - 常に動作する設定を維持
- **迅速な問題発見** - 何が壊れたかすぐわかる

### 🚀 テストの実行

#### **日常的なテスト**

```bash
# 毎日実行（3秒で完了）
make test-minimal
```

#### **変更後のテスト**

```bash
# 設定変更後は必ず実行
make test
```

#### **インタラクティブテスト**

```bash
# キーマップを実際に試す
make test-keymap

# 設定の健康診断
make test-health
```

### 📝 テストの書き方

新機能を追加する時は、テスト駆動で：

#### **1. テストを先に書く**

```lua
-- tests/test_my_feature.lua
print("🧪 新機能をテスト...")
local mapping = vim.fn.maparg("<leader>foo", "n")
assert_true(mapping ~= "", "新しいキーマップがない")
print("✅ テスト完了")
```

#### **2. テストを実行（失敗を確認）**

```bash
nvim --headless -l tests/test_my_feature.lua
# → エラーが出ることを確認
```

#### **3. 機能を実装**

```lua
-- lua/config/keymaps.lua
vim.keymap.set("n", "<leader>foo", "<cmd>echo 'foo'<cr>")
```

#### **4. テストを再実行（成功を確認）**

```bash
nvim --headless -l tests/test_my_feature.lua
# → 成功することを確認
```

### 📚 詳細なテストガイド

詳しくは以下のドキュメントを参照：

- **[TEST_GUIDE.md](TEST_GUIDE.md)** - 詳細なテストガイド
- **[TEST_CHEATSHEET.md](TEST_CHEATSHEET.md)** - クイックリファレンス
- **[tests/README.md](tests/README.md)** - テスト技術詳細

---

## 🔌 プラグイン一覧

### 🏗️ コアプラグイン

| プラグイン | 用途 | 設定ファイル |
|-----------|------|-------------|
| **lazy.nvim** | プラグイン管理 | `lua/config/lazy.lua` |
| **tokyonight.nvim** | カラーテーマ | `lua/plugins/core.lua` |
| **telescope.nvim** | ファジーファインダー | `lua/plugins/core.lua` |
| **neo-tree.nvim** | ファイルエクスプローラー | `lua/plugins/core.lua` |
| **which-key.nvim** | キーマップヘルプ | `lua/plugins/core.lua` |

### 💻 コーディング支援

| プラグイン | 用途 | 設定ファイル |
|-----------|------|-------------|
| **nvim-lspconfig** | LSP設定 | `lua/plugins/coding.lua` |
| **blink.cmp** | 自動補完 | `lua/plugins/coding.lua` |
| **nvim-treesitter** | シンタックスハイライト | `lua/plugins/coding.lua` |
| **conform.nvim** | フォーマッター | `lua/plugins/conform.lua` |
| **nvim-lint** | リンター | `lua/plugins/coding.lua` |

### 🎨 UI強化

| プラグイン | 用途 | 設定ファイル |
|-----------|------|-------------|
| **lualine.nvim** | ステータスライン | `lua/plugins/core.lua` |
| **bufferline.nvim** | バッファライン | `lua/plugins/core.lua` |
| **noice.nvim** | UI現代化 | `lua/plugins/ui.lua` |
| **dashboard-nvim** | スタート画面 | `lua/plugins/ui.lua` |
| **nvim-notify** | 通知システム | `lua/plugins/ui.lua` |

### 🤖 AI・特殊機能

| プラグイン | 用途 | 設定ファイル |
|-----------|------|-------------|
| **avante.nvim** | AI支援 | `lua/plugins/avante.lua` |
| **telekasten.nvim** | ノート管理 | `lua/plugins/telekasten.lua` |
| **diffview.nvim** | Git diff表示 | `lua/plugins/diffview.lua` |
| **gitsigns.nvim** | Git統合 | `lua/plugins/core.lua` |
| **vim-bookmarks** | ブックマーク | `lua/plugins/vim-bookmarks.lua` |

### 🛠️ 開発ツール

| プラグイン | 用途 | 設定ファイル |
|-----------|------|-------------|
| **mason.nvim** | LSP/DAP/ツール管理 | `lua/plugins/mason.lua` |
| **trouble.nvim** | 診断表示 | `lua/plugins/core.lua` |
| **todo-comments.nvim** | TODO強調 | `lua/plugins/core.lua` |
| **persistence.nvim** | セッション管理 | `lua/plugins/ui.lua` |

---

## ⌨️ キーマップ

### 🎯 基本操作

#### **モード切り替え**

| キー | モード | 機能 |
|------|-------|------|
| `jj` | Insert → Normal | 素早くノーマルモードに |
| `<Esc><Esc>` | Terminal → Normal | ターミナルモードから脱出 |

#### **移動**

| キー | 機能 |
|------|------|
| `H` | 行の最初 (0) |
| `L` | 行の最後 ($) |
| `<C-h/j/k/l>` | ウィンドウ移動 |
| `<Tab>` / `<S-Tab>` | バッファ移動 |

#### **編集**

| キー | 機能 |
|------|------|
| `<leader>o` | 下に新行（ノーマルモード維持） |
| `<leader>O` | 上に新行（ノーマルモード維持） |
| `<C-s>` | ファイル保存 |

### 🔍 検索・ファイル操作

#### **Telescope（ファジーファインダー）**

| キー | 機能 |
|------|------|
| `<leader><space>` | ファイル検索 |
| `<leader>/` | 文字列検索 |
| `<leader>ff` | ファイル検索 |
| `<leader>fg` | 文字列検索 |
| `<leader>fb` | バッファ一覧 |
| `<leader>fr` | 最近のファイル |
| `<leader>fh` | ヘルプ検索 |
| `<leader>fc` | コマンド履歴 |

#### **ファイルエクスプローラー**
| キー | 機能 |
|------|------|
| `<leader>e` | Neo-tree表示 |
| `<leader>fe` | Neo-tree表示（cwd） |
| `<leader>ge` | Git エクスプローラー |
| `<leader>be` | バッファエクスプローラー |

### 🔧 開発機能

#### **LSP（言語サーバー）**
| キー | 機能 |
|------|------|
| `gd` | 定義へジャンプ |
| `gr` | 参照一覧 |
| `gi` | 実装へジャンプ |
| `K` | ホバードキュメント |
| `<leader>rn` | リネーム |
| `<leader>ca` | コードアクション |
| `[d` / `]d` | 診断メッセージ移動 |

#### **フォーマット・リント**
| キー | 機能 |
|------|------|
| `<leader>cf` | フォーマット実行 |

### 📋 Git操作

| キー | 機能 |
|------|------|
| `<leader>gd` | Diffview 表示/非表示 |
| `<leader>gs` | Git status |
| `<leader>gc` | Git commits |
| `<leader>gb` | Git blame |
| `]h` / `[h` | 次/前の変更箇所 |
| `<leader>ghs` | 変更箇所をステージ |
| `<leader>ghr` | 変更箇所をリセット |

### 🎨 UI・ウィンドウ操作

#### **ウィンドウ管理**
| キー | 機能 |
|------|------|
| `<leader>w-` | 水平分割 |
| `<leader>w\|` | 垂直分割 |
| `<leader>wd` | ウィンドウ閉じる |
| `<C-Up/Down/Left/Right>` | ウィンドウサイズ変更 |

#### **バッファ・タブ操作**
| キー | 機能 |
|------|------|
| `<S-h>` / `<S-l>` | バッファ移動 |
| `<leader>bb` | 前のバッファに切り替え |
| `<leader><tab><tab>` | 新タブ |
| `<leader><tab>d` | タブを閉じる |

### 🤖 AI・特殊機能

#### **Telekasten（ノート）**
| キー | 機能 |
|------|------|
| `<leader>tk` | Telekastenパネル |
| `<leader>td` | 現在日付挿入 |

#### **その他**
| キー | 機能 |
|------|------|
| `<leader>fp` | 相対パスをクリップボードにコピー |
| `<leader>l` | Lazy（プラグイン管理）画面 |
| `<leader>qq` | 全て終了 |

### 🔧 診断・トラブル

| キー | 機能 |
|------|------|
| `<leader>xx` | 診断一覧（現在ファイル） |
| `<leader>xX` | 診断一覧（全体） |
| `<leader>xl` | Location List |
| `<leader>xq` | Quickfix List |

---

## 🆘 トラブルシューティング

### 🔧 よくある問題

#### **❓ プラグインが読み込まれない**

**症状:** 機能が使えない、エラーが出る

**解決法:**
```bash
# 1. プラグインを同期
nvim -c "Lazy sync" -c "qa"

# 2. キャッシュをクリア
rm -rf ~/.local/share/nvim

# 3. 再度同期
nvim -c "Lazy sync" -c "qa"
```

#### **❓ キーマップが効かない**

**症状:** `<C-h>`などが動作しない

**解決法:**
```bash
# 1. テストで確認
make test-minimal

# 2. キーマップを確認
nvim --headless -c "verbose map <C-h>" -c "qa"

# 3. 設定を再読み込み
nvim -c "source $MYVIMRC" -c "qa"
```

#### **❓ LSPが動作しない**

**症状:** 補完や診断が出ない

**解決法:**
```bash
# 1. LSPサーバーがインストールされているか確認
nvim -c "Mason" -c "qa"

# 2. 健康診断
nvim -c "checkhealth lsp" -c "qa"

# 3. 必要に応じて言語サーバーをインストール
nvim -c "MasonInstall lua-language-server" -c "qa"
```

#### **❓ AI機能（Avante）が動作しない**

**症状:** AI支援が使えない

**解決法:**
```bash
# 1. 健康診断
nvim -c "checkhealth avante" -c "qa"

# 2. API設定を確認
# lua/plugins/avante.lua でAPIキーが設定されているか確認
```

### 🩺 診断ツール

#### **健康診断**
```bash
# 全体の健康診断
nvim -c "checkhealth" -c "qa"

# 特定項目の診断
nvim -c "checkhealth telescope" -c "qa"
nvim -c "checkhealth lsp" -c "qa"
nvim -c "checkhealth treesitter" -c "qa"
```

#### **テストによる診断**
```bash
# 設定の健康状態をチェック
make test-health

# 詳細なテスト
make test

# 問題の詳細分析
nvim -V1 --headless -l tests/test_minimal.lua
```

### 🔍 ログ・デバッグ

#### **詳細ログ出力**
```bash
# Neovimを詳細ログ付きで起動
nvim -V9nvim.log

# ログファイルを確認
tail -f nvim.log
```

#### **プラグインデバッグ**
```bash
# Lazy.nvimのログ確認
nvim -c "Lazy log" -c "qa"

# プラグインの状態確認
nvim -c "Lazy" -c "qa"
```

### 📞 助けを求める

問題が解決しない場合、以下の情報を含めて質問してください：

#### **システム情報の収集**
```bash
# システム情報を収集
echo "=== System Information ==="
uname -a
nvim --version
which nvim

echo "=== Neovim Configuration ==="
ls -la ~/.config/nvim/

echo "=== Test Results ==="
make test-minimal

echo "=== Error Logs ==="
nvim -V1 --headless -c "qa" 2>&1
```

#### **設定の状態確認**
```bash
# Git状態
cd ~/.config/nvim
git status
git log --oneline -10

# プラグイン状態
nvim --headless -c "Lazy status" -c "qa"
```

### 🔄 設定のリセット

#### **完全リセット**
```bash
# 1. 設定をバックアップ
mv ~/.config/nvim ~/.config/nvim.broken.$(date +%Y%m%d)
mv ~/.local/share/nvim ~/.local/share/nvim.broken.$(date +%Y%m%d)

# 2. 設定を再クローン
git clone <リポジトリURL> ~/.config/nvim

# 3. プラグインを再インストール
nvim -c "Lazy sync" -c "qa"
```

#### **段階的復旧**
```bash
# 1. 最小構成でテスト
nvim --clean

# 2. 基本設定のみ読み込み
nvim -u ~/.config/nvim/lua/config/options.lua

# 3. プラグインなしで起動
nvim --noplugin
```

---

## 🤝 貢献・質問

### 💡 改善提案

この設定をより良くするための提案は大歓迎です！

#### **Issue作成**
- バグ報告
- 機能リクエスト  
- ドキュメント改善

#### **Pull Request**
- 新機能の追加
- バグ修正
- テストの追加
- ドキュメント更新

### 📚 学習リソース

#### **Neovim関連**
- [Neovim公式ドキュメント](https://neovim.io/doc/)
- [Lua in Neovim](https://github.com/nanotee/nvim-lua-guide)
- [awesome-neovim](https://github.com/rockerBOO/awesome-neovim)

#### **このプロジェクト関連**
- [TEST_GUIDE.md](TEST_GUIDE.md) - テスト駆動開発ガイド
- [TEST_CHEATSHEET.md](TEST_CHEATSHEET.md) - クイックリファレンス
- [tests/README.md](tests/README.md) - テスト技術詳細

### 🗣️ コミュニティ

#### **質問・議論**
- GitHub Issues - バグ報告・機能要望
- GitHub Discussions - 一般的な質問・議論

#### **フィードバック**
あなたの体験を聞かせてください：
- 使いやすかった機能
- 困った点
- 改善してほしい機能
- 追加してほしいプラグイン

---

## 📄 ライセンス

このプロジェクトはMITライセンスの下で公開されています。

---

## 🙏 謝辞

この設定は以下のプロジェクトにインスパイアされています：

- **[LazyVim](https://www.lazyvim.org/)** - 設計思想とプラグイン選定
- **[AstroNvim](https://astronvim.com/)** - 設定構造
- **[LunarVim](https://www.lunarvim.org/)** - UI設計

そして、素晴らしいプラグインを作成してくださった全ての開発者の皆様に感謝します。

---

## 📈 更新履歴

### v2.0.0 (Latest)
- ✅ LazyVimからの完全独立
- ✅ テスト駆動開発対応
- ✅ 包括的ドキュメント
- ✅ AI支援機能統合

### v1.0.0 
- ✅ LazyVimベースの初期設定

---

**🎉 Happy Coding with Neovim! 🚀**

*何か質問があれば、遠慮なくIssueを作成してください！*
