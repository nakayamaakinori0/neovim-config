-- telekasten settings
return {
  {
    "renerocksai/telekasten.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      home = vim.fn.expand("~/dev/telekasten"),
      dailies = vim.fn.expand("~/dev/telekasten/daily"),
      weeklies = vim.fn.expand("~/dev/telekasten/weekly"),
      templates = vim.fn.expand("~/dev/telekasten/templates"),
      template_new_note = vim.fn.expand("~/dev/telekasten/templates/default.md"),
      template_new_daily = vim.fn.expand("~/dev/telekasten/templates/daily.md"),
      template_new_weekly = vim.fn.expand("~/dev/telekasten/templates/weekly.md"),
      tag_notation = ":tag:",
      auto_set_filetype = false,
      filetype = "markdown",
    },
  },
}
