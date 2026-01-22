-- types.lua
-- CodeTourプラグインのインターフェース定義

local M = {}

--------------------------------------------------------------------------------
-- VSCode CodeTour互換フォーマット
-- @see https://github.com/microsoft/codetour/blob/main/schema.json
--
-- Tour structure:
--   $schema: string (optional) - JSON schema URL
--   title: string (required) - Tour display name
--   description: string (optional) - Tour description
--   steps: Step[] (required) - Array of tour steps
--
-- Step structure:
--   title: string (optional) - Step display name
--   file: string (required) - Relative file path
--   line: number (required) - 1-based line number
--   description: string (required) - Step description (supports Markdown)
--   directory: string (optional) - Directory path (mutually exclusive with file)
--   pattern: string (optional) - Regex pattern for line matching
--------------------------------------------------------------------------------

-- 設定定数
M.TOUR_DIR = ".tours"
M.EXTENSIONS = { ".tour", ".json" } -- 優先順

--- ツアーのタイトルを取得
---@param tour table ツアーデータ
---@param fallback string? タイトルがない場合のフォールバック値
---@return string
function M.get_tour_title(tour, fallback)
  if tour and tour.title and tour.title ~= "" then
    return tour.title
  end
  return fallback or ""
end

--- ステップの説明文を取得（description優先、textは後方互換性）
---@param step table ステップデータ
---@return string
function M.get_step_description(step)
  return step.description or step.text or ""
end

--- 通知用テキストを取得（Markdownヘッダー除去、最初の行のみ）
---@param text string 元テキスト
---@return string
function M.format_for_notification(text)
  -- 最初の行のみ取得
  local first_line = text:match("^([^\n]*)")
  if first_line then
    -- Markdownヘッダー（## など）を除去
    first_line = first_line:gsub("^#+ *", "")
    return first_line
  end
  return text
end

--- ステップのタイトルを取得（titleがなければdescriptionの最初の行）
---@param step table ステップデータ
---@return string
function M.get_step_title(step)
  if step.title and step.title ~= "" then
    return step.title
  end
  local description = M.get_step_description(step)
  return M.format_for_notification(description)
end

return M
