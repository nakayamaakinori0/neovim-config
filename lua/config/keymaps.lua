-- キーマップはできるだけ標準に寄せる。標準にない独自のキーは jj と H / L だけ
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

-- ファイラーは本体の netrw。左にツリーを開閉する
vim.keymap.set("n", "<leader>e", "<cmd>Lexplore<CR>", { desc = "Toggle file tree" })

-- Buffers
vim.keymap.set("n", "<localleader>bx", "<cmd>bdelete<CR>", { desc = "Close current buffer" })

vim.keymap.set("n", "<localleader>tt", ":term<CR>", { desc = "Open terminal" })

vim.keymap.set("n", "<leader>fy", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  print("Copied to clipboard: " .. path)
end, { desc = "Copy relative file path" })

vim.keymap.set("n", "<leader>fY", function()
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
vim.keymap.set({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
vim.keymap.set({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
vim.keymap.set("n", "<leader>ghS", "<cmd>Gitsigns stage_buffer<CR>", { desc = "Stage Buffer" })
vim.keymap.set("n", "<leader>ghR", "<cmd>Gitsigns reset_buffer<CR>", { desc = "Reset Buffer" })
vim.keymap.set("n", "<leader>ghp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview Hunk" })
vim.keymap.set("n", "<leader>ghb", function()
  require("gitsigns").blame_line({ full = true })
end, { desc = "Blame Line" })
vim.keymap.set("n", "<leader>ghd", "<cmd>Gitsigns diffthis<CR>", { desc = "Diff This" })
vim.keymap.set("n", "<leader>ghD", function()
  require("gitsigns").diffthis("~")
end, { desc = "Diff This ~" })
vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Hunk" })

-- Fugitive
vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git status" })
vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Git commit" })
vim.keymap.set("n", "<leader>gp", "<cmd>Git push<CR>", { desc = "Git push" })

-- Conform
vim.keymap.set("n", "<leader>cf", function()
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
    map("<leader>ds", telescope("lsp_document_symbols"), "Document Symbols")
    map("<leader>ws", telescope("lsp_dynamic_workspace_symbols"), "Workspace Symbols")
    map("<leader>rn", vim.lsp.buf.rename, "Rename")
    map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
    map("<leader>cd", vim.diagnostic.open_float, "Show Diagnostics")
  end,
})
