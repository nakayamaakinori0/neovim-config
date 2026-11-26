-- VS Code の中（vscode-neovim）では、このファイルだけを読む。画面・検索・git・LSP は VS Code が受け持つ
-- nvim の options / keymaps / autocmds とは共通にしない。VS Code の中で何が効いているかを、このファイルだけ読めば分かるようにするため
-- jj は挿入モードを VS Code が受けるので、ここでは効かない。VS Code の settings.json の vscode-neovim.compositeKeys に書く

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.clipboard:append("unnamed") -- ヤンクした内容をシステムクリップボードにコピー
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.timeoutlen = 300

-- 編集の操作を足すプラグインは vim-surround だけ読む
vim.pack.add({ "https://github.com/tpope/vim-surround" })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("user_highlight_yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local action = function(name)
  return function()
    require("vscode").action(name)
  end
end

-- H / L は nvim の keymaps.lua と同じ。0 / $ が押しにくい割に、上書きされる標準の H / L は出番が少ないため
vim.keymap.set("n", "H", "0")
vim.keymap.set("n", "L", "$")
vim.keymap.set("v", "H", "0")
vim.keymap.set("v", "L", "$")
vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")
vim.keymap.set("n", "<leader>r", ":%s///gc<Left><Left><Left><Left>", { desc = "Replace in file" })

-- j / k を、vscode-neovim が VS Code の cursorMove に割り当てている gj / gk に回す。nvim の j / k だと、VS Code で畳んだ範囲に入ると開いてしまうため
-- 折り返した行では見た目の 1 行ずつ動くようになるが、VS Code の折り返し（editor.wordWrap）は切っているので変わらない
vim.keymap.set("n", "j", "gj", { remap = true })
vim.keymap.set("n", "k", "gk", { remap = true })

-- Ctrl+w h/j/k/l は vscode-neovim が VS Code のエディタ間の移動に割り当てているので、remap で呼ぶ
vim.keymap.set("n", "<C-h>", "<C-w>h", { remap = true, desc = "Go to left editor" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { remap = true, desc = "Go to lower editor" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { remap = true, desc = "Go to upper editor" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { remap = true, desc = "Go to right editor" })

-- 保存と閉じるは、:w / :q を打つ形にせず VS Code のコマンドを直接呼ぶ。:q を VS Code のコマンドに置き換える仕組み（AlterCommand）に頼らないため
vim.keymap.set("n", "<leader>w", action("workbench.action.files.save"), { desc = "Save file" })
vim.keymap.set("n", "<leader>q", action("workbench.action.closeActiveEditor"), { desc = "Close editor" })

vim.keymap.set("n", "<leader>e", action("workbench.action.toggleSidebarVisibility"), { desc = "Toggle side bar" })
vim.keymap.set("n", "<leader>E", action("workbench.files.action.showActiveFileInExplorer"), { desc = "Reveal file" })
vim.keymap.set("n", "<leader><space>", action("workbench.action.quickOpen"), { desc = "Find Files" })
vim.keymap.set("n", "<leader>/", action("workbench.action.findInFiles"), { desc = "Grep" })
vim.keymap.set("n", "<leader>l", action("turboConsoleLog.displayLogMessage"), { desc = "Insert console.log" })
vim.keymap.set("n", "<leader>z", action("workbench.action.toggleZenMode"), { desc = "Toggle Zen mode" })

vim.keymap.set("n", "<localleader>bx", action("workbench.action.closeActiveEditor"), { desc = "Close editor" })
vim.keymap.set("n", "<localleader>bt", action("workbench.action.showAllEditors"), { desc = "Editors" })
vim.keymap.set("n", "<localleader>tt", action("workbench.action.terminal.toggleTerminal"), { desc = "Toggle terminal" })
vim.keymap.set("n", "<localleader>fy", action("copyRelativeFilePath"), { desc = "Copy relative file path" })
vim.keymap.set("n", "<localleader>fY", action("copyFilePath"), { desc = "Copy absolute file path" })

vim.keymap.set("n", "]h", action("workbench.action.editor.nextChange"), { desc = "Next Hunk" })
vim.keymap.set("n", "[h", action("workbench.action.editor.previousChange"), { desc = "Prev Hunk" })
vim.keymap.set({ "n", "v" }, "<localleader>gs", action("git.stageSelectedRanges"), { desc = "Stage Hunk" })
vim.keymap.set({ "n", "v" }, "<localleader>gr", action("git.revertSelectedRanges"), { desc = "Reset Hunk" })
vim.keymap.set("n", "<localleader>gS", action("git.stage"), { desc = "Stage Buffer" })
vim.keymap.set("n", "<localleader>gR", action("git.clean"), { desc = "Reset Buffer" })

vim.keymap.set("n", "<localleader>cf", action("editor.action.formatDocument"), { desc = "Format file" })
vim.keymap.set("n", "<localleader>tn", action("codetour.nextTourStep"), { desc = "Next tour step" })
vim.keymap.set("n", "<localleader>tp", action("codetour.previousTourStep"), { desc = "Previous tour step" })

-- LSP。gd と K は vscode-neovim の既定で VS Code の定義へ移動・ホバーになっている
-- gD は既定だと定義のピーク表示なので、nvim と同じ宣言へ移動に揃える
vim.keymap.set("n", "gr", action("editor.action.goToReferences"), { desc = "Goto References" })
vim.keymap.set("n", "gI", action("editor.action.goToImplementation"), { desc = "Goto Implementation" })
vim.keymap.set("n", "gD", action("editor.action.revealDeclaration"), { desc = "Goto Declaration" })
vim.keymap.set("n", "<leader>D", action("editor.action.goToTypeDefinition"), { desc = "Type Definition" })
vim.keymap.set("n", "<localleader>ds", action("workbench.action.gotoSymbol"), { desc = "Document Symbols" })
vim.keymap.set("n", "<localleader>ws", action("workbench.action.showAllSymbols"), { desc = "Workspace Symbols" })
vim.keymap.set("n", "<localleader>rn", action("editor.action.rename"), { desc = "Rename" })
vim.keymap.set("n", "<localleader>ca", action("editor.action.quickFix"), { desc = "Code Action" })
vim.keymap.set("n", "<localleader>cd", action("editor.action.showHover"), { desc = "Show Diagnostics" })
