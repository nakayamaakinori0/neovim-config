-- プラグインは vim.pack で管理する。ロックファイルは nvim-pack-lock.json
-- 更新: :lua vim.pack.update()（確認バッファで :write すると反映）

local gh = function(repo)
  return "https://github.com/" .. repo
end

-- インストール時にも走らせるため、vim.pack.add() より前に登録する
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= "install" and kind ~= "update" then
      return
    end
    if name == "telescope-fzf-native.nvim" then
      vim.system({ "make" }, { cwd = ev.data.path }):wait()
    elseif name == "nvim-treesitter" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

-- 依存の解決はしないので、依存されるもの（plenary）を先に並べる
vim.pack.add({
  gh("maxmx03/solarized.nvim"),
  gh("nvim-lua/plenary.nvim"),
  gh("nvim-telescope/telescope.nvim"),
  gh("nvim-telescope/telescope-fzf-native.nvim"),
  gh("lewis6991/gitsigns.nvim"),
  gh("tpope/vim-fugitive"),
  gh("tpope/vim-surround"),
  gh("neovim/nvim-lspconfig"),
  gh("folke/lazydev.nvim"),
  gh("stevearc/conform.nvim"),
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
})

require("plugins.solarized")
require("plugins.telescope")
require("plugins.gitsigns")
require("plugins.lazydev")
require("plugins.conform")
require("plugins.treesitter")
require("plugins.codetour")
