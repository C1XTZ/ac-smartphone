--made by C1XTZ
--if you're reading any of this let me preface this by saying: If you're going: what the fuck is this idiot doing?? its likely that I said the same thing while writing it.

ui.setAsynchronousImagesLoading(true)

--#region APP PERSISTENT SETTINGS

local settings = ac.storage {
  appScale = 1,

  darkMode = false,
  darkModeAuto = false,
  darkModeAutoDarkAngle = 84,
  darkModeAutoLightAngle = 84,
  darkModeAutoDarkTime = 19,
  darkModeAutoLightTime = 9,

  forceBottom = true,
  focusMode = false,

  appMove = false,
  appMoveTimer = 10,
  appMoveSpeed = 10,

  badTime = false,

  songInfo = false,
  songInfoSpacing = 30,
  songInfoScrollSpeed = 30,
  songInfoScrollDirection = 0,
  songInfoscrollAlways = false,
  hideCamera = false,

  chatKeepSize = 100,
  chatOlderThan = 15,
  chatScrollDistance = 20,
  chatShowTimestamps = false,
  chatPurge = false,
  chatFontSize = 13,
  chatHideKickBan = false,
  chatHideAnnoying = true,
  chatHideRaceMsg = false,
  chatLatestBold = false,
  chatUsernameColor = true,

  connectionEvents = true,
  connectionEventsFriendsOnly = true,
  connectionEventsHideTraffic = true,

  enableAudio = true,
  enableKeyboard = true,
  enableMessage = true,
  enableNotification = true,
  volumeKeyboard = 1,
  volumeMessage = 1,
  volumeNotification = 1,
  messagesNonFriends = true,
  messagesServer = false,
  notificationsMentions = true,
  notificationsFriendConnections = true,
  notificationsFriendMessages = true,

  customColor = false,
  messageColorSelf = rgbm(0, 0.49, 1, 1),
  messageColorFriend = rgbm(0.2, 0.75, 0.3, 1),
}

--#endregion

--#region APP TABLES

local colors = {
  transparent = {
    black10 = rgbm(0, 0, 0, 0.1),
    white10 = rgbm(1, 1, 1, 0.1),
    black50 = rgbm(0, 0, 0, 0.5),
    white50 = rgbm(1, 1, 1, 0.5),
  },
  glowColor = rgbm(1, 1, 1, 0.65),
  displayColorLight = rgbm.colors.white,
  displayColorDark = rgbm.colors.black,
  headerColorLight = rgbm(0, 0, 0, 0.033),
  headerColorDark = rgbm(1, 1, 1, 0.075),
  headerLineColorLight = rgbm(0, 0, 0, 0.15),
  headerLineColorDark = rgbm(1, 1, 1, 0.075),
  iMessageBlue = rgbm(0, 0.49, 1, 1),
  iMessageLightGray = rgbm(0.85, 0.85, 0.85, 1),
  iMessageDarkGray = rgbm(0.15, 0.15, 0.15, 1),
  iMessageGreen = rgbm(0.2, 0.75, 0.3, 1),
  iMessageSelected = rgbm(0, 0.49, 1, 0.33),
  emojiPickerButtonLight = rgbm(0, 0, 0, 0.33),
  emojiPickerButtonDark = rgbm(1, 1, 1, 0.33),
  emojiPickerButtonBGLight = rgbm(0, 0, 0, 0.1),
  emojiPickerButtonBGDark = rgbm(1, 1, 1, 0.15),
  final = {
    display = rgbm(),
    header = rgbm(),
    headerLine = rgbm(),
    elements = rgbm(),
    message = rgbm(),
    messageOwn = rgbm(),
    messageOwnText = rgbm(),
    messageFriend = rgbm(),
    messageFriendText = rgbm(),
    input = rgbm(),
    emojiPicker = rgbm(),
    emojiPickerBG = rgbm(),
  },
}

local app = {
  scale = 1,
  size = vec2(0, 0),
  hovered = false,
  tooltipPadding = vec2(5, 5),
  headerTextSize = nil,
  headerTextScale = nil,
  clockTextArea = nil,
  clockTextAreaScale = nil,
  images = {
    phoneAtlasPath = '.\\src\\img\\phone.png',
    phoneAtlasSize = vec2(),
    phoneCamera = '.\\src\\img\\cam.png',
    pingAtlasPath = '.\\src\\img\\connection.png',
    emojiPicker = '.\\src\\img\\picker.png',
    defaultCover = '.\\src\\img\\player.png',
    ready = false,
  },
  font = {
    regular = ui.DWriteFont('Inter Variable Text', '.\\src\\ttf'):weight(ui.DWriteFont.Weight.Medium),
    bold = ui.DWriteFont('Inter Variable Text', '.\\src\\ttf'):weight(ui.DWriteFont.Weight.Bold),
  },
}

local player = {
  driverName = ac.getDriverName(0),
  cspVersion = ac.getPatchVersionCode(),
  isOnline = ac.getSim().isOnlineRace,
  serverIP = ac.getServerIP(),
  serverCommunity = 'default',
  timePeriod = '',
  phoneMode = settings.darkMode,
}

local communities = stringify.parse(io.load('.\\apps\\lua\\smartphone\\src\\communities\\data\\list.lua') --[[@as string]]) ---@cast communities table

local movement = {
  maxDistance = 487,
  timer = settings.appMoveTimer,
  down = true,
  up = false,
  distance = 0,
  smooth = 0,
}

local songInfo = {
  artist = '',
  title = '',
  final = '',
  hasCover = false,
  isPaused = false,
  dynamicIslandSize = vec2(40, 20),
  cachedTextSize = nil,
  cachedTextSizeText = nil,
  cachedTextSizeScale = nil,
  titleSplitPatterns = {
    '^(.-)%s*%- %s*(.+)$',
    '^(.-)%-([^%-]+)$',
  },
}

local chat = {
  messages = {},
  sendCd = false,
  scrollBool = false,
  mentioned = '',
  emojiPicker = false,
  emojiPickerHovered = false,
  emojiCharSize = nil,
  emojiCharSizeScale = nil,
  input = {
    active = false,
    hovered = false,
    sendHovered = false,
    placeholder = 'iMessage',
    text = '',
    offset = 0,
    selected = nil,
    history = {},
    historyIndex = 0,
  },
  playerHideStrings = {
    '^RP: App not running$',
    '^PLP: running version',
    '^ACP: App not active$',
    '^D&O Racing APP:',
    '^DRIFT%%%-STRUCTION POINTS:',
    '^OSRW Race Admin Version:',
    '^RSRC Race Admin',
  },
  serverHideStrings = {
    'kicked',
    'banned',
    'checksums',
    'teleported to pits',
  },
  popup = {
    hovered = nil,
  },
  emojis = {},
  usernameColors = {},
  latestNonServerMessage = nil,
  msgCacheGen = 0,
  stableHeight = 0,
  wasAtBottom = true,
  lastTotalHeight = 0,
  layoutPool = {},
}

local audio = {
  keyboard = {
    keystroke = { file = '.\\src\\aud\\keyboard-keystroke.mp3' },
    enter = { file = '.\\src\\aud\\keyboard-enter.mp3' },
    delete = { file = '.\\src\\aud\\keyboard-delete.mp3' },
  },
  message = {
    receive = { file = '.\\src\\aud\\message-receive.mp3' },
    send = { file = '.\\src\\aud\\message-send.mp3' },
  },
  notification = {
    regular = { file = '.\\src\\aud\\notif-regular.mp3' },
    critical = { file = '.\\src\\aud\\notif-critical.mp3' },
    timeout = 0.4,
  },
}

for category, events in pairs(audio) do
  for _, event in pairs(events) do
    if type(event) == 'table' and event.file then event.category = category end
  end
end

local nonTrafficPlayers = {}

local flags = {
  window = bit.bor(ui.WindowFlags.NoDecoration, ui.WindowFlags.NoBackground, ui.WindowFlags.NoNav, ui.WindowFlags.NoInputs, ui.WindowFlags.NoScrollbar),
  emojiWindow = bit.bor(ui.WindowFlags.NoDecoration, ui.WindowFlags.NoBackground, ui.WindowFlags.NoNav, ui.WindowFlags.NoScrollbar),
  input = bit.bor(ui.WindowFlags.NoDecoration, ui.WindowFlags.NoBackground, ui.WindowFlags.NoNav, ui.WindowFlags.NoScrollbar),
  colorpicker = bit.bor(ui.ColorPickerFlags.NoAlpha, ui.ColorPickerFlags.NoSidePreview, ui.ColorPickerFlags.NoDragDrop, ui.ColorPickerFlags.NoLabel, ui.ColorPickerFlags.DisplayRGB, ui.ColorPickerFlags.NoSmallPreview),
}

--#endregion

--#region UTF8 HANDLING

---@param s string @Input string
---@return number @Character count (counts multibyte characters as 1)
---Counts the number of characters in a UTF-8 encoded string.
local function utf8len(s)
  local len, i = 0, 1
  while i <= #s do
    len = len + 1
    local c = s:byte(i)
    if c >= 0xF0 then
      i = i + 4
    elseif c >= 0xE0 then
      i = i + 3
    elseif c >= 0xC0 then
      i = i + 2
    else
      i = i + 1
    end
  end
  return len
end

---@param s string @Input string
---@param i number @Start character index
---@param j? number @End character index
---@return string @Substring of s from i to j
---Extracts a substring from a UTF-8 encoded string.
local function utf8sub(s, i, j)
  j = j or -1
  local pos = 1
  local bytes = s:len()
  local len = 0
  local l = (i >= 0 and j >= 0) or utf8len(s)
  local startChar = (i >= 0) and i or l + i + 1
  local endChar = (j >= 0) and j or l + j + 1
  if startChar > endChar then return '' end
  local startByte, endByte = 1, bytes
  while pos <= bytes do
    len = len + 1

    if len == startChar then startByte = pos end
    pos = pos + (s:byte(pos) >= 0xF0 and 4 or s:byte(pos) >= 0xE0 and 3 or s:byte(pos) >= 0xC0 and 2 or 1)
    if len == endChar then
      endByte = pos - 1
      break
    end
  end
  return s:sub(startByte, endByte)
end

--#endregion

--#region UTILITY FUNCTIONS

---Moves the app up.
local function moveAppUp()
  if settings.appMove then
    movement.timer = settings.appMoveTimer
    movement.up = true
  end
end

---@param x number @number to be scaled
---@param smooth? boolean @whether to add the app's movement offset
---@return number @scaled number
---Scale and ceil a number by app.scale. Optionally adds the app's movement offset.
local function scaleNum(x, smooth) return math.ceil(app.scale * x) + (smooth and movement.smooth or 0) end

---@param x number @x to scale and ceil
---@param y number @y to scale and ceil
---@param smooth? boolean @whether to add the app's movement offset
---@return vec2 @scaled and ceiled vec2()
---Scales, Ceils and converts two numbers into a vec2(). Optionally adds the app's movement offset.
local function scaleVec2(x, y, smooth) return vec2(math.ceil(app.scale * x), math.ceil(app.scale * y) + (smooth and movement.smooth or 0)) end

---@param x number @x to ceil
---@param y number @y to ceil
---@return vec2 @ceiled vec2()
---Ceils and converts two numbers into a vec2()
local function ceilVec2(x, y) return vec2(math.ceil(x), math.ceil(y)) end

---@return number @Y offset, scaled by current UI scale.
local function modernButtonOffset() return -8 * ac.getUI().uiScale end

---@return number @Y offset, scaled by current UI scale.
local function popupNewlineOffset() return -18 * ac.getUI().uiScale end

---@param songString string @combined 'artist - title' string usually, whatever your mp3 player spits out
---@return string artist @artist name string
---@return string title @song title string
---Splits the title string into artist and track title.
local function splitTitle(songString)
  for _, pattern in ipairs(songInfo.titleSplitPatterns) do
    local artist, title = songString:match(pattern)
    if artist and title then
      artist = artist:gsub('^%s*(.-)%s*$', '%1')
      title = title:gsub('^%s*(.-)%s*$', '%1')
      title = title:gsub('%.%w+$', '')
      return artist, title
    end
  end
  local trimmedTitle = songString:gsub('%.%w+$', '')
  return 'Unknown Artist', trimmedTitle
end

---@param timeString string @Input string in 24-hour format (e.g., '14:30')
---@return string @Time string in 12-hour format (e.g., '02:30')
---Converts a 24-hour time string to 12-hour format and the time period (AM/PM).
local function to12hTime(timeString)
  local hour, minute = timeString:match('^(%d+):(%d+)$')
  hour, minute = tonumber(hour), tonumber(minute)
  player.timePeriod = 'AM'
  if hour >= 12 then
    player.timePeriod = 'PM'
    hour = hour % 12
    if hour == 0 then hour = 12 end
  end
  if hour < 10 then hour = '0' .. hour end
  return string.format('%s:%02d', hour, minute)
end

---@param carIndexOrUsername number|string @The index of the car or username whose friend status is being checked.
---@return boolean @Returns true if the driver is tagged as a friend.
---Determines whether the driver of the specified car or username is marked as a friend.
local function checkIfFriend(carIndexOrUsername)
  local driverName
  if type(carIndexOrUsername) == 'number' then
    driverName = ac.getDriverName(carIndexOrUsername)
    if not driverName then return false end
  else
    driverName = carIndexOrUsername
  end
  return ac.DriverTags(driverName).friend
end

---@return string @The community name of the current server.
---Determines the community name of the current server.
local function getServerCommunity()
  if not player.isOnline then return 'default' end

  for community, data in pairs(communities) do
    if (community ~= 'default' or community ~= 'version') and data.ips then
      for _, ip in ipairs(data.ips) do
        if ip == player.serverIP then return community end
      end
    end
  end

  return 'default'
end

---@param tooltipString string @Text to be displayed in the tooltip.
---@param changeCursor? boolean @Changes the mouse cursor to ui.MouseCursor.Hand
---Displays a tooltip for the last hovered item.
local function lastItemHoveredTooltip(tooltipString, changeCursor)
  if ui.itemHovered() then
    if changeCursor then ui.setMouseCursor(ui.MouseCursor.Hand) end
    ui.tooltip(app.tooltipPadding, function() ui.text(tooltipString) end)
  end
end

--- Creates a checkbox bound to a settings field, with optional change callback and tooltip.
--- @param label string Checkbox label.
--- @param key string Name of the boolean field in the `settings` table.
--- @param tooltip? string Tooltip text (optional).
--- @param onChange? fun(newValue: boolean) Called after the value changes.
--- @return boolean wasChanged True if the user toggled the checkbox.
local function settingsCheckbox(label, key, tooltip, onChange)
  local wasChanged = false
  if
    ui.checkbox(label, settings[key] --[[@as boolean]])
  then
    settings[key] = not settings[key]
    if onChange then
      onChange(settings[key] --[[@as boolean]])
    end
    wasChanged = true
  end
  if tooltip then lastItemHoveredTooltip(tooltip) end
  return wasChanged
end

--- Creates a slider bound to a settings field, with optional change callback and tooltip.
--- @param key string Name of the numeric field in the `settings` table.
--- @param min number Minimum slider value.
--- @param max number Maximum slider value.
--- @param labelFormat string Format string for the displayed value (e.g., "Speed: %.0f").
--- @param tooltip? string Tooltip text (optional).
--- @param onChange? fun(newValue: number) Called after the value changes.
--- @param power? number|boolean Power for non-linear slider, or `true` for integer mode. Default: `1` (linear).
--- @return number currentValue The new (or current) value.
local function settingsSlider(key, min, max, labelFormat, tooltip, onChange, power)
  local value, changed = ui.slider('##' .. key, settings[key]--[[@as number]], min, max, labelFormat, power)
  if changed then
    settings[key] = value
    if onChange then onChange(value) end
  end
  if tooltip then lastItemHoveredTooltip(tooltip) end
  return value
end

---@param color rgbm The RGB color to calculate luminance for
---@return number luminance The perceptual luminance value (0-1, where 0 is black and 1 is white)
---Calculate perceptual luminance (0-1 range) using Rec. 709 coefficients for blue and red, halved for green.
local function getLuminance(color)
  local function toLinear(c)
    if c <= 0.03928 then
      return c / 12.92
    else
      return math.pow((c + 0.055) / 1.055, 2.4)
    end
  end

  local lr = toLinear(color.r)
  local lg = toLinear(color.g)
  local lb = toLinear(color.b)

  return 0.2126 * lr + 0.3576 * lg + 0.0722 * lb
end

---@param index integer @Car index
---Caches the driver tag color for the specified car index.
local function getDriverColor(index)
  local name = ac.getDriverName(index)
  if not name or name == '' then return end

  local color = ac.DriverTags(name).color:clone()
  local isDefaultColor = (index == 0 and color == rgbm.colors.yellow) or (index > 0 and color == rgbm.colors.white)
  if isDefaultColor then color:set(rgbm.colors.gray) end

  local existingColor = chat.usernameColors[name]

  local shouldUpdate = (not existingColor and color ~= rgbm.colors.gray) or (existingColor and ((existingColor == rgbm.colors.gray and color ~= rgbm.colors.gray) or existingColor ~= color))

  if shouldUpdate then chat.usernameColors[name] = color end
end

---@param light rgbm @rgbm color to use if light mode
---@param dark rgbm @rgbm color to use if dark mode
---@return rgbm @rgbm color to be used for the given mode
---Picks the appropriate color based on the current mode.
local function pickThemeColor(light, dark) return (settings.darkMode or player.phoneMode) and dark or light end

---@param message any @The message to be sent.
---@param deleteAfter? number @The amount of time to wait before deleting the message.
---Sends a chat message as the app using the server index.
local function sendAppMessage(message, deleteAfter)
  table.insert(chat.messages, { -1, 'App', message, os.time() })
  local msgIndex = #chat.messages
  moveAppUp()

  if deleteAfter then setTimeout(function() table.remove(chat.messages, msgIndex) end, deleteAfter) end
end

---Loads emojis from the data_emoji.txt file, fully supporting emoji grapheme clusters.
---Disclosure: this piece of shit was written by Claude, it is black magic to me.
local function loadEmojis()
  local path = ac.getFolder(ac.FolderID.ExtCfgSys) .. '\\data_emoji.txt'
  local f = io.open(path, 'r')
  if not f then return {} end
  local content = f:read('*a')
  f:close()

  -- UTF-8 helpers -----------------------------------------------------------
  local VS16 = '\239\184\143' -- U+FE0F Variation Selector-16
  local ZWJ = '\226\128\141' -- U+200D Zero Width Joiner

  local function codepoint_bytes(first_byte)
    if first_byte >= 0xF0 then
      return 4
    elseif first_byte >= 0xE0 then
      return 3
    elseif first_byte >= 0xC0 then
      return 2
    else
      return 1
    end
  end

  -- Check if a 4‑byte codepoint is a skin‑tone modifier (U+1F3FB‑U+1F3FF)
  local function is_skin_tone(b1, b2, b3, b4) return b1 == 0xF0 and b2 == 0x9F and b3 == 0x8F and b4 >= 0xBB and b4 <= 0xBF end

  -- Check if a 4‑byte codepoint is a Regional Indicator (U+1F1E6‑U+1F1FF)
  local function is_regional_indicator(b1, b2, b3, b4) return b1 == 0xF0 and b2 == 0x9F and b3 == 0x87 and b4 >= 0xA6 and b4 <= 0xBF end

  -- Check if a 3‑byte codepoint is U+20E3 (combining enclosing keycap)
  local function is_keycap(b1, b2, b3) return b1 == 0xE2 and b2 == 0x83 and b3 == 0xA3 end

  -- Check if a 4‑byte codepoint is a tag character (U+E0020‑U+E007F)
  local function is_tag(b1, b2, b3, b4)
    if b1 ~= 0xF3 or b2 ~= 0x80 then return false end
    if b3 == 0x80 then return b4 >= 0xA0 and b4 <= 0xBF end
    if b3 == 0x81 then return b4 >= 0x80 and b4 <= 0xBF end
    return false
  end

  -- Extract the next extended grapheme cluster starting at `pos`.
  -- Returns the cluster string and the new position.
  local function getNextCluster(line, pos)
    local start = pos
    local b = line:byte(pos)
    if not b or b <= 32 then return '', pos end

    local cplen = codepoint_bytes(b)
    local cluster = line:sub(pos, pos + cplen - 1)
    pos = pos + cplen

    -- --- Special handling for multi‑codepoint bases ------------------------
    -- 1) Pair of Regional Indicators → flag
    if cplen == 4 then
      local b1, b2, b3, b4 = string.byte(cluster, 1, 4)
      if is_regional_indicator(b1, b2, b3, b4) and pos + 3 <= #line then
        local nb1, nb2, nb3, nb4 = line:byte(pos, pos + 3)
        if is_regional_indicator(nb1, nb2, nb3, nb4) then
          cluster = cluster .. line:sub(pos, pos + 3)
          pos = pos + 4
          return cluster, pos -- no further modifiers on flags
        end
      end

      -- 2) Black flag U+1F3F4 followed by tag sequence → subdivision flag
      if b1 == 0xF0 and b2 == 0x9F and b3 == 0x8F and b4 == 0xB4 then
        while pos <= #line do
          local tb = line:byte(pos)
          local tlen = codepoint_bytes(tb)
          if tlen ~= 4 then break end
          local tb1, tb2, tb3, tb4 = line:byte(pos, pos + 3)
          if not is_tag(tb1, tb2, tb3, tb4) then break end
          cluster = cluster .. line:sub(pos, pos + 3)
          pos = pos + 4
          -- Cancel tag U+E007F ends the sequence
          if tb1 == 0xF3 and tb2 == 0x80 and tb3 == 0x81 and tb4 == 0xBF then break end
        end
        return cluster, pos
      end
    end

    -- --- Common modifiers that can follow any base --------------------------
    -- Optional Variation Selector‑16
    if pos + 2 <= #line and line:sub(pos, pos + 2) == VS16 then
      cluster = cluster .. VS16
      pos = pos + 3
    end

    -- Optional skin‑tone modifier (right after base+VS16)
    if pos + 3 <= #line then
      local sb1, sb2, sb3, sb4 = line:byte(pos, pos + 3)
      if is_skin_tone(sb1, sb2, sb3, sb4) then
        cluster = cluster .. line:sub(pos, pos + 3)
        pos = pos + 4
      end
    end

    -- Optional keycap combining character (after VS16, before ZWJ)
    if pos + 2 <= #line then
      local kb1, kb2, kb3 = line:byte(pos, pos + 2)
      if is_keycap(kb1, kb2, kb3) then
        cluster = cluster .. line:sub(pos, pos + 2)
        pos = pos + 3
      end
    end

    -- --- Zero or more ZWJ sequences -----------------------------------------
    while pos + 2 <= #line and line:sub(pos, pos + 2) == ZWJ do
      cluster = cluster .. ZWJ
      pos = pos + 3

      -- The character after ZWJ
      if pos > #line then break end
      local nb = line:byte(pos)
      local nlen = codepoint_bytes(nb)
      cluster = cluster .. line:sub(pos, pos + nlen - 1)
      pos = pos + nlen

      -- Optional VS16 after that character
      if pos + 2 <= #line and line:sub(pos, pos + 2) == VS16 then
        cluster = cluster .. VS16
        pos = pos + 3
      end

      -- Optional skin tone after this ZWJ element
      if pos + 3 <= #line then
        local sb1, sb2, sb3, sb4 = line:byte(pos, pos + 3)
        if is_skin_tone(sb1, sb2, sb3, sb4) then
          cluster = cluster .. line:sub(pos, pos + 3)
          pos = pos + 4
        end
      end
    end

    return cluster, pos
  end

  -- --- Main file processing -------------------------------------------------
  local emojis = {}
  for line in content:gmatch('[^\r\n]+') do
    if line:byte(1) ~= 35 and line:find('%S') then
      local pos = 1
      while pos <= #line do
        local b = line:byte(pos)
        if b <= 32 then
          pos = pos + 1
        else
          local cluster, newPos = getNextCluster(line, pos)
          if cluster ~= '' then emojis[#emojis + 1] = cluster end
          pos = newPos
        end
      end
    end
  end

  chat.emojis = emojis
end

---Populates the nonTrafficPlayers table with the names of players that are not hidding labels. AssettoServer traffic cars if HideAiCars is enabled for example.
local function getNonTrafficPlayers()
  for i, car in ac.iterateCars() do
    local driverName = ac.getDriverName(i - 1)
    if driverName and driverName ~= '' and not car.isHidingLabels then nonTrafficPlayers[driverName] = true end
  end
end

--#endregion

--#region GENERAL LOGIC FUNCTIONS

---Updates the colors based on the current mode.
local function updateColors()
  colors.final.display:set(pickThemeColor(colors.displayColorLight, colors.displayColorDark))
  colors.final.header:set(pickThemeColor(colors.headerColorLight, colors.headerColorDark))
  colors.final.elements:set(pickThemeColor(colors.displayColorDark, colors.displayColorLight))
  colors.final.headerLine:set(pickThemeColor(colors.headerLineColorLight, colors.headerLineColorDark))
  colors.final.input:set(pickThemeColor(colors.transparent.black50, colors.transparent.white50))
  colors.final.message:set(pickThemeColor(colors.iMessageLightGray, colors.iMessageDarkGray))
  colors.final.emojiPicker:set(pickThemeColor(colors.emojiPickerButtonLight, colors.emojiPickerButtonDark))
  colors.final.emojiPickerBG:set(pickThemeColor(colors.emojiPickerButtonBGLight, colors.emojiPickerButtonBGDark))

  colors.final.messageOwn:set(settings.customColor and settings.messageColorSelf or colors.iMessageBlue)
  colors.final.messageFriend:set(settings.customColor and settings.messageColorFriend or colors.iMessageGreen)

  colors.final.messageOwnText:set(getLuminance(colors.final.messageOwn) <= 0.225 and rgbm.colors.white or rgbm.colors.black)
  colors.final.messageFriendText:set(getLuminance(colors.final.messageFriend) <= 0.225 and rgbm.colors.white or rgbm.colors.black)
end

local appWindow = ac.accessAppWindow('IMGUI_LUA_Smartphone_main')
local appBottom
---Forces the app to be at the bottom of the screen.
local function forceAppToBottom()
  if not appWindow or not appWindow:valid() then return end

  local screenSpace = ac.getSim().windowHeight
  if not appBottom or appBottom ~= screenSpace - appWindow:size().y then appBottom = screenSpace - appWindow:size().y end

  if appWindow:position().y ~= appBottom and not ui.isMouseDragging(ui.MouseButton.Left, 0) then appWindow:move(vec2(appWindow:position().x, appBottom)) end
end

---@param dt number @Delta time in seconds since last update.
---Updates movement state
local function updateAppMovement(dt)
  if not settings.appMove then
    if movement.distance ~= 0 then
      movement.distance = 0
      movement.smooth = 0
    end
    return
  end

  local scaledMaxDistance = scaleNum(movement.maxDistance)

  if movement.distance == 0 and movement.timer > 0 then
    movement.timer = movement.timer - dt
    movement.down = true
    return
  end

  if movement.down and movement.timer <= 0 then
    movement.distance = math.floor(movement.distance + dt * 100 * settings.appMoveSpeed)
    movement.smooth = math.floor(math.smootherstep(math.lerpInvSat(movement.distance, 0, scaledMaxDistance)) * scaledMaxDistance)

    if movement.distance >= scaledMaxDistance then
      movement.distance = scaledMaxDistance
      movement.down = false
    end
  elseif movement.up and movement.timer > 0 then
    movement.distance = math.floor(movement.distance - dt * 100 * settings.appMoveSpeed)
    movement.smooth = math.floor(math.smootherstep(math.lerpInvSat(movement.distance, 0, scaledMaxDistance)) * scaledMaxDistance)

    if movement.distance <= 0 then
      movement.distance = 0
      movement.up = false
      movement.timer = settings.appMoveTimer
    end
  end
end

---@param event table @audio event table (audio.category.event)
---Plays the specified audio event.
local function playAudio(event)
  if not settings.enableAudio or not event or not event.category then return end

  local categoryFound = event.category
  local enableSetting = 'enable' .. categoryFound:sub(1, 1):upper() .. categoryFound:sub(2)
  if not settings[enableSetting] then return end

  local volumeSetting = 'volume' .. categoryFound:sub(1, 1):upper() .. categoryFound:sub(2)
  local audioToPlay = ac.AudioEvent.fromFile({ filename = event.file, use3D = false, loop = false }, false)

  audioToPlay.cameraInteriorMultiplier = 1
  audioToPlay.cameraExteriorMultiplier = 1
  audioToPlay.volume = settings[volumeSetting]
  audioToPlay:start()
  setTimeout(function() audioToPlay:dispose() end, audioToPlay:getDuration(), 'audioToPlay')
end

local audioIndexes = {}
---@param tbl table @audio table (audio.category)
---Plays a test audio event.
local function playTestAudio(tbl)
  local t = {}
  for _, v in pairs(tbl) do
    if type(v) == 'table' and v.file then t[#t + 1] = v end
  end

  local key = tbl
  audioIndexes[key] = (audioIndexes[key] or 0) + 1
  if audioIndexes[key] > #t then audioIndexes[key] = 1 end

  return playAudio(t[audioIndexes[key]])
end

---Switches the phone mode automatically based on the current time or sun angle.
local function automaticModeSwitch()
  if not settings.darkModeAuto then
    if player.phoneMode then
      player.phoneMode = false
      updateColors()
    end
    return
  end

  local sim = ac.getSim()
  --ac.getSunAngle() is broken online before 0.2.10 (3459)
  if player.cspVersion >= 3459 then
    local sunAngle = ac.getSunAngle()
    local timeHours = sim.timeHours

    local shouldBeDark = false
    if (timeHours > 12 and sunAngle > settings.darkModeAutoDarkAngle) or (timeHours < 12 and sunAngle > settings.darkModeAutoLightAngle) then shouldBeDark = true end

    if player.phoneMode ~= shouldBeDark then
      player.phoneMode = shouldBeDark
      updateColors()
    end
  else
    local currentTime = sim.timeHours + sim.timeMinutes / 60
    local shouldBeDark = not (currentTime > settings.darkModeAutoLightTime and currentTime < settings.darkModeAutoDarkTime)

    if player.phoneMode ~= shouldBeDark then
      player.phoneMode = shouldBeDark
      updateColors()
    end
  end
end

--#endregion

--#region SONG INFO FUNCTIONS

---@param enable boolean @sets the width of the island
---Sets the width of the dynamic island.
local function setDynamicIslandSize(enable)
  local width = enable and 80 or 40
  songInfo.dynamicIslandSize:set(width, 20)
end

---@param forced? boolean @Whether to force updating the song information even if the artist and title have not changed.
---Updates the global songInfo table with the currently playing track’s artist and title, handles cases of unknown artists or paused playback, and formats the scrolling text display.
local function updateSongInfo(forced)
  if not settings.songInfo then return end

  local current = ac.currentlyPlaying()

  if not forced and current.artist == songInfo.artist and current.title == songInfo.title and current.isPlaying == not songInfo.isPaused then return end

  if (current.artist == '' and current.title == '') or not current.isPlaying then
    songInfo.final = ''

    if songInfo.dynamicIslandSize.x == 80 then setDynamicIslandSize(false) end
    songInfo.isPaused = true
  else
    if (current.artist:lower() == 'unknown artist' or current.artist == '') and current.title ~= '' then
      songInfo.artist, songInfo.title = splitTitle(current.title)
    else
      songInfo.artist = current.artist
      songInfo.title = current.title
    end

    songInfo.final = (songInfo.artist ~= '' and songInfo.artist:lower() ~= 'unknown artist') and (songInfo.artist .. ' - ' .. songInfo.title) or songInfo.title
    songInfo.hasCover = current.hasCover

    if songInfo.dynamicIslandSize.x == 40 then setDynamicIslandSize(true) end
    songInfo.isPaused = not current.isPlaying
  end
end

---@param text string @The text content to be displayed, either static or scrolling.
---@param pos vec2 @The position coordinates where the text should be drawn.
---@param size vec2 @The dimensions of the text drawing area.
---@param fontSize number @The font size to use for rendering the text.
---Draws text that can either be static and centered, or scrolling horizontally.
local function drawSongInfoText(text, pos, size, fontSize)
  if not text or text == '' then return end

  local static = false

  ui.pushDWriteFont(app.font.bold)

  if songInfo.cachedTextSize == nil or songInfo.cachedTextSizeText ~= text or songInfo.cachedTextSizeScale ~= app.scale then
    songInfo.cachedTextSize = ui.measureDWriteText(text, fontSize)
    songInfo.cachedTextSizeText = text
    songInfo.cachedTextSizeScale = app.scale
  end

  local textSize = songInfo.cachedTextSize
  if not textSize then
    ui.popDWriteFont()
    return
  end

  if textSize.x <= size.x - scaleNum(4) and not settings.songInfoscrollAlways then static = true end

  if static then
    ui.setCursor(pos)
    ui.dwriteTextAligned(text, fontSize, ui.Alignment.Center, ui.Alignment.Center, size, false, rgbm.colors.white)
  else
    local stepW = textSize.x + settings.songInfoSpacing
    local scrollDirection = settings.songInfoScrollDirection == 0 and -1 or 1
    local scrollTime = os.clock() * settings.songInfoScrollSpeed
    local scrollX = scrollDirection * (scrollTime % stepW)

    ui.pushClipRect(pos, pos + size)
    for i = -1, math.ceil(size.x / stepW) do
      ui.dwriteDrawText(text, fontSize, ceilVec2(pos.x + scrollX + i * stepW, pos.y + (size.y - textSize.y) / 2), rgbm.colors.white)
    end
    ui.popClipRect()
  end

  ui.popDWriteFont()
end

--#endregion

--#region CHAT LOGIC FUNCTIONS

---@param message string? @Optional, message to be sent instead of input field text.
---Sends a chat message.
local function sendChatMessage(message)
  if not chat.sendCd then
    playAudio(audio.keyboard.enter)

    ac.sendChatMessage(message or chat.input.text)

    table.insert(chat.input.history, { 0, player.driverName, chat.input.text, os.time() })
    if #chat.input.history > 15 then table.remove(chat.input.history, 1) end

    chat.sendCd = true

    if chat.input.hovered then
      chat.input.text = ''
    else
      if chat.mentioned ~= '' then chat.mentioned = '' end
      chat.input.active = false
    end

    chat.input.historyIndex = 0
    chat.scrollBool = true
    setTimeout(function() chat.scrollBool = false end, 0.1)
    setTimeout(function() chat.sendCd = false end, 1)
  end
end

---@param isPlayer boolean @Indicates if the message originates from a player or the server.
---@param message string @The string content of the incoming chat message.
---@return boolean @Returns true if the message matches one of the hide patterns.
---Determines whether a chat message should be hidden based on the pattern strings.
local function matchMessage(isPlayer, message)
  local lowerMessage = message:lower()
  local lowerPlayerName = player.driverName:lower()

  if isPlayer then
    for _, pattern in ipairs(chat.playerHideStrings) do
      if message:match(pattern) then return true end
    end
  else
    for _, reason in ipairs(chat.serverHideStrings) do
      if lowerMessage:find(reason) then
        if lowerMessage:find(lowerPlayerName) then
          setTimeout(function() playAudio(audio.notification.critical) end, audio.notification.timeout)
        else
          if lowerMessage:find('^you') or lowerMessage:find('^it is currently night') then
            setTimeout(function() playAudio(audio.notification.critical) end, audio.notification.timeout)
          else
            return true
          end
        end
      end
    end

    if settings.chatHideRaceMsg and lowerMessage:find('in a race%%%.$') then
      if not lowerMessage:find('you') and not lowerMessage:find(lowerPlayerName) then return true end
    end
  end

  return false
end

---Deletes the oldest messages from the chat.
local function deleteOldestMessages()
  local currentTime = os.time()
  local index = 1
  local removedMsg = false

  while index <= #chat.messages do
    if #chat.messages > settings.chatKeepSize and currentTime - chat.messages[index][4] > (settings.chatOlderThan * 60) then
      table.remove(chat.messages, index)
      removedMsg = true
    else
      index = index + 1
    end
  end

  if removedMsg then
    local activeUsernames = {}
    for i = 1, #chat.messages do
      activeUsernames[chat.messages[i][2]] = true
    end
    for username, _ in pairs(chat.usernameColors) do
      if not activeUsernames[username] then chat.usernameColors[username] = nil end
    end
  end
end

---Custom keyboard handling for input field, may god have mercy on my soul.
local function handleKeyboardInput()
  local keyboardInput = ui.captureKeyboard(false, true)
  local msgLen = utf8len(chat.input.text) > 0
  local typed = keyboardInput:queue()
  local inputMaxLen = math.floor(490 * (13 / settings.chatFontSize) ^ 2)

  if ui.keyPressed(ui.Key.Backspace) or ui.keyPressed(ui.Key.Delete) then
    playAudio(audio.keyboard.delete)
  elseif ui.keyboardButtonPressed(ui.getKeyIndex(ui.Key.Space), true) then
    playAudio(audio.keyboard.enter)
  elseif typed:gsub('[%c]', '') ~= '' and typed ~= ' ' then
    playAudio(audio.keyboard.keystroke)
  end

  if (ui.keyPressed(ui.Key.Backspace) or ui.keyPressed(ui.Key.Delete)) and msgLen then
    if chat.input.selected then
      chat.input.text = ''
      chat.input.selected = nil
    end
    chat.input.text = utf8sub(chat.input.text, 1, utf8len(chat.input.text) - 1)
    return
  elseif ui.keyPressed(ui.Key.Enter) and msgLen then
    sendChatMessage()
    chat.emojiPicker = false
    return
  elseif ui.keyboardButtonDown(ui.KeyIndex.Control) and ui.keyboardButtonPressed(ui.KeyIndex.V, true) then
    local clipboardText = ui.getClipboardText()
    if utf8len(chat.input.text .. clipboardText) >= inputMaxLen then return end
    chat.input.text = chat.input.text .. clipboardText
    return
  elseif ui.keyboardButtonDown(ui.KeyIndex.Control) and ui.keyboardButtonPressed(ui.KeyIndex.A) and msgLen then
    if chat.input.selected then chat.input.selected = nil end
    chat.input.selected = chat.input.text
    return
  elseif ui.keyboardButtonDown(ui.KeyIndex.Control) and ui.keyboardButtonPressed(ui.KeyIndex.C) and chat.input.selected then
    ac.setClipboardText(chat.input.selected)
    return
  elseif ui.keyboardButtonDown(ui.KeyIndex.Control) and ui.keyboardButtonPressed(ui.KeyIndex.X) and chat.input.selected then
    ac.setClipboardText(chat.input.selected)
    chat.input.text = ''
    chat.input.selected = nil
    return
  elseif ui.keyPressed(ui.Key.Up) and chat.input.active then
    if chat.input.historyIndex < #chat.input.history then
      chat.input.historyIndex = chat.input.historyIndex + 1
      chat.input.text = chat.input.history[#chat.input.history - chat.input.historyIndex + 1][3]
    end
    return
  elseif ui.keyPressed(ui.Key.Down) and chat.input.active then
    if chat.input.historyIndex > 1 then
      chat.input.historyIndex = chat.input.historyIndex - 1
      chat.input.text = chat.input.history[#chat.input.history - chat.input.historyIndex + 1][3]
    elseif chat.input.historyIndex == 1 then
      chat.input.historyIndex = 0
      chat.input.text = ''
    end
    return
  end

  if typed == '' then return end
  typed = typed:gsub('[%c]', '')

  if typed ~= '' and chat.input.selected then
    chat.input.selected = nil
    chat.input.text = ''
  end

  if utf8len(chat.input.text) >= inputMaxLen then return end

  chat.input.text = chat.input.text .. typed
end

---@param userIndex number @Car index of the message sender
---@param userName string @Username of the message sender
---Popup for right clicking Usernames like in the regular chat app.
local function chatPlayerPopup(userIndex, userName)
  local car = ac.getCar(userIndex)
  if not car or car:driverName() ~= userName then return end

  if ui.mouseClicked(ui.MouseButton.Right) then
    playAudio(audio.keyboard.enter)
    ui.openPopup('chatPlayerPopup' .. userName)
  end

  --note: I know that ui.setDriverPopup() exists, but the _Tag in Chat_ would insert the name into the csp chat app, which makes it useless.
  --      Since thats probably one of the more used buttons, I decided to make a custom popup instead.
  --      Which means that none of the Admin tools (Setting Ballast/Restrictor, Giving Penalties and Kick/Banning) are available.
  --      Setting Ballast/Restictor/Penalties using Lua requires physics access which apps do not have online. Kick & Banning is not possible at all (Only initiating a Vote).
  --      I could make buttons that type out commands but Kunos acServer and AssettoServer have different command syntax.
  --      Checking which server integration is used would be a pain in the ass and the app isnt really meant to be used in league racing anyways so I wont bother.
  if ui.beginPopup('chatPlayerPopup' .. userName, nil, 0) then
    moveAppUp()

    if ui.modernMenuItem('Tag in chat', ui.Icons.Tag, false, ui.SelectableFlags.None, false) then
      playAudio(audio.keyboard.keystroke)
      if chat.input.text == chat.input.placeholder then chat.input.text = '' end
      chat.input.active = true
      chat.input.text = chat.input.text .. '@' .. userName
      ui.closePopup()
    end

    ui.newLine(popupNewlineOffset())
    ui.separator()

    if player.cspVersion >= 3459 then
      local friendString = ac.DriverTags(userName).friend and 'Remove as Friend' or 'Mark as Friend'
      ui.newLine(popupNewlineOffset())
      if ui.modernMenuItem(friendString, ui.Icons.Befriend, false, ui.SelectableFlags.DontClosePopups, false) then
        playAudio(audio.keyboard.enter)
        ac.DriverTags(userName).friend = not ac.DriverTags(userName).friend
      end

      ui.newLine(popupNewlineOffset())
      if ui.modernMenuItem('Mute', ui.Icons.Ban, false, ui.SelectableFlags.DontClosePopups, false) then
        playAudio(audio.keyboard.enter)
        ui.modalPopup(
          'Confirm Mute',
          'Are you sure you want to mute ' .. userName .. '?\nYou will no longer be able to read their chat messages.\nUnmute them via the Drivers list in the CSP Chat app.',
          'Confirm',
          'Cancel',
          ui.Icons.Confirm,
          ui.Icons.Cancel,
          function(confirmed)
            if confirmed then ac.DriverTags(userName).muted = not ac.DriverTags(userName).muted end
            playAudio(audio.keyboard.enter)
          end
        )
      end
    end

    if car.isConnected then
      ui.newLine(popupNewlineOffset())
      ui.separator()

      local watchString = car.focused and 'Stop Watching' or 'Watch Closely'
      ui.newLine(popupNewlineOffset())
      if ui.modernMenuItem(watchString, ui.Icons.VideoCamera, false, ui.SelectableFlags.DontClosePopups, false) then
        playAudio(audio.keyboard.enter)
        if car.focused then
          ac.focusCar(0)
        else
          ac.focusCar(userIndex)
        end
      end
    end

    ui.endPopup()
  else
    chat.popup.hovered = nil
  end
end

--#endregion

--#region DRAWING FUNCTIONS

---Draws the background.
local function drawDisplay() ui.drawRectFilled(scaleVec2(5, 2, true), scaleVec2(app.size.x - 5, app.size.y), colors.final.display, scaleNum(50), ui.CornerFlags.Top) end

---Draws the iPhone images.
local function drawiPhone()
  ui.setCursor(vec2(0, 0))
  ui.childWindow('OnTopImages', vec2(app.images.phoneAtlasSize.x / 2, app.images.phoneAtlasSize.y), false, flags.window, function()
    ui.drawImage(app.images.phoneAtlasPath, scaleVec2(0, 0, true), scaleVec2(app.size.x, app.size.y, true), rgbm.colors.white, vec2(0, 0), vec2(1 / 2, 1))
    if not (settings.darkMode or player.phoneMode) then ui.drawImage(app.images.phoneAtlasPath, scaleVec2(0, 0, true), scaleVec2(app.size.x, app.size.y, true), colors.glowColor, vec2(1 / 2, 0), vec2(1, 1)) end
  end)
end

---Draws the ping.
local function drawPing()
  local ping = ac.getCar(0).ping
  local pingSize = scaleVec2(20, 20)
  local pingPos = scaleVec2(238, 20, true)
  local isHovered = app.hovered and ui.rectHovered(pingPos, pingPos + pingSize, true)

  if ping > -1 then
    if isHovered then
      ui.tooltip(app.tooltipPadding, function() ui.text('Current Ping: ' .. ping .. ' ms\nClick to send to chat.') end)
      if not ui.isMouseDragging(ui.MouseButton.Left, 0) then ui.setMouseCursor(ui.MouseCursor.Hand) end
      if ui.mouseReleased(ui.MouseButton.Left) then sendChatMessage('I currently have a ping of ' .. ping .. ' ms.') end
    end

    local textureStartUV, textureEndUV
    if ping < 100 then
      textureStartUV, textureEndUV = 0 / 5, 1 / 5
    elseif ping < 200 then
      textureStartUV, textureEndUV = 1 / 5, 2 / 5
    elseif ping < 300 then
      textureStartUV, textureEndUV = 2 / 5, 3 / 5
    else
      if math.floor(os.clock() * 2) % 2 == 0 then
        textureStartUV, textureEndUV = 4 / 5, 5 / 5
      else
        textureStartUV, textureEndUV = 3 / 5, 4 / 5
      end
    end

    ui.drawImage(app.images.pingAtlasPath, pingPos, pingPos + pingSize, colors.final.elements, vec2(textureStartUV, 0), vec2(textureEndUV, 1))
  else
    if isHovered then ui.tooltip(app.tooltipPadding, function() ui.text('Currently offline or ping unavailable.') end) end

    local animFrame = math.floor(os.clock() * 2) % 3
    local textureStartUV = (2 - animFrame) / 5
    local textureEndUV = (3 - animFrame) / 5

    ui.drawImage(app.images.pingAtlasPath, pingPos, pingPos + pingSize, colors.final.elements, vec2(textureStartUV, 0), vec2(textureEndUV, 1))
  end
end

---Draws the time.
local function drawTime()
  local time = os.date('%H:%M') ---@cast time string
  local timeText = settings.badTime and to12hTime(time) or time
  local fontSize = scaleNum(13)
  local dummyStr = '00:00'

  ui.pushDWriteFont(app.font.bold)

  if app.clockTextArea == nil or app.clockTextAreaScale ~= app.scale then
    local textSize = ui.measureDWriteText(dummyStr, fontSize)
    app.clockTextArea = vec2(math.ceil(textSize.x), math.ceil(textSize.y))
    app.clockTextAreaScale = app.scale
  end

  local textArea = app.clockTextArea
  if not textArea then
    ui.popDWriteFont()
    return
  end

  local rightEdge = scaleNum(62)
  local areaLeft = rightEdge - textArea.x
  local areaTop = scaleNum(22, true)

  ui.setCursor(vec2(areaLeft, areaTop))
  ui.dwriteTextAligned(timeText, fontSize, ui.Alignment.End, ui.Alignment.Center, textArea, false, colors.final.elements)
  ui.popDWriteFont()

  if app.hovered then
    local tooltipText = player.isOnline and 'Current Time: ' .. timeText .. '\nClick to send to chat.' or 'Current Time: ' .. timeText
    lastItemHoveredTooltip(tooltipText, player.isOnline and true or false)

    if ui.itemClicked(ui.MouseButton.Left) and player.isOnline then
      timeText = settings.badTime and timeText .. ' ' .. player.timePeriod or timeText
      sendChatMessage("It's currently " .. timeText .. ' my local time.')
    end
  end
end

---Draws the dynamic island.
local function drawDynamicIsland()
  local islandHalfWidth = songInfo.dynamicIslandSize.x
  local islandHeight = songInfo.dynamicIslandSize.y
  local borderRadius = scaleNum(10)
  local left = scaleVec2(app.size.x / 2 - islandHalfWidth, islandHeight, true)
  local right = scaleVec2(app.size.x / 2 + islandHalfWidth, islandHeight * 2, true)

  ui.drawRectFilled(left, right, rgbm.colors.black, borderRadius)

  if not settings.hideCamera or not settings.songInfo or songInfo.isPaused then
    local islandTop = scaleNum(islandHeight, true)
    local islandBottom = scaleNum(islandHeight * 2, true)
    local camTotalHeight = scaleNum(islandHeight - 2)
    local camSize = camTotalHeight / 2
    local camTop = islandTop + math.floor((islandBottom - islandTop - camTotalHeight) / 2)
    local camPosY = camTop + camSize
    local camPosX = scaleNum(app.size.x / 2 + 30)

    ui.drawImage(app.images.phoneCamera, vec2(camPosX - camSize, camPosY - camSize), vec2(camPosX + camSize, camPosY + camSize))
  end
end

---Draws the header of the chat window.
local function drawHeader()
  local headerHeight = 100
  local cornerRadius = 30

  ui.drawRectFilled(scaleVec2(11, 9, true), scaleVec2(app.size.x - 11, headerHeight, true), colors.final.header, scaleNum(cornerRadius), ui.CornerFlags.Top)
  ui.drawSimpleLine(scaleVec2(11, headerHeight, true), scaleVec2(app.size.x - 11, headerHeight, true), colors.final.headerLine)

  local winHalf = scaleNum(app.size.x / 2)
  local text = 'Server Chat'
  local fontSize = scaleNum(12)

  ui.pushDWriteFont(app.font.regular)

  if app.headerTextSize == nil or app.headerTextScale ~= app.scale then
    app.headerTextSize = ui.measureDWriteText(text, fontSize)
    app.headerTextScale = app.scale
  end

  local textSize = app.headerTextSize
  if not textSize then
    ui.popDWriteFont()
    return
  end

  local textLeft = math.ceil(winHalf - textSize.x / 2)
  local textTop = scaleNum(84, true)

  ui.setCursor(vec2(textLeft, textTop))
  ui.dwriteTextAligned(text, fontSize, ui.Alignment.Start, ui.Alignment.Center, textSize, false, colors.final.elements)
  ui.popDWriteFont()

  local imgSize = scaleVec2(36, 36)
  local imgPos = scaleVec2(129, 47, true)
  local imgRounding = scaleNum(20)

  if not communities then return error('Communities table does not exist, probably caused by a broken app install.') end

  local community = communities[player.serverCommunity]
  community.ready = community.ready or ui.isImageReady(community.image)

  if community.ready then
    ui.drawImageRounded(communities[player.serverCommunity].image, imgPos, imgPos + imgSize, imgRounding, ui.CornerFlags.All)
  else
    ui.drawImageRounded(communities['default'].image, imgPos, imgPos + imgSize, imgRounding, ui.CornerFlags.All)
  end

  if app.hovered then
    if ui.rectHovered(imgPos, imgPos + imgSize) then
      ui.tooltip(app.tooltipPadding, function() ui.text(communities[player.serverCommunity].text .. '\nClick to open in Browser.') end)
      if not ui.isMouseDragging(ui.MouseButton.Left, 0) then ui.setMouseCursor(ui.MouseCursor.Hand) end
      if ui.mouseReleased(ui.MouseButton.Left) then
        playAudio(audio.keyboard.enter)
        os.openURL(communities[player.serverCommunity].url, false)
      end
    end
  end
end

---Draws the song information.
local function drawSongInfo()
  if settings.songInfo then
    if not songInfo.isPaused then
      local coverSize = scaleVec2(16, 16)
      local islandTop = scaleNum(20, true)
      local islandBottom = scaleNum(40, true)
      local coverTop = islandTop + math.floor((islandBottom - islandTop - coverSize.x) / 2)
      local imgPosX = scaleNum(app.size.x / 2 - 75)
      local imgPos = vec2(imgPosX, coverTop)
      local rounding = scaleNum(4)

      if songInfo.hasCover then
        --I'm using --[[@as ui.MediaPlayer]] here because ac.MusicData is not in the valid imageSources for some reason even though lua.lib says to pass ac.MusicData in like this.
        ui.drawImageRounded(ac.currentlyPlaying()--[[@as ui.MediaPlayer]], imgPos, imgPos + coverSize, rounding, ui.CornerFlags.All)
      else
        ui.drawImageRounded(app.images.defaultCover, imgPos, imgPos + coverSize, rounding, ui.CornerFlags.All)
      end
    end

    local fontSize = scaleNum(12)
    local pos = scaleVec2(89, 22, true)
    local textSize = scaleVec2(135, 15)
    drawSongInfoText(songInfo.final, pos, textSize, fontSize)

    if app.hovered and songInfo.final ~= '' then
      if ui.rectHovered(pos, pos + textSize, true) then
        local tooltipText = player.isOnline and 'Current Song: ' .. songInfo.artist .. ' - ' .. songInfo.title .. '\nClick to send to chat.' or 'Current Song: ' .. songInfo.artist .. ' - ' .. songInfo.title
        if not ui.isMouseDragging(ui.MouseButton.Left, 0) and player.isOnline then ui.setMouseCursor(ui.MouseCursor.Hand) end
        ui.tooltip(app.tooltipPadding, function() ui.text(tooltipText) end)
        if ui.mouseClicked(ui.MouseButton.Left) and player.isOnline then sendChatMessage("I'm currently listening to: " .. songInfo.final) end
      end
    end
  end
end

---@param t number @unix timestamp
---@return string @formatted time string
---Formats a message's timestamp for display.
local function formatMessageTimestamp(t)
  local localTime = os.date('%H:%M', t) ---@cast localTime string
  return settings.badTime and to12hTime(localTime) .. ' ' .. player.timePeriod or localTime
end

---@param message table @chat message entry
---@param usernameFontSize number @font size for the username
---@param messageFontSize number @font size for the message text
---@param timestampFontSize number @font size for the timestamp
---@param messageTime number @unix timestamp
---@param messageShowTimestamp boolean @whether this message shows a timestamp
---@param fontWeight ui.DWriteFont @font weight to measure the message text with
---@param wrapWidth number @wrap width for the message text
---@return table @cached {userNameTextSize, messageTextSize, timestampSize}
---Gets the cached text sizes for a message, measuring and caching them if needed.
local function getMessageSizes(message, usernameFontSize, messageFontSize, timestampFontSize, messageTime, messageShowTimestamp, fontWeight, wrapWidth)
  if message.cache and message.cacheGen == chat.msgCacheGen then return message.cache end

  local messageUserIndex = message[1]
  local cache = {}

  if messageUserIndex >= 0 then
    ui.pushDWriteFont(app.font.bold)
    cache.userNameTextSize = ui.measureDWriteText(message[2], usernameFontSize)
    ui.popDWriteFont()
  end

  ui.pushDWriteFont(messageUserIndex >= 0 and fontWeight or app.font.bold)
  cache.messageTextSize = ui.measureDWriteText(message[3], messageFontSize, wrapWidth)
  ui.popDWriteFont()

  if messageUserIndex >= 0 and messageShowTimestamp then
    ui.pushDWriteFont(app.font.bold)
    cache.timestampSize = ui.measureDWriteText(formatMessageTimestamp(messageTime), timestampFontSize)
    ui.popDWriteFont()
  end

  message.cache = cache
  message.cacheGen = chat.msgCacheGen
  return cache
end

---@return table @pool of positioned message entries
---@return number @number of valid entries in the pool
---@return number @total height of all messages
---Builds the message layout, reusing chat.layoutPool
local function buildMessageLayout()
  local messageFontSize = scaleNum(settings.chatFontSize)
  local usernameFontSize = scaleNum(settings.chatFontSize - 2)
  local timestampFontSize = scaleNum(settings.chatFontSize - 4)
  local usernameOffsetY = scaleNum(usernameFontSize + 13)
  local messagePadding = scaleVec2(15, 10)

  local pool = chat.layoutPool
  local entryCount = 0
  local msgDist = scaleNum(370)
  local lastDrawnUserIndex = nil
  local lastDrawnUserName = nil

  for i = 1, #chat.messages do
    local message = chat.messages[i]
    local messageUserIndex = message[1]
    local messageUserIndexLast = lastDrawnUserIndex
    local messageUsername = message[2]
    local messageUsernameLast = lastDrawnUserName
    local messageTextContent = message[3]
    local messageTime = message[4]
    local messageShowTimestamp = message[5]
    local messageIsMentioned = message[6]

    if (settings.focusMode and (messageUserIndex > 0 and not checkIfFriend(messageUsername))) or ac.DriverTags(messageUsername).muted then goto continue end

    local fontWeight = app.font.regular
    if (i == chat.latestNonServerMessage and settings.chatLatestBold) or (messageIsMentioned and messageUserIndex > 0) then fontWeight = app.font.bold end

    local wrapWidth = messageUserIndex == -1 and scaleNum(220) or scaleNum(190)
    local sizes = getMessageSizes(message, usernameFontSize, messageFontSize, timestampFontSize, messageTime, messageShowTimestamp, fontWeight, wrapWidth)
    local messageTextSize = sizes.messageTextSize or vec2(0, 0)
    local timestampSize = sizes.timestampSize or vec2(0, 0)

    entryCount = entryCount + 1
    local entry = pool[entryCount]
    if not entry then
      entry = {}
      pool[entryCount] = entry
    end

    entry.userIndex = messageUserIndex
    entry.username = messageUsername
    entry.text = messageTextContent
    entry.time = messageTime
    entry.fontWeight = fontWeight
    entry.sizes = sizes
    entry.startY = msgDist
    entry.usernameY = nil
    entry.timestampY = nil

    if messageUserIndex >= 0 then
      local showUsernameLine = (not messageUserIndexLast or messageUserIndexLast ~= messageUserIndex) or (not messageUsernameLast or messageUsernameLast ~= messageUsername)

      if showUsernameLine then
        if messageUserIndexLast and messageUserIndexLast ~= -1 then msgDist = math.ceil(msgDist - usernameOffsetY / 2) end
        entry.usernameY = msgDist
        msgDist = math.ceil(msgDist + usernameOffsetY)
      end

      msgDist = math.ceil(msgDist + messageTextSize.y)
      entry.bubbleY = msgDist

      if settings.chatShowTimestamps and messageShowTimestamp then
        entry.timestampY = msgDist
        msgDist = math.ceil(msgDist + timestampSize.y)
      end

      msgDist = math.ceil(msgDist + messagePadding.y + messagePadding.y / 2)
    else
      if lastDrawnUserIndex == nil then
        msgDist = math.ceil(msgDist - messageTextSize.y / 2)
      elseif lastDrawnUserIndex ~= messageUserIndex then
        msgDist = math.ceil(msgDist - messagePadding.y)
      end
      entry.textY = msgDist
      msgDist = math.ceil(msgDist + messageTextSize.y + messagePadding.y / 2)
    end

    entry.endY = msgDist

    lastDrawnUserIndex = messageUserIndex
    lastDrawnUserName = messageUsername

    ::continue::
  end

  return pool, entryCount, msgDist
end

---Draws the chat messages.
local function drawMessages()
  if not player.isOnline then return end

  local clipTop = scaleVec2(0, 0, true)
  local clipBottom = scaleVec2(app.size.x, 500, true)
  ui.pushClipRect(clipTop, clipBottom)

  ui.setCursor(scaleVec2(10, 100, true))
  local childSize = scaleVec2(270, 400 - chat.input.offset / app.scale)
  local entries, entryCount, totalHeight = buildMessageLayout()
  ui.setNextWindowContentSize(vec2(0, totalHeight))
  ui.childWindow('Messages', childSize, false, flags.window, function()
    local winWidth = ui.windowWidth()
    local winHalfWidth = winWidth / 2
    local messageFontSize = scaleNum(settings.chatFontSize)
    local usernameFontSize = scaleNum(settings.chatFontSize - 2)
    local timestampFontSize = scaleNum(settings.chatFontSize - 4)
    local usernameOffsetX = scaleNum(13)
    local messagePadding = scaleVec2(15, 10)
    local messageMaxWidth = scaleNum(250)
    local messageRounding = scaleNum(10)

    if #chat.messages > 0 then
      local winHeight = ui.windowHeight()
      local scrollBuffer = scaleNum(200)

      local totalHeightChanged = totalHeight ~= chat.lastTotalHeight
      chat.lastTotalHeight = totalHeight

      local hoveredAutoscroll = (not app.hovered or chat.scrollBool) or (chat.input.active and chat.input.hovered) and ui.getScrollY() ~= ui.getScrollMaxY()
      local shouldPin = (chat.wasAtBottom and totalHeightChanged) or hoveredAutoscroll
      local revealHeight = totalHeight

      if shouldPin then
        local scrollTarget = ui.getScrollMaxY()
        if math.abs(ui.getScrollY() - scrollTarget) > 1 then
          revealHeight = math.min(chat.stableHeight, totalHeight)
          ui.setScrollY(scrollTarget, false, true)
        else
          chat.stableHeight = totalHeight
        end
      else
        chat.stableHeight = totalHeight
      end

      local visibleTop = ui.getScrollY() - scrollBuffer
      local visibleBottom = ui.getScrollY() + winHeight + scrollBuffer

      for i = 1, entryCount do
        local entry = entries[i]
        local isVisible = entry.endY >= visibleTop and entry.startY <= visibleBottom and entry.endY <= revealHeight

        if isVisible then
          local sizes = entry.sizes
          local userNameTextSize = sizes.userNameTextSize
          local messageTextSize = sizes.messageTextSize
          local timestampSize = sizes.timestampSize
          local messageUsernameColor = rgbm.colors.gray
          if settings.chatUsernameColor then messageUsernameColor = chat.usernameColors[entry.username] or rgbm.colors.gray end

          if entry.userIndex == 0 then
            if entry.usernameY or entry.timestampY then
              ui.pushDWriteFont(app.font.bold)
              if entry.usernameY then
                ui.setCursor(ceilVec2(usernameOffsetX, entry.usernameY))
                ui.dwriteTextAligned(entry.username, usernameFontSize, ui.Alignment.End, ui.Alignment.Start, ceilVec2(messageMaxWidth, userNameTextSize.y), false, messageUsernameColor)
              end
              if entry.timestampY then
                ui.setCursor(ceilVec2(winWidth - timestampSize.x - scaleNum(6), entry.timestampY))
                ui.dwriteTextAligned(formatMessageTimestamp(entry.time), timestampFontSize, ui.Alignment.Start, ui.Alignment.Start, ceilVec2(timestampSize.x, timestampSize.y), true, rgbm.colors.gray)
              end
              ui.popDWriteFont()
            end

            ui.pushDWriteFont(entry.fontWeight)
            ui.setCursor(ceilVec2(winWidth - scaleNum(5), entry.bubbleY))
            ui.drawRectFilled(ui.getCursor() - ceilVec2(messageTextSize.x + messagePadding.x, messageTextSize.y + messagePadding.y), ui.getCursor(), colors.final.messageOwn, messageRounding)
            ui.setCursor(ui.getCursor() - ceilVec2(messageTextSize.x + messagePadding.x / 2, messageTextSize.y + messagePadding.y / 2))
            ui.dwriteTextAligned(entry.text, messageFontSize, ui.Alignment.Start, ui.Alignment.Start, ceilVec2(messageTextSize.x, messageTextSize.y + messageRounding), true, colors.final.messageOwnText)
            ui.popDWriteFont()
          elseif entry.userIndex > 0 then
            if entry.usernameY or entry.timestampY then
              ui.pushDWriteFont(app.font.bold)

              if entry.usernameY then
                ui.setCursor(ceilVec2(usernameOffsetX / 2, entry.usernameY))
                ui.dwriteTextAligned(entry.username, usernameFontSize, ui.Alignment.Start, ui.Alignment.Start, ceilVec2(math.min(userNameTextSize.x, messageMaxWidth), userNameTextSize.y), false, messageUsernameColor)

                if app.hovered then
                  if ui.itemHovered() then
                    ui.setMouseCursor(ui.MouseCursor.Hand)
                    if ac.getDriverName(entry.userIndex) == entry.username then ui.setDriverTooltip(entry.userIndex) end
                    chat.popup.hovered = { userIndex = entry.userIndex, username = entry.username }
                  end
                end
              end

              if entry.timestampY then
                ui.setCursor(ceilVec2(scaleNum(5), entry.timestampY))
                ui.dwriteTextAligned(formatMessageTimestamp(entry.time), timestampFontSize, ui.Alignment.Start, ui.Alignment.Start, ceilVec2(timestampSize.x, timestampSize.y), true, rgbm.colors.gray)
              end

              ui.popDWriteFont()
            end

            local bubbleColor, messageTextColor = colors.final.message, pickThemeColor(rgbm.colors.black, rgbm.colors.white)
            if checkIfFriend(entry.username) then
              bubbleColor = colors.final.messageFriend
              messageTextColor = colors.final.messageFriendText
            end

            ui.pushDWriteFont(entry.fontWeight)
            ui.setCursor(ceilVec2(messageTextSize.x + messagePadding.x + scaleNum(5), entry.bubbleY))
            ui.drawRectFilled(ui.getCursor() - ceilVec2(messageTextSize.x + messagePadding.x, messageTextSize.y + messagePadding.y), ui.getCursor(), bubbleColor, messageRounding)
            ui.setCursor(ui.getCursor() - ceilVec2(messageTextSize.x + messagePadding.x / 2, messageTextSize.y + messagePadding.y / 2))
            ui.dwriteTextAligned(entry.text, messageFontSize, ui.Alignment.Start, ui.Alignment.Start, ceilVec2(messageTextSize.x, messageTextSize.y + messageRounding), true, messageTextColor)
            ui.popDWriteFont()
          elseif entry.userIndex == -1 then
            ui.pushDWriteFont(app.font.bold)
            ui.setCursor(ceilVec2(winHalfWidth - messageTextSize.x / 2, entry.textY))
            ui.dwriteTextAligned(entry.text, messageFontSize, ui.Alignment.Center, ui.Alignment.Start, ceilVec2(messageTextSize.x, messageTextSize.y + messageRounding), true, rgbm.colors.gray)
            ui.popDWriteFont()
          end
        end
      end

      chat.wasAtBottom = (ui.getScrollMaxY() - ui.getScrollY()) < scaleNum(50)
    end

    if chat.popup.hovered then chatPlayerPopup(chat.popup.hovered.userIndex, chat.popup.hovered.username) end

    if (app.hovered and not chat.emojiPicker) and ui.mouseWheel() ~= 0 then
      local mouseWheel = (ui.mouseWheel() * -1) * (scaleNum(settings.chatScrollDistance))
      ui.setScrollY(mouseWheel, true, true)
    end
  end)
  ui.popClipRect()
end

---Draws the emoji picker button and window.
local function drawEmojiPicker()
  local buttonPos = scaleVec2(28, app.size.y - 17, true)
  local buttonSize = scaleVec2(12, 12)
  local buttonBgRad = scaleNum(12)
  local emojiSizePicker = scaleNum(20)

  ui.pushDWriteFont(app.font.regular)

  if chat.emojiCharSize == nil or chat.emojiCharSizeScale ~= app.scale then
    chat.emojiCharSize = ui.measureDWriteText('😀', emojiSizePicker)
    chat.emojiCharSizeScale = app.scale
  end
  local emojiCharSize = chat.emojiCharSize

  ui.setCursor(buttonPos)
  local cursorPos = ui.getCursor()
  ui.drawImage(app.images.emojiPicker, cursorPos - buttonSize, cursorPos + buttonSize, colors.final.emojiPicker)

  if not player.isOnline then
    ui.popDWriteFont()
    return
  end

  if app.hovered then
    chat.emojiPickerHovered = ui.rectHovered(cursorPos - buttonSize, cursorPos + buttonSize)

    if chat.emojiPickerHovered and ui.mouseReleased(ui.MouseButton.Left) then
      chat.emojiPicker = not chat.emojiPicker
      playAudio(audio.keyboard.enter)
    end

    if chat.emojiPickerHovered then
      if not ui.isMouseDragging(ui.MouseButton.Left, 0) then ui.setMouseCursor(ui.MouseCursor.Hand) end
      ui.drawEllipseFilled(buttonPos, buttonBgRad, colors.final.emojiPickerBG, 100)
    end
  end

  if not chat.emojiPicker then
    ui.popDWriteFont()
    return
  end

  local windowSize = scaleVec2(185, 235)
  local winHeight = scaleNum(app.size.y)
  local windowPosX = scaleNum(18)
  local windowPosY = winHeight - scaleNum(272) - chat.input.offset + movement.smooth

  ui.setCursor(vec2(windowPosX, windowPosY))
  ui.childWindow('EmojiPickerBG', windowSize, false, flags.emojiWindow, function()
    ui.drawRectFilled(vec2(0, 0), windowSize, colors.final.message, scaleNum(10))

    local emojiStartPos = scaleVec2(5, 5)
    local emojiOffset = scaleVec2(0, 2)
    local emojiSpacing = emojiOffset.y
    local emojisPerRow = 6
    local emojiCount = #chat.emojis
    local bottomPadding = scaleNum(8)

    ui.setCursor(emojiStartPos)
    ui.beginGroup(windowSize.x)

    for i = 1, emojiCount do
      local itemCursor = ui.getCursor()
      if ui.rectHovered(itemCursor, itemCursor + emojiCharSize) then
        chat.emojiPickerHovered = true
        if not ui.isMouseDragging(ui.MouseButton.Left, 0) then ui.setMouseCursor(ui.MouseCursor.Hand) end
        ui.drawRectFilled(itemCursor + (emojiOffset / 2), itemCursor + emojiCharSize + (emojiOffset / 2), colors.iMessageSelected, scaleNum(5))
      end

      ui.beginOutline()
      ui.dwriteText(chat.emojis[i], emojiSizePicker)
      ui.endOutline(colors.transparent.black10, scaleNum(2))

      if ui.itemClicked(ui.MouseButton.Left, true) then
        playAudio(audio.keyboard.keystroke)
        if not chat.input.active then chat.input.active = true end
        if chat.input.text == chat.input.placeholder then chat.input.text = '' end
        chat.input.text = chat.input.text .. chat.emojis[i]
      end

      ui.sameLine(0, emojiSpacing)
      if i % emojisPerRow == 0 and i ~= emojiCount then ui.newLine(emojiSpacing) end
    end

    ui.newLine(bottomPadding)
    ui.endGroup()
  end)

  ui.popDWriteFont()
end

---Draws the custom input box for the chat.
local function drawInputCustom()
  local inputSize = scaleVec2(235, 32 + chat.input.offset / app.scale)
  local inputBoxSize = scaleVec2(230, 27 + chat.input.offset / app.scale)
  local inputFontSize = scaleNum(settings.chatFontSize)
  local inputWrap = scaleNum(190)

  local winHeight = scaleNum(app.size.y)
  local posX = scaleNum(42)
  local posY = winHeight - scaleNum(32) - chat.input.offset + movement.smooth

  ui.setCursor(vec2(posX, posY))
  ui.childWindow('ChatInput', inputSize, false, flags.input, function()
    ui.beginOutline()
    ui.drawRectFilled(scaleVec2(2, 2), inputBoxSize, colors.final.display, scaleNum(10))
    ui.endOutline(pickThemeColor(colors.transparent.black10, colors.transparent.white10), math.max(1, math.round(1 * app.scale, 1)))

    local displayText = ''

    ui.pushDWriteFont(app.font.regular)

    if player.isOnline then
      chat.input.hovered = ui.windowHovered(ui.HoveredFlags.RectOnly)
      local inputClicked = chat.input.hovered and ui.mouseClicked(ui.MouseButton.Left)

      if chat.input.hovered then ui.setMouseCursor(ui.MouseCursor.TextInput) end

      if not chat.input.sendHovered then
        if inputClicked or chat.mentioned ~= '' then
          if not chat.input.active then chat.input.text = '' end
          chat.input.active = true
          if chat.emojiPicker then chat.emojiPicker = false end
        elseif ui.mouseClicked(ui.MouseButton.Left) and not chat.emojiPickerHovered and not chat.input.hovered then
          chat.input.active = false
          chat.input.text = chat.input.placeholder
          chat.input.selected = nil
          chat.input.historyIndex = 0
          chat.emojiPicker = false
        end
      end

      if chat.input.active then
        handleKeyboardInput()
        colors.final.input:set(pickThemeColor(rgbm.colors.black, rgbm.colors.white))
        if chat.mentioned ~= '' and chat.input.text ~= chat.mentioned then chat.mentioned = '' end
      else
        chat.input.text = chat.input.placeholder
        colors.final.input:set(pickThemeColor(colors.transparent.black50, colors.transparent.white50))
      end

      displayText = chat.input.text

      if chat.input.active and math.floor(os.clock() * 2) % 2 == 0 then
        local textSize = ui.measureDWriteText(displayText, inputFontSize, inputWrap).y
        local withCaret = ui.measureDWriteText(displayText .. '|', inputFontSize, inputWrap).y

        if withCaret > textSize then inputWrap = inputWrap + scaleNum(4) end

        displayText = displayText .. '|'
      end
    else
      displayText = chat.input.placeholder
    end

    if chat.input.selected then
      local selectedTextSize = ui.measureDWriteText(chat.input.text, inputFontSize, inputWrap) + scaleVec2(4, 0)
      ui.setCursor(scaleVec2(8, 6))
      ui.drawRectFilled(ui.getCursor(), ui.getCursor() + selectedTextSize, colors.iMessageSelected)
    end

    local inputTextSize = ui.measureDWriteText(displayText, inputFontSize, inputWrap):max(vec2(0, scaleNum(17.291)))
    ui.setCursor(scaleVec2(10, 5))
    ui.pushClipRect(ui.getCursor(), ui.getCursor() + inputBoxSize - scaleVec2(0, 9) + vec2(0, true))
    ui.dwriteTextAligned(displayText, inputFontSize, ui.Alignment.Start, ui.Alignment.End, inputTextSize, true, colors.final.input)
    ui.popDWriteFont()
    ui.popClipRect()

    if not player.isOnline then return end

    if chat.input.text ~= chat.input.placeholder and chat.input.text ~= '' then
      local circleRad = scaleNum(10)
      local circlePadding = circleRad + scaleNum(2)
      local arrowRad = scaleVec2(7, 7)
      local buttonColor = rgbm():set(colors.iMessageBlue)

      ui.setCursor(vec2(inputBoxSize.x - circlePadding, inputBoxSize.y - circlePadding))

      if app.hovered then
        chat.input.sendHovered = ui.rectHovered(ui.getCursor() - vec2(circleRad, circleRad), ui.getCursor() + vec2(circleRad, circleRad))

        if chat.input.sendHovered then
          ui.setMouseCursor(ui.MouseCursor.Hand)
          buttonColor:mul(rgbm(0.6, 0.6, 0.8, 1))

          if ui.mouseClicked(ui.MouseButton.Left) then
            sendChatMessage()
            chat.emojiPicker = false
            chat.input.sendHovered = false
          end
        end
      end

      ui.drawCircleFilled(ui.getCursor(), circleRad, buttonColor, 25)
      ui.drawIcon(ui.Icons.ArrowUp, ui.getCursor() - arrowRad, ui.getCursor() + arrowRad, rgbm.colors.white)
    end

    chat.input.offset = math.min(math.floor(inputTextSize.y - scaleNum(17)), scaleNum(390))
  end)
end

--#endregion

--#region APP UPDATER

local Updater = require('updater/universal')
local Communities = require('updater/communities')

local appFolder = ac.getFolder(ac.FolderID.ScriptOrigin) .. '\\'
local carKeyFile = #io.scanDir(appFolder, '*.carkey') > 0

Updater.init {
  onUpdateAvailable = function() sendAppMessage('Update Available!\nInstall via App Settings') end,
  onCheckComplete = function() Communities.checkForUpdate(communities) end,
}

--#endregion

--#region APP EVENTS

if player.isOnline then
  ac.onChatMessage(function(message, senderCarIndex)
    local escapedMessage = message:gsub('([%(%)%.%%%+%-%*%?%[%]%^%$])', '%%%1')
    local isPlayer = senderCarIndex > -1
    local userName = ac.getDriverName(senderCarIndex) or 'Someone'
    local isFriend = userName ~= 'Someone' and checkIfFriend(userName) or false
    local isMentioned = message:lower():find('%f[%a_]' .. player.driverName:lower() .. '%f[%A_]')
    local hideMessage = matchMessage(isPlayer, escapedMessage) and (isPlayer and settings.chatHideAnnoying or settings.chatHideKickBan)

    if not hideMessage and message:len() > 0 then
      deleteOldestMessages()

      if isPlayer then getDriverColor(senderCarIndex) end

      local currentTime = os.time()
      local currentTimeString = os.date('%H:%M', currentTime)

      table.insert(chat.messages, { senderCarIndex, isPlayer and userName or 'Server', message, currentTime, false, isMentioned })

      for i = #chat.messages, 1, -1 do
        local msg = chat.messages[i]
        if msg[1] == senderCarIndex and msg[4] and os.date('%H:%M', msg[4]) == currentTimeString then
          msg[5] = i == #chat.messages
        else
          break
        end
      end

      if not settings.focusMode or isFriend or not isPlayer then moveAppUp() end

      if senderCarIndex ~= -1 then
        local prevLatestMsg = chat.messages[chat.latestNonServerMessage]
        if prevLatestMsg then prevLatestMsg.cache = nil end
        chat.latestNonServerMessage = #chat.messages
      end

      if isPlayer then
        if senderCarIndex == 0 then
          playAudio(audio.message.send)
        else
          if isFriend or settings.messagesNonFriends then playAudio(audio.message.receive) end
          if (isFriend and settings.notificationsFriendMessages) or (isMentioned and settings.notificationsMentions) then setTimeout(function() playAudio(audio.notification.regular) end, audio.notification.timeout) end
        end
      else
        if settings.messagesServer then playAudio(audio.message.receive) end
      end
    end

    return false
  end)

  ---@param connectedCarIndex number @Car index of the car that joined/left
  ---@param action string @joined/left string
  ---Adds system messages for join/leave events.
  local function connectionHandler(connectedCarIndex, action)
    local car = ac.getCar(connectedCarIndex)
    local userName = ac.getDriverName(connectedCarIndex) or 'A Player'

    if userName ~= 'A Player' and car then
      if action == ' joined' and not car.isHidingLabels then nonTrafficPlayers[userName] = true end
    end

    local isFriend = userName ~= 'A Player' and checkIfFriend(userName) or false
    local hideNonFriend = settings.connectionEventsFriendsOnly and not isFriend
    local hideTraffic = settings.connectionEventsHideTraffic and not nonTrafficPlayers[userName]

    if not hideTraffic and not hideNonFriend then
      deleteOldestMessages()
      table.insert(chat.messages, { -1, 'Server', userName .. action .. ' the Server', os.time() })

      if settings.messagesServer and (settings.messagesNonFriends or isFriend) then playAudio(audio.message.receive) end
      if settings.notificationsFriendConnections and isFriend then setTimeout(function() playAudio(audio.notification.regular) end, audio.notification.timeout) end

      moveAppUp()
    end

    if userName ~= 'A Player' and car then
      if action == ' left' then nonTrafficPlayers[userName] = nil end
    end
  end

  ac.onClientConnected(function(connectedCarIndex)
    if settings.connectionEvents then connectionHandler(connectedCarIndex, ' joined') end
  end)

  ac.onClientDisconnected(function(connectedCarIndex)
    if settings.connectionEvents then connectionHandler(connectedCarIndex, ' left') end
  end)

  --Before CSP 0.3.0p110 (3637) the onOnlineWelcome event was broken and returned a empty string
  if player.cspVersion >= 3637 then ac.onOnlineWelcome(function(message, config) sendAppMessage(message) end) end
end

---Function to be called once when window opens, defined in `manifest.ini` as `FUNCTION_ON_SHOW = onShowWindow`
---@diagnostic disable-next-line: lowercase-global
function onShowWindow()
  Updater.checkVersion()
  updateColors()
  updateSongInfo(true)
  loadEmojis()
  getNonTrafficPlayers()

  if settings.focusMode then settings.focusMode = false end

  if Updater.state.updateStatus == 5 then sendAppMessage('Update Available!\nInstall via App Settings') end

  chat.msgCacheGen = chat.msgCacheGen + 1

  player.serverCommunity = getServerCommunity()
end

--#endregion

--#region APP SETTINGS WINDOW

function script.windowMainSettings()
  ui.tabBar('TabBar', function()
    ui.tabItem('Update', function() Updater.drawUI() end)

    ui.tabItem('App', function()
      ui.indent()

      settingsSlider('appScale', 0.5, 2, 'App Scale: %.01f%', nil, function(newVal)
        moveAppUp()
        local roundedNewScale = math.round(newVal, 1)
        settings.appScale = roundedNewScale
        app.scale = roundedNewScale
        app.images.phoneAtlasSize = ui.imageSize(app.images.phoneAtlasPath):div(vec2(2, 2)):scale(app.scale)
        chat.msgCacheGen = chat.msgCacheGen + 1
      end)

      ui.unindent()

      settingsCheckbox('Dark Mode', 'darkMode', 'If enabled, app will use dark mode.', function(newVal)
        if newVal then settings.darkModeAuto = false end
        updateColors()
      end)

      if not settings.darkMode then
        settingsCheckbox('Automatic Light/Dark Mode', 'darkModeAuto', 'If enabled, app will automatically switch between dark/light mode.', function(newVal) updateColors() end)

        if settings.darkModeAuto then
          ui.indent()
          if player.cspVersion >= 3459 then
            ui.text('Current Sun Angle: ' .. math.round(ac.getSunAngle(), 1) .. '°')

            settingsSlider('darkModeAutoDarkAngle', 0, 180, 'Evening Sun Angle: %.0f°', 'Sun angle at which the app will switch to dark mode.\nLower values mean earlier in the day.')
            settingsSlider('darkModeAutoLightAngle', 0, 180, 'Morning Sun Angle: %.0f°', 'Sun angle at which the app will switch to light mode.\nLower values mean later in the day.')
          else
            local sim = ac.getSim()
            ui.text(string.format('Current Time: %02d:%02d', sim.timeHours, sim.timeMinutes))

            local darkVal = math.floor(settings.darkModeAutoDarkTime * 2 + 0.5)
            local darkTimeStr = string.format('Dark Mode After: %02d:%02d', math.floor(darkVal / 2), (darkVal % 2) * 30)
            settings.darkModeAutoDarkTime = ui.slider('##darkModeAutoDarkTime', darkVal, 0, 47, darkTimeStr, true) / 2
            lastItemHoveredTooltip('The time at which the app will switch to dark mode.')

            local lightVal = math.floor(settings.darkModeAutoLightTime * 2 + 0.5)
            local lightTimeStr = string.format('Light Mode After: %02d:%02d', math.floor(lightVal / 2), (lightVal % 2) * 30)
            settings.darkModeAutoLightTime = ui.slider('##darkModeAutoLightTime', lightVal, 0, 47, lightTimeStr, true) / 2
            lastItemHoveredTooltip('The time at which the app will switch to light mode.')
          end
          ui.unindent()
        end
      end

      settingsCheckbox('Force App to Bottom', 'forceBottom', 'If enabled, app will be forced to the bottom of the screen.')

      settingsCheckbox('Use 12h Clock', 'badTime', 'If enabled, uses 12 hour time format.\nMessage timestamps will include AM/PM.', function() chat.msgCacheGen = chat.msgCacheGen + 1 end)

      settingsCheckbox('Show Music Information', 'songInfo', 'If enabled, shows current song information if detected.\nCheck your CSP Music settings if there are issues.', function(newVal)
        if not newVal then
          songInfo.final = ''
          songInfo.artist = ''
          songInfo.title = ''
          songInfo.isPaused = false
          setDynamicIslandSize(false)
        end
      end)

      if settings.songInfo then
        ui.indent()
        settingsCheckbox('Always Scroll Text', 'songInfoscrollAlways', 'If enabled, will scroll text even if it could be displayed statically.', function() updateSongInfo(true) end)

        settingsCheckbox('Hide Selfie Camera', 'hideCamera', 'If enabled, will hide the selfie camera below the song information.')

        settingsSlider('songInfoSpacing', 0, 300, 'Spacing: %.0f', 'The amount of spacing between the end and start of the song.', nil, true)
        settingsSlider('songInfoScrollSpeed', 1, 300, 'Scroll Speed: %.0f', 'Speed that the text is scrolled at.')

        local scrollDirStr = settings.songInfoScrollDirection == 0 and 'Left' or 'Right'
        settings.songInfoScrollDirection = ui.slider('##songInfoScrollDirection', settings.songInfoScrollDirection, 0, 1, 'Scroll Direction: ' .. scrollDirStr, true)
        ui.unindent()
      end
    end)

    ui.tabItem('Chat', function()
      ui.indent()

      settingsSlider('chatFontSize', 6, 36, 'Chat Fontsize: %.0f', nil, function() chat.msgCacheGen = chat.msgCacheGen + 1 end)
      settingsSlider('chatScrollDistance', 1, 100, 'Chat Scroll Distance: %.0f', 'Distance to scroll the chat per mousewheel scroll.')

      ui.unindent()

      settingsCheckbox('Chat Inactivity Minimizes Phone', 'appMove', 'If enabled, the app will move down to free screen space.', function(newVal)
        if newVal then
          movement.up = false
          movement.timer = settings.appMoveTimer
        end
      end)

      if settings.appMove then
        ui.indent()

        settingsSlider('appMoveTimer', 1, 120, 'Inactivity: %.0f seconds', 'Time before app moves down.', function(newVal) movement.timer = newVal end)

        settingsSlider('appMoveSpeed', 1, 20, 'Speed: %.0f', 'How fast the app should move up/down.')

        ui.unindent()
      end

      settingsCheckbox('Chat History Settings', 'chatPurge', 'If enabled, allows you to change the chat message history settings.')

      if settings.chatPurge then
        ui.indent()

        settingsSlider('chatKeepSize', 10, 500, 'Always keep %.0f Messages')
        settingsSlider('chatOlderThan', 1, 60, 'Remove if older than %.0f min')

        ui.unindent()
      end

      settingsCheckbox('Use Colored Usernames', 'chatUsernameColor', 'If enabled, uses colored usernames if possible.\nServers can overwrite CM tag colors.')

      settingsCheckbox('Show Timestamps', 'chatShowTimestamps', 'If enabled, shows message timestamps.')

      settingsCheckbox('Show Join/Leave Messages', 'connectionEvents', 'If enabled, shows server message when a player joins/leaves the server.')
      if settings.connectionEvents then
        ui.indent()

        settingsCheckbox('Hide Traffic', 'connectionEventsHideTraffic', 'If enabled, hides join/leave messages of hidden AssettoServer traffic cars.')
        settingsCheckbox('Friends Only', 'connectionEventsFriendsOnly', 'If enabled, only shows join/leave messages of friends.')

        ui.unindent()
      end

      settingsCheckbox('Highlight Latest Message', 'chatLatestBold', 'If enabled, text of the latest message will always be bold.', function()
        local latestMsg = chat.messages[chat.latestNonServerMessage]
        if latestMsg then latestMsg.cache = nil end
      end)

      settingsCheckbox('Hide Kick Ban Messages', 'chatHideKickBan', 'If enabled, hides kick and ban messages from other players.')

      settingsCheckbox('Hide Annoying Messages', 'chatHideAnnoying', 'If enabled, hides annoying messages from apps such as Pit Lane Penalty and Real Penalty.')

      if settings.chatHideAnnoying then
        ui.indent()

        settingsCheckbox('Include AssettoServer Race Challenge Messages', 'chatHideRaceMsg', 'If enabled, also hides "X just beat Y in a Race." server messages.')

        ui.unindent()
      end
    end)

    ui.tabItem('Audio', function()
      settingsCheckbox('Enable Audio', 'enableAudio', 'Toggles all app audio.')

      ui.indent()
      if settings.enableAudio then
        settingsCheckbox('Enable Keystroke Audio', 'enableKeyboard', 'Toggles keystroke sounds when typing.')

        if settings.enableKeyboard then
          ui.indent()

          settingsSlider('volumeKeyboard', 0.1, 10, 'Keystroke Volume: %.1f')

          if ui.modernButton('Play Test Keystroke', 0, ui.ButtonFlags.None, nil, modernButtonOffset(), nil) then playTestAudio(audio.keyboard) end

          ui.unindent()
        end

        settingsCheckbox('Enable Message Audio', 'enableMessage', 'Toggles message sounds.')

        if settings.enableMessage then
          ui.indent()

          settingsSlider('volumeMessage', 0.1, 10, 'Message Volume: %.1f')

          if ui.modernButton('Play Test Message', 0, ui.ButtonFlags.None, nil, modernButtonOffset(), nil) then playTestAudio(audio.message) end

          settingsCheckbox('Non-Friend Messages', 'messagesNonFriends', 'Plays message received sound for messages from non-friends.')
          settingsCheckbox('Server Messages', 'messagesServer', 'Plays message received sound for messages from the server.')

          ui.unindent()
        end

        settingsCheckbox('Enable Notification Audio', 'enableNotification', 'Toggles notification sounds.')

        if settings.enableNotification then
          ui.indent()

          settingsSlider('volumeNotification', 0.1, 10, 'Notification Volume: %.1f')

          if ui.modernButton('Play Test Notification', 0, ui.ButtonFlags.None, nil, modernButtonOffset(), nil) then playTestAudio(audio.notification) end

          settingsCheckbox('@' .. player.driverName .. ' mentions', 'notificationsMentions', 'Plays notification when you are mentioned in chat.')
          settingsCheckbox('Friend Messages', 'notificationsFriendMessages', 'Plays notification when friend sends a chat message.')
          if settings.connectionEvents then settingsCheckbox('Friend Join/Leave', 'notificationsFriendConnections', 'Plays notification when friend joins/leaves the server.') end

          ui.unindent()
        end
      end
    end)

    ui.tabItem('Coloring', function()
      settingsCheckbox('Enable Custom Coloring', 'customColor', 'If enabled, allows you to recolor certain elements.', function() updateColors() end)

      if settings.customColor then
        local colorPickerWidth = 132 * ac.getUI().uiScale
        ui.columns(2, false)
        ui.text('Message Color Own')
        ui.setNextItemWidth(colorPickerWidth)
        local messageColorSelfChange = ui.colorPicker('Display Color Picker', settings.messageColorSelf, flags.colorpicker)
        if ui.modernButton('Reset to default' .. '\u{200B}', 0, ui.ButtonFlags.None, nil, modernButtonOffset(), nil) then
          settings.messageColorSelf = colors.iMessageBlue:clone()
          updateColors()
        end

        ui.nextColumn()

        ui.text('Message Color Friends')
        ui.setNextItemWidth(colorPickerWidth)
        local messageColorFriendChange = ui.colorPicker('Text Color Picker', settings.messageColorFriend, flags.colorpicker)
        if ui.modernButton('Reset to default' .. '\u{200C}', 0, ui.ButtonFlags.None, nil, modernButtonOffset(), nil) then
          settings.messageColorFriend = colors.iMessageGreen:clone()
          updateColors()
        end

        if messageColorFriendChange or messageColorSelfChange then
          settings.messageColorSelf = settings.messageColorSelf:clone()
          settings.messageColorFriend = settings.messageColorFriend:clone()
          updateColors()
        end
      end
    end)

    if carKeyFile then
      ui.tabItem('Focus Mode', function()
        ui.textColored('IF YOU ENABLE THIS I WILL TAKE NO RESPONSIBILITY\nWHEN YOU IGNORE ADMIN MESSAGES AND GET BANNED', rgbm.colors.red)

        settingsCheckbox('Enable Focus Mode', 'focusMode', 'If enabled, only displays messages from yourself, friends and the server.')
      end)
    end
  end)
end

--#endregion

--#region APP MAIN WINDOW

function script.windowMain(dt)
  app.images.ready = app.images.ready or ui.isImageReady(app.images.phoneAtlasPath)
  if not app.images.ready then return end

  local rounded = math.round(settings.appScale, 1)
  settings.appScale = settings.appScale ~= rounded and rounded or settings.appScale
  app.scale = app.scale ~= settings.appScale and settings.appScale or app.scale

  if app.size == vec2(0, 0) or app.images.phoneAtlasSize == vec2(0, 0) then
    local phoneFull = ui.imageSize(app.images.phoneAtlasPath)
    app.size = app.size == vec2(0, 0) and vec2(phoneFull.x / 4, phoneFull.y / 2) or app.size
    app.images.phoneAtlasSize = app.images.phoneAtlasSize == vec2(0, 0) and phoneFull:div(vec2(2, 2)):scale(app.scale) or app.images.phoneAtlasSize
  end

  updateAppMovement(dt)
  automaticModeSwitch()
  updateSongInfo()

  app.hovered = ui.windowHovered(bit.bor(ui.HoveredFlags.AllowWhenBlockedByPopup, ui.HoveredFlags.ChildWindows, ui.HoveredFlags.AllowWhenBlockedByActiveItem))
  if app.hovered or chat.input.active then moveAppUp() end

  if settings.forceBottom then forceAppToBottom() end

  ui.childWindow('Phone', vec2(app.images.phoneAtlasSize.x / 2, app.images.phoneAtlasSize.y), false, flags.window, function()
    drawDisplay()
    drawHeader()
    drawTime()
    drawPing()
    drawDynamicIsland()
    drawSongInfo()
    drawMessages()
    drawEmojiPicker()
    drawInputCustom()
    drawiPhone()
  end)
end

--#endregion
