return {
  "folke/tokyonight.nvim",
  lazy = false, -- 起動時に即座に読み込み
  priority = 1000, -- 他のプラグインより先に読み込み
  opts = {
--   transparent = true, -- 背景を透明にする
    styles = {
--      sidebars = "transparent", -- サイドバーを透明にする
--      floats = "transparent", -- 浮動ウィンドウを透明にする
    },
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd([[colorscheme tokyonight-moon]])
  end,
}
