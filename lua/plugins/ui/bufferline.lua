return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
  keys = {
    { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
    { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
    { "<localleader>br", "<Cmd>BufferLineMoveNext<CR>", desc = "Move buffer right" },
    { "<localleader>bl", "<Cmd>BufferLineMovePrev<CR>", desc = "Move buffer left" },
    { "<localleader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin buffer" },
    { "<localleader>bx", "<Cmd>bdelete<CR>", desc = "Close current buffer" },
    { "<localleader>bX", "<Cmd>BufferLineCloseOthers<CR>", desc = "Close other buffers" },
    { "<localleader>bP", "<Cmd>BufferLinePick<CR>", desc = "Pick buffer" },
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      show_close_icon = false,
      show_buffer_close_icons = false,
      separator_style = "thin",
      sort_by = "insert_at_end",
      offsets = {
        {
          filetype = "neo-tree",
          text = "Explorer",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
}
