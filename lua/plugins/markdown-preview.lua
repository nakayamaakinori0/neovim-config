-- ブラウザで Markdown をプレビューする（Mermaid 対応）。,mp で開閉する
-- 設定はグローバル変数で渡す（このプラグインに setup() はない）
vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1
vim.g.mkdp_refresh_slow = 0
vim.g.mkdp_command_for_global = 0
vim.g.mkdp_open_to_the_world = 0
vim.g.mkdp_echo_preview_url = 0
vim.g.mkdp_filetypes = { "markdown" }
vim.g.mkdp_theme = "light"
vim.g.mkdp_preview_options = {
  maid = { theme = "default" },
  disable_sync_scroll = 1,
  sync_scroll_type = "middle",
  hide_yaml_meta = 1,
  disable_filename = 0,
}
