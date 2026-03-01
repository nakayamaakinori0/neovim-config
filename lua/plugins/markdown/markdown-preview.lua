-- Markdownプレビュー: markdown-preview.nvim
-- ブラウザでリアルタイムプレビュー、Mermaidダイアグラム対応
return {
  "iamcco/markdown-preview.nvim",
  enabled = true,
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    vim.fn.system("cd " .. vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim/app && npm install")
  end,
  keys = {
    { "<localleader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview Toggle" },
  },
  config = function()
    -- 基本設定
    vim.g.mkdp_auto_start = 0 -- 自動開始しない
    vim.g.mkdp_auto_close = 1 -- バッファを閉じたら自動でプレビューも閉じる
    vim.g.mkdp_refresh_slow = 0 -- 高速更新
    vim.g.mkdp_command_for_global = 0 -- グローバルコマンド無効
    vim.g.mkdp_open_to_the_world = 0 -- ローカルのみ
    vim.g.mkdp_browser = "" -- デフォルトブラウザを使用
    vim.g.mkdp_echo_preview_url = 0 -- プレビューURL表示しない
    vim.g.mkdp_browserfunc = "" -- ブラウザ関数指定なし

    -- プレビュー設定
    vim.g.mkdp_preview_options = {
      mkit = {},
      katex = {}, -- 数式サポート
      uml = {}, -- UMLサポート
      maid = { theme = "default" }, -- Mermaidダイアグラム
      disable_sync_scroll = 0, -- 同期スクロール有効
      sync_scroll_type = "middle", -- スクロール位置
      hide_yaml_meta = 1, -- YAMLメタデータを隠す
      sequence_diagrams = {}, -- シーケンス図
      flowchart_diagrams = {}, -- フローチャート
      content_editable = false, -- コンテンツ編集無効
      disable_filename = 0, -- ファイル名表示
      toc = {}, -- 目次
    }

    -- Markdownファイルタイプ
    vim.g.mkdp_filetypes = { "markdown" }

    -- テーマ設定
    vim.g.mkdp_theme = "light"
  end,
}
