-- General
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Clipboard
vim.opt.clipboard:append("unnamed") -- ヤンクした内容をシステムクリップボードにコピー

-- Basic editing
vim.opt.autowrite = true
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.fillchars = {
  diff = "╱",
  eob = " ",
}
vim.opt.formatoptions = "jcroqlnt"
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.pumblend = 10
vim.opt.pumheight = 10
vim.opt.scrolloff = 4
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
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
vim.opt.completeopt = { "menuone", "noselect", "popup", "fuzzy" }
vim.opt.winminwidth = 5
vim.opt.linebreak = true -- 単語の途中で折り返さない（見やすくなる）
vim.opt.writebackup = false

-- netrw をツリー表示にし、nvim-tree のように左に幅 30 で開く
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_winsize = -30

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
