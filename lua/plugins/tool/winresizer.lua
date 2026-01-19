return {
  "simeji/winresizer",

  keys = {
    -- 既存の<C-w>のウインドウ操作が使えなくなるため注意
    { "<C-w>", "<cmd>WinResizerStartResize<cr>", desc = "Start window resize mode" },
  },

  enabled = true,

  config = function()
    -- ウィンドウサイズ変更の設定
    vim.g.winresizer_enable = 1
    vim.g.winresizer_vert_resize = 5  -- 垂直方向
    vim.g.winresizer_horiz_resize = 5 -- 水平方向
    vim.g.winresizer_finish_with_escape = 1
    -- vim.g.winresizer_start_key = 'Ctrl+w' -- 機能してない

    -- デフォルトキーマップがinitで作成されてしまうので、configで削除する
    vim.api.nvim_del_keymap('n', '<C-e>')
  end,
}
