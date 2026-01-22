local M = {}
local types = require("custom.codetour.types")

local state = {
  steps = {},
  current = 0,
  tour_title = "",
}

local function jump_to_step(index)
  local step = state.steps[index]
  if not step then
    return
  end

  vim.cmd("edit " .. step.file)
  vim.api.nvim_win_set_cursor(0, { step.line, 0 })

  local step_display = types.get_step_title(step)
  vim.notify(string.format("[%d/%d] %s", index, #state.steps, step_display))
end

function M.next()
  if #state.steps == 0 then
    vim.notify("No tour loaded")
    return
  end

  state.current = state.current % #state.steps + 1
  jump_to_step(state.current)
end

function M.prev()
  if #state.steps == 0 then
    vim.notify("No tour loaded")
    return
  end

  state.current = state.current - 1
  if state.current < 1 then
    state.current = #state.steps
  end
  jump_to_step(state.current)
end

-- ツアーファイルを検索（.tour優先、.jsonも対応）
local function find_tour_file(name)
  local base_dir = types.TOUR_DIR .. "/"

  -- 拡張子なしで指定された場合
  if not name:match("%.[^.]+$") then
    -- 優先順に拡張子を検索
    for _, ext in ipairs(types.EXTENSIONS) do
      local file_path = base_dir .. name .. ext
      if vim.fn.filereadable(file_path) == 1 then
        return file_path
      end
    end
    return nil
  end

  -- 拡張子付きで指定された場合
  local file_path = base_dir .. name
  if vim.fn.filereadable(file_path) == 1 then
    return file_path
  end

  return nil
end

function M.load(name)
  local tour_file = find_tour_file(name)

  if not tour_file then
    vim.notify("Tour not found: " .. name, vim.log.levels.ERROR)
    return
  end

  local file = io.open(tour_file, "r")
  if not file then
    vim.notify("Cannot open tour file: " .. tour_file, vim.log.levels.ERROR)
    return
  end

  local content = file:read("*all")
  file:close()

  local ok, data = pcall(vim.json.decode, content)
  if ok and data.steps then
    state.steps = data.steps
    state.current = 0
    state.tour_title = types.get_tour_title(data, name)

    vim.notify(
      string.format("Tour loaded: %s (%d steps)", state.tour_title, #state.steps),
      vim.log.levels.INFO
    )
  else
    vim.notify("Invalid tour file: " .. tour_file, vim.log.levels.ERROR)
  end
end

-- .toursディレクトリからツアーファイル一覧を取得
local function get_tour_files()
  local names_set = {}
  local names = {}

  -- 優先順に拡張子を処理（先に追加されたものが優先）
  for _, ext in ipairs(types.EXTENSIONS) do
    local files = vim.fn.glob(types.TOUR_DIR .. "/*" .. ext, false, true)
    for _, file in ipairs(files) do
      local name = vim.fn.fnamemodify(file, ":t:r")
      if not names_set[name] then
        names_set[name] = true
        table.insert(names, name)
      end
    end
  end

  return names
end

function M.setup()
  vim.api.nvim_create_user_command("TourNext", M.next, {})
  vim.api.nvim_create_user_command("TourPrev", M.prev, {})
  vim.api.nvim_create_user_command("TourLoad", function(opts)
    M.load(opts.args)
  end, {
    nargs = 1,
    complete = function()
      return get_tour_files()
    end,
  })
end

return M
