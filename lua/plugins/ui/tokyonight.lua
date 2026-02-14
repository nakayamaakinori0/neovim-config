return {
  "folke/tokyonight.nvim",
  lazy = false, -- 起動時に即座に読み込み
  priority = 1000, -- 他のプラグインより先に読み込み
  config = function()
    vim.cmd([[colorscheme tokyonight-moon]])
  end,
}
