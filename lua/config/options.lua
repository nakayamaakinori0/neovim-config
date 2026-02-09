-- Options are automatically loaded before lazy.nvim startup
-- Previously LazyVim default options, now explicitly set

-- General
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Clipboard
vim.opt.clipboard:append("unnamed") -- ヤンクした内容をシステムクリップボードにコピー

-- Disable netrw (use Neo-tree instead)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Basic editing
vim.opt.autoindent = true
vim.opt.autowrite = true
vim.opt.backup = false
vim.opt.conceallevel = 0 -- Markdownの```などを隠さない
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.fillchars = {
  foldopen = "▾",
  foldclose = "▸",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
vim.opt.foldcolumn = "1"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.formatoptions = "jcroqlnt"
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.pumblend = 10
vim.opt.pumheight = 10
vim.opt.relativenumber = false
vim.opt.scrolloff = 4
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.opt.showmode = false
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.spelllang = { "en" }
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200
vim.opt.virtualedit = "block"
vim.opt.wildmode = "longest:full,full"
vim.opt.winminwidth = 5
vim.opt.wrap = true -- 画面幅を超えたら折り返す
vim.opt.linebreak = true -- 単語の途中で折り返さない（見やすくなる）
vim.opt.writebackup = false

-- Disable builtin plugins we don't need
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tohtml = 1
vim.g.loaded_tutor = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

-- Custom options
vim.g.lazyvim_php_lsp = "intelephense"

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- ripgrep settings
vim.opt.grepprg = "rg --vimgrep --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"
--   :grep "検索パターン" src/
--  :grep "検索パターン" **/*.lua
--  :copen で結果を表示
--  :cfdo %s/old/new/gc で一括置換
