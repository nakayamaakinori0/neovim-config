require("conform").setup({
  format_on_save = function(bufnr)
    if vim.bo[bufnr].filetype == "python" then
      return
    end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
  -- フォーマッターは brew / npm で入れてからここに追記する
  formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shfmt" },
    fish = { "fish_indent" },
    javascript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    vue = { "eslint_d" },
  },
})
