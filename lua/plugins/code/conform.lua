return {
  "stevearc/conform.nvim",
  lazy=false,
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true })
      end,
      desc = "Format file",
    },
  },
  opts = {
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
    -- フォーマッターを追加する場合、masonでインストール後ここに追記する
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      fish = { "fish_indent" },
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      vue = { "eslint_d" },
      -- markdown = { "prettier" },
    },
  },
}
