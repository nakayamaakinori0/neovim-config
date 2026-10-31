-- Neovim の Lua API を lua_ls に補完させる
require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})
