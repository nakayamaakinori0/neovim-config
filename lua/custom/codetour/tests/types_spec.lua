-- テスト実行方法:
-- :PlenaryBustedFile %
-- または
-- nvim --headless -c "PlenaryBustedFile lua/custom/codetour/tests/types_spec.lua"

local types = require("custom.codetour.types")

--------------------------------------------------------------------------------
-- get_tour_title: ツアーのタイトル取得
--------------------------------------------------------------------------------
describe("get_tour_title", function()
  it("titleがある場合はtitleを返す", function()
    -- Arrange
    local tour = { title = "My Tour" }
    local fallback = "Fallback Title"

    -- Act
    local result = types.get_tour_title(tour, fallback)

    -- Assert
    assert.equals("My Tour", result)
  end)

  it("titleが空文字の場合はfallbackを返す", function()
    -- Arrange
    local tour = { title = "" }
    local fallback = "Fallback Title"

    -- Act
    local result = types.get_tour_title(tour, fallback)

    -- Assert
    assert.equals("Fallback Title", result)
  end)

  it("titleがnilの場合はfallbackを返す", function()
    -- Arrange
    local tour = { title = nil }
    local fallback = "Fallback Title"

    -- Act
    local result = types.get_tour_title(tour, fallback)

    -- Assert
    assert.equals("Fallback Title", result)
  end)

  it("tourがnilの場合はfallbackを返す", function()
    -- Arrange
    local tour = nil
    local fallback = "Fallback Title"

    -- Act
    local result = types.get_tour_title(tour, fallback)

    -- Assert
    assert.equals("Fallback Title", result)
  end)

  it("fallbackもnilの場合は空文字を返す", function()
    -- Arrange
    local tour = nil
    local fallback = nil

    -- Act
    local result = types.get_tour_title(tour, fallback)

    -- Assert
    assert.equals("", result)
  end)
end)

--------------------------------------------------------------------------------
-- get_step_description: ステップの説明文取得
--------------------------------------------------------------------------------
describe("get_step_description", function()
  it("descriptionがある場合はdescriptionを返す", function()
    -- Arrange
    local step = {
      description = "Step description",
      text = "Legacy text",
    }

    -- Act
    local result = types.get_step_description(step)

    -- Assert
    assert.equals("Step description", result)
  end)

  it("descriptionがなくtextがある場合はtextを返す（後方互換性）", function()
    -- Arrange
    local step = { text = "Legacy text" }

    -- Act
    local result = types.get_step_description(step)

    -- Assert
    assert.equals("Legacy text", result)
  end)

  it("両方ない場合は空文字を返す", function()
    -- Arrange
    local step = {}

    -- Act
    local result = types.get_step_description(step)

    -- Assert
    assert.equals("", result)
  end)
end)

--------------------------------------------------------------------------------
-- format_for_notification: 通知用テキストのフォーマット
--------------------------------------------------------------------------------
describe("format_for_notification", function()
  it("複数行の場合は最初の行のみ返す", function()
    -- Arrange
    local text = "First line\nSecond line\nThird line"

    -- Act
    local result = types.format_for_notification(text)

    -- Assert
    assert.equals("First line", result)
  end)

  it("Markdownヘッダー（## など）は除去される", function()
    -- Arrange
    local text = "## Header Title"

    -- Act
    local result = types.format_for_notification(text)

    -- Assert
    assert.equals("Header Title", result)
  end)

  it("H1ヘッダー（#）も除去される", function()
    -- Arrange
    local text = "# Main Title"

    -- Act
    local result = types.format_for_notification(text)

    -- Assert
    assert.equals("Main Title", result)
  end)

  it("H3以上のヘッダー（###）も除去される", function()
    -- Arrange
    local text = "### Sub Title"

    -- Act
    local result = types.format_for_notification(text)

    -- Assert
    assert.equals("Sub Title", result)
  end)

  it("複数行でMarkdownヘッダーがある場合は最初の行からヘッダーを除去して返す", function()
    -- Arrange
    local text = "## Step Title\nThis is the description."

    -- Act
    local result = types.format_for_notification(text)

    -- Assert
    assert.equals("Step Title", result)
  end)

  it("空文字の場合は空文字を返す", function()
    -- Arrange
    local text = ""

    -- Act
    local result = types.format_for_notification(text)

    -- Assert
    assert.equals("", result)
  end)

  it("ヘッダーがない通常テキストはそのまま返す", function()
    -- Arrange
    local text = "Normal text without header"

    -- Act
    local result = types.format_for_notification(text)

    -- Assert
    assert.equals("Normal text without header", result)
  end)
end)

--------------------------------------------------------------------------------
-- get_step_title: ステップタイトル取得
--------------------------------------------------------------------------------
describe("get_step_title", function()
  it("titleがある場合はtitleを返す", function()
    -- Arrange
    local step = {
      title = "Step Title",
      description = "## Description Header\nBody text",
    }

    -- Act
    local result = types.get_step_title(step)

    -- Assert
    assert.equals("Step Title", result)
  end)

  it("titleが空文字の場合はdescriptionの最初の行を返す", function()
    -- Arrange
    local step = {
      title = "",
      description = "First line of description\nSecond line",
    }

    -- Act
    local result = types.get_step_title(step)

    -- Assert
    assert.equals("First line of description", result)
  end)

  it("titleがなくdescriptionがある場合はdescriptionの最初の行を返す", function()
    -- Arrange
    local step = {
      description = "Description text\nMore details",
    }

    -- Act
    local result = types.get_step_title(step)

    -- Assert
    assert.equals("Description text", result)
  end)

  it("descriptionにMarkdownヘッダーがある場合はヘッダーを除去して返す", function()
    -- Arrange
    local step = {
      description = "## Step Description\nBody content here",
    }

    -- Act
    local result = types.get_step_title(step)

    -- Assert
    assert.equals("Step Description", result)
  end)

  it("titleもdescriptionもない場合は空文字を返す", function()
    -- Arrange
    local step = {}

    -- Act
    local result = types.get_step_title(step)

    -- Assert
    assert.equals("", result)
  end)

  it("textフィールド（後方互換性）からタイトルを取得できる", function()
    -- Arrange
    local step = {
      text = "## Legacy Text\nOld format body",
    }

    -- Act
    local result = types.get_step_title(step)

    -- Assert
    assert.equals("Legacy Text", result)
  end)
end)
