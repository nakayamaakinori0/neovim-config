-- LSP サーバーは brew で入れる。サーバーごとの既定値（cmd / filetypes / root_markers）は nvim-lspconfig の lsp/*.lua を使う

vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
  severity_sort = true,
})

-- TypeScript は .ts も .vue も ts_ls が扱い、プロジェクトの node_modules の typescript で型チェックする
-- brew の TypeScript 7（tsc --lsp）を使わないのは、7.0 に .vue 用プラグインを読む仕組みがないため（7.1 で移行を検討）
-- @vue/typescript-plugin は vue_ls と同じバージョンでないと動かないので、brew の vue-language-server 同梱のものを使う
local vue_plugin =
  "/opt/homebrew/opt/vue-language-server/libexec/lib/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"

vim.lsp.config("ts_ls", {
  init_options = {
    plugins = {
      { name = "@vue/typescript-plugin", location = vue_plugin, languages = { "vue" } },
    },
  },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      completion = { callSnippet = "Replace" },
    },
  },
})

vim.lsp.enable({ "ts_ls", "vue_ls", "eslint", "lua_ls" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
  callback = function(event)
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
    local builtin = require("telescope.builtin")

    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("gd", builtin.lsp_definitions, "Goto Definition")
    map("gr", builtin.lsp_references, "Goto References")
    map("gI", builtin.lsp_implementations, "Goto Implementation")
    map("gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("<leader>D", builtin.lsp_type_definitions, "Type Definition")
    map("<leader>ds", builtin.lsp_document_symbols, "Document Symbols")
    map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols")
    map("<leader>rn", vim.lsp.buf.rename, "Rename")
    map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
    map("<leader>cd", vim.diagnostic.open_float, "Show Diagnostics")

    -- 補完は本体機能。入力中に自動で候補を出し、<C-y> で確定する
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end

    if client:supports_method("textDocument/documentHighlight") then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})
