-- 検索置換: grug-far.nvim
-- プロジェクト全体での検索・置換
return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  keys = {
    {
      "<leader>sr",
      function()
        require("grug-far").open({ transient = true })
      end,
      mode = { "n", "v" },
      desc = "Search and Replace",
    },
  },
  config = true,
}