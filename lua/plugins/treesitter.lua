-- nvim-treesitter（main ブランチ）はパーサーの入手だけに使い、ハイライトは本体の vim.treesitter で行う
-- パーサーのビルドに tree-sitter CLI が必要（brew install tree-sitter-cli）
local parsers = {
  "bash",
  "c",
  "css",
  "diff",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "lua",
  "luadoc",
  "luap",
  "markdown",
  "markdown_inline",
  "php",
  "python",
  "query",
  "regex",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "vue",
  "yaml",
}

-- 入っているものはスキップされる。非同期なので起動は止まらない
require("nvim-treesitter").install(parsers)

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
  callback = function(ev)
    if vim.b[ev.buf].bigfile then
      return
    end
    -- パーサーがない filetype では失敗するので、従来の syntax のままにする
    if pcall(vim.treesitter.start, ev.buf) then
      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
