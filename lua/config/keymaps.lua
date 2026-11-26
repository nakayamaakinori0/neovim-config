-- キーマップはできるだけ標準に寄せる。標準にない独自のキーは jj と H / L と Ctrl+h/j/k/l だけ
-- jj は標準のキーを潰さない（挿入モードで j を 2 回続けて打つことはほぼない）
vim.keymap.set("i", "jj", "<Esc>")
-- H / L を残すのは、0 / $ が押しにくい割に、上書きされる標準の H / L（画面の上端 / 下端へ移動）は出番が少ないため
vim.keymap.set("n", "H", "0")
vim.keymap.set("n", "L", "$")
vim.keymap.set("v", "H", "0")
vim.keymap.set("v", "L", "$")
vim.keymap.set("n", "<leader>w", ":w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<cr>", { desc = "Quit window" })
vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")
vim.keymap.set("n", "<leader>r", ":%s///gc<Left><Left><Left><Left>", { desc = "Replace in file" })

-- Ctrl+h/j/k/l でウィンドウ移動。netrw・エディタ・diff の間を頻繁に行き来するので、2 打の Ctrl+w h では遅い
-- 潰れる標準のキーは Ctrl+l（再描画。:redraw! で代用）だけで、Ctrl+h/j/k はノーマルモードでは h/j/Enter と同じ
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- VS Code の中（vscode-neovim）では、ここから下のプラグインのキーは張らず、同じキーに VS Code のコマンドを割り当てる
-- プラグインは plugins.lua で vim-surround しか読んでいない。jj は挿入モードを VS Code が受けるので、settings.json の compositeKeys に書く
if vim.g.vscode then
  local action = function(name)
    return function()
      require("vscode").action(name)
    end
  end

  -- 保存と閉じるは、:w / :q を打つ形にせず VS Code のコマンドを直接呼ぶ。:q を VS Code のコマンドに置き換える仕組み（AlterCommand）に頼らないため
  vim.keymap.set("n", "<leader>w", action("workbench.action.files.save"), { desc = "Save file" })
  vim.keymap.set("n", "<leader>q", action("workbench.action.closeActiveEditor"), { desc = "Close editor" })

  -- Ctrl+w h/j/k/l は vscode-neovim が VS Code のエディタ間の移動に割り当てている。上の noremap だと本体の Ctrl+w を呼んでしまうので remap で張り直す
  vim.keymap.set("n", "<C-h>", "<C-w>h", { remap = true, desc = "Go to left editor" })
  vim.keymap.set("n", "<C-j>", "<C-w>j", { remap = true, desc = "Go to lower editor" })
  vim.keymap.set("n", "<C-k>", "<C-w>k", { remap = true, desc = "Go to upper editor" })
  vim.keymap.set("n", "<C-l>", "<C-w>l", { remap = true, desc = "Go to right editor" })

  -- j / k を、vscode-neovim が VS Code の cursorMove に割り当てている gj / gk に回す。nvim の j / k だと、VS Code で畳んだ範囲に入ると開いてしまうため
  -- 折り返した行では見た目の 1 行ずつ動くようになるが、VS Code の折り返し（editor.wordWrap）は切っているので変わらない
  vim.keymap.set("n", "j", "gj", { remap = true })
  vim.keymap.set("n", "k", "gk", { remap = true })

  vim.keymap.set("n", "<leader>e", action("workbench.action.toggleSidebarVisibility"), { desc = "Toggle side bar" })
  vim.keymap.set("n", "<leader>E", action("workbench.files.action.showActiveFileInExplorer"), { desc = "Reveal file" })
  vim.keymap.set("n", "<leader><space>", action("workbench.action.quickOpen"), { desc = "Find Files" })
  vim.keymap.set("n", "<leader>/", action("workbench.action.findInFiles"), { desc = "Grep" })
  -- VS Code にしかないので、VS Code の中だけ張る
  vim.keymap.set("n", "<leader>l", action("turboConsoleLog.displayLogMessage"), { desc = "Insert console.log" })
  vim.keymap.set("n", "<leader>z", action("workbench.action.toggleZenMode"), { desc = "Toggle Zen mode" })

  vim.keymap.set("n", "<localleader>bx", action("workbench.action.closeActiveEditor"), { desc = "Close editor" })
  vim.keymap.set("n", "<localleader>bt", action("workbench.action.showAllEditors"), { desc = "Editors" })
  vim.keymap.set(
    "n",
    "<localleader>tt",
    action("workbench.action.terminal.toggleTerminal"),
    { desc = "Toggle terminal" }
  )
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
  return
end

-- ファイラーは本体の netrw。左にツリーを開閉する
vim.keymap.set("n", "<leader>e", "<cmd>Lexplore<CR>", { desc = "Toggle file tree" })
-- ディレクトリを渡すと、開いていても閉じずにそこへ移る（閉じるのは <leader>e）
vim.keymap.set("n", "<leader>E", "<cmd>Lexplore %:p:h<CR>", { desc = "File tree (current file dir)" })

-- Esc を押すまで Ctrl+w を効かせ続ける（which-key の Hydra モード）。標準では Ctrl+w は直後の 1 キーにしか効かず、リサイズのたびに押し直すため
vim.keymap.set("n", "<leader>W", function()
  require("which-key").show({ keys = "<c-w>", loop = true })
end, { desc = "Window mode (Esc で抜ける)" })

-- Buffers
vim.keymap.set("n", "<localleader>bx", "<cmd>bdelete<CR>", { desc = "Close current buffer" })

vim.keymap.set("n", "<localleader>tt", ":term<CR>", { desc = "Open terminal" })

vim.keymap.set("n", "<localleader>fy", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  print("Copied to clipboard: " .. path)
end, { desc = "Copy relative file path" })

vim.keymap.set("n", "<localleader>fY", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("Copied to clipboard: " .. path)
end, { desc = "Copy absolute file path" })

-- 以下はプラグインのキーマップ。keymaps.lua はプラグインより先に読まれるので、押したときに require する

-- Telescope
vim.keymap.set("n", "<leader><space>", function()
  require("telescope.builtin").find_files()
end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>/", function()
  require("telescope.builtin").live_grep()
end, { desc = "Grep" })
vim.keymap.set("n", "<leader>G", function()
  local input = vim.fn.input("Glob (カンマ区切り): ")
  require("telescope.builtin").live_grep({ glob_pattern = vim.split(input, ",", { trimempty = true }) })
end, { desc = "Grep (フィルタ付き)" })
vim.keymap.set("n", "<leader>:", function()
  require("telescope.builtin").command_history()
end, { desc = "Command History" })
vim.keymap.set("n", "<localleader>bt", function()
  require("telescope.builtin").buffers()
end, { desc = "Buffers" })

-- Gitsigns（今いるバッファのハンクに対して動く）
vim.keymap.set("n", "]h", function()
  require("gitsigns").nav_hunk("next")
end, { desc = "Next Hunk" })
vim.keymap.set("n", "[h", function()
  require("gitsigns").nav_hunk("prev")
end, { desc = "Prev Hunk" })
vim.keymap.set({ "n", "v" }, "<localleader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
vim.keymap.set({ "n", "v" }, "<localleader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
vim.keymap.set("n", "<localleader>gS", "<cmd>Gitsigns stage_buffer<CR>", { desc = "Stage Buffer" })
vim.keymap.set("n", "<localleader>gR", "<cmd>Gitsigns reset_buffer<CR>", { desc = "Reset Buffer" })
vim.keymap.set("n", "<localleader>gb", function()
  require("gitsigns").blame_line({ full = true })
end, { desc = "Blame Line" })

-- Conform
vim.keymap.set("n", "<localleader>cf", function()
  require("conform").format({ async = true })
end, { desc = "Format file" })

-- Codetour
vim.keymap.set("n", "<localleader>tn", "<cmd>TourNext<cr>", { desc = "Next tour step" })
vim.keymap.set("n", "<localleader>tp", "<cmd>TourPrev<cr>", { desc = "Previous tour step" })

-- LSP（LSP がつながったバッファだけ。全体に張ると LSP のないファイルで本体の gd などを潰すため）
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end
    local telescope = function(name)
      return function()
        require("telescope.builtin")[name]()
      end
    end

    map("gd", telescope("lsp_definitions"), "Goto Definition")
    map("gr", telescope("lsp_references"), "Goto References")
    map("gI", telescope("lsp_implementations"), "Goto Implementation")
    map("gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("<leader>D", telescope("lsp_type_definitions"), "Type Definition")
    map("<localleader>ds", telescope("lsp_document_symbols"), "Document Symbols")
    map("<localleader>ws", telescope("lsp_dynamic_workspace_symbols"), "Workspace Symbols")
    map("<localleader>rn", vim.lsp.buf.rename, "Rename")
    map("<localleader>ca", vim.lsp.buf.code_action, "Code Action")
    map("<localleader>cd", vim.diagnostic.open_float, "Show Diagnostics")
  end,
})
