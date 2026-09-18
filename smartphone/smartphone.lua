--made by C1XTZ
--if you're reading any of this let me preface this by saying: If you're going: what the fuck is this idiot doing?? its likely that I said the same thing while writing it.

ui.setAsynchronousImagesLoading(true)

--#region APP PERSISTENT SETTINGS

local settings = ac.storage {
  appScale = 1,

  darkMode = false,
  darkModeAuto = false,
  darkModeAutoDarkTime = 19,
  darkModeAutoLightTime = 9,

  forceBottom = true,
  focusMode = false,

  appMove = false,
  appMoveTimer = 10,
  appMoveSpeed = 10,

  use12HourClock = false,

  songInfo = false,
  songInfoSpacing = 30,
  songInfoScrollSpeed = 30,
  songInfoScrollDirection = 0,
  songInfoScrollAlways = false,
  songInfoGradient = true,
  songInfoGradientIntensity = 1,
  songInfoGradientWidth = 5,
  songInfoHidesCamera = true,
  songInfoAutoSpacing = false,

  chatKeepSize = 500,
  chatOlderThan = 15,
  chatScrollDistance = 20,
  chatShowTimestamps = false,
  chatHistorySettings = false,
  chatFontSize = 13,
  chatHideKickBan = false,
  chatHideAnnoying = true,
  chatHideRaceMsg = false,
  chatLatestBold = false,
  chatUsernameColor = true,

  connectionEvents = true,
  connectionEventsFriendsOnly = false,
  connectionEventsHideTraffic = true,

  notifBannerEnabled = true,
  notifBannerMessages = true,
  notifBannerConnections = true,
  notifBannerCarName = true,
  notifBannerDuration = 5,
  notifBannerHideWhenAppUp = true,
  notifBannerFullRaise = false,
  notifBannerServerPriority = false,

  enableAudio = true,
  enableKeyboard = true,
  enableMessage = true,
  enableNotification = true,
  volumeKeyboard = 1,
  volumeMessage = 1,
  volumeNotification = 1,
  messagesFriendsOnly = false,
  messagesServer = true,
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
    displayLight = rgbm(1, 1, 1, 0),
    displayDark = rgbm(0, 0, 0, 0),
  },
  footerText = rgbm(0.5, 0.5, 0.5, 1),
  glowColor = rgbm(1, 1, 1, 0.65),
  displayColorLight = rgbm.colors.white,
  displayColorDark = rgbm.colors.black,
  outlineColorLight = rgbm(0.77, 0.77, 0.77, 1),
  outlineColorMedium = rgbm(0.27, 0.27, 0.27, 1),
  outlineColorDark = rgbm(0.2, 0.2, 0.2, 1),
  iMessageBlue = rgbm(0, 0.49, 1, 1),
  iMessageLightGray = rgbm(0.85, 0.85, 0.85, 1),
  iMessageDarkGray = rgbm(0.15, 0.15, 0.15, 1),
  iMessageGreen = rgbm(0.2, 0.75, 0.3, 1),
  iMessageSelected = rgbm(0, 0.49, 1, 0.33),
  emojiPickerButtonLight = rgbm(0, 0, 0, 0.33),
  emojiPickerButtonDark = rgbm(1, 1, 1, 0.33),
  notifBgColorLight = rgbm(0.88, 0.88, 0.88, 1),
  notifBgColorDark = rgbm(0.1, 0.1, 0.1, 1),
  notifBgBlurColorLight = rgbm(1, 1, 1, 1),
  notifBgBlurColorDark = rgbm(0.33, 0.33, 0.33, 1),
  notifTitleColorLight = rgbm(0, 0, 0, 0.66),
  notifTitleColorDark = rgbm(1, 1, 1, 0.33),
  communityAverage = rgbm(),
  final = {
    display = rgbm(),
    displayTransp = rgbm(),
    outline = rgbm(),
    elements = rgbm(),
    contactPill = rgbm(),
    contactOutline = rgbm(),
    message = rgbm(),
    messageOwn = rgbm(),
    messageOwnText = rgbm(),
    messageFriend = rgbm(),
    messageFriendText = rgbm(),
    input = rgbm(),
    emojiPicker = rgbm(),
    emojiPickerOutline = rgbm(),
    emojiPickerActive = rgbm(),
    notifBg = rgbm(),
    notifBgBlur = rgbm(),
    notifTitle = rgbm(),
  },
}

local app = {
  scale = 1,
  size = vec2(0, 0),
  hovered = false,
  canvas = { update = { message = true, emoji = true }, messageFade = nil, messageFadeSize = vec2(0, 0), emojiFade = nil, emojiFadeSize = vec2(0, 0) },
  tooltipPadding = vec2(5, 5),
  contactText = {
    size = nil,
    scale = nil,
  },
  clockText = {
    size = nil,
    scale = nil,
  },
  popupNewlineOffset = -18,
  modernButtonOffset = -8,
  settingsIndentOffset = 25,
  images = {
    phoneAtlasPath = '.\\src\\img\\phone.png',
    phoneAtlasSize = vec2(),
    phoneCamera = '.\\src\\img\\cam.png',
    pingAtlasPath = '.\\src\\img\\connection.png',
    emojiIcons = '.\\src\\img\\emojipicker.png',
    defaultCover = '.\\src\\img\\player.png',
    defaultMessage = '.\\src\\img\\messages.png',
    ready = false,
  },
  font = {
    regular = ui.DWriteFont('Inter Variable Text', '.\\src\\ttf'):weight(ui.DWriteFont.Weight.Medium),
    semiBold = ui.DWriteFont('Inter Variable Text', '.\\src\\ttf'):weight(ui.DWriteFont.Weight.SemiBold),
    bold = ui.DWriteFont('Inter Variable Text', '.\\src\\ttf'):weight(ui.DWriteFont.Weight.Bold),
  },
}

local function updateFadeCanvas()
  app.canvas.update.message = true
  app.canvas.update.emoji = true
end

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
  notifDistance = 145,
  notifTailDelay = 0.35,
  forceFullUp = true,
  timer = settings.appMoveTimer,
  notifTailTimer = 0.35,
  down = true,
  up = false,
  distance = 0,
  smooth = 0,
}

local notification = {
  maxDistance = 90,
  duration = settings.notifBannerDuration,
  speed = 1.5,
  queue = {},
}

local time = {
  cached = {
    minute = -1,
    format = nil,
    text = '',
    period = '',
  },
}

local songInfo = {
  artist = '',
  title = '',
  final = '',
  hasCover = false,
  isNotPlaying = false,
  dynamicIslandSizeActive = vec2(40, 20),
  dynamicIslandBaseWidths = vec2(40, 80),
  cached = {
    size = nil,
    text = nil,
    scale = nil,
  },
  scrollTime = 0,
  titleSplitPatterns = {
    '^(.-)%s*%- %s*(.+)$',
    '^(.-)%-([^%-]+)$',
  },
}

local chat = {
  messages = {},
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
    mentioned = '',
    sendCooldown = false,
  },
  hideStrings = {
    player = {
      '^RP: App not running$',
      '^PLP: running version',
      '^ACP: App not active$',
      '^D&O Racing APP:',
      '^DRIFT%%%-STRUCTION POINTS:',
      '^OSRW Race Admin Version:',
      '^RSRC Race Admin',
    },
    server = {
      'kicked',
      'banned',
      'checksums',
      'teleported to pits',
    },
  },
  popup = {
    hovered = nil,
  },
  scroll = {
    stickyHeight = 0,
    wasAtBottom = true,
    lastTotalHeight = 0,
    forceAutoscroll = false,
  },
  userNameColors = {},
  latestUserMessage = nil,
  msgCacheGen = 0,
  layout = {
    messages = {},
    cacheGen = -1,
    messageCount = 0,
    totalHeight = 0,
    oldRawCount = 0,
    pendingRemoveCount = 0,
    forceFullRebuild = false,
    oldLatestUserMessage = nil,
    appliedSettings = {
      latestBold = nil,
      fontSize = nil,
      showTimestamps = nil,
      use12HourClock = nil,
      scale = nil,
      focusMode = nil,
    },
  },
}

local emoji = {
  picker = false,
  pickerHovered = false,
  char = {
    size = nil,
    scale = nil,
  },
  groups = {},
  activeGroup = 1,
  activeGroupDrawn = 0,
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
local function moveAppUp(full)
  if settings.appMove then
    if full then movement.forceFullUp = true end
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
local function format12HourTime(timeString)
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
    if data.ips then
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

---Creates a checkbox bound to a settings field, with optional change callback and tooltip.
---@param label string Checkbox label.
---@param key string Name of the boolean field in the `settings` table.
---@param tooltip? string Tooltip text (optional).
---@param onChange? fun(newValue: boolean) Called after the value changes.
---@return boolean wasChanged True if the user toggled the checkbox.
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

---Creates a slider bound to a settings field, with optional change callback and tooltip.
---@param key string Name of the numeric field in the `settings` table.
---@param min number Minimum slider value.
---@param max number Maximum slider value.
---@param labelFormat string Format string for the displayed value (e.g., "Speed: %.0f").
---@param tooltip? string Tooltip text (optional).
---@param onChange? fun(newValue: number) Called after the value changes.
---@param power? number|boolean Power for non-linear slider, or `true` for integer mode. Default: `1` (linear).
---@return number currentValue The new (or current) value.
local function settingsSlider(key, min, max, labelFormat, tooltip, onChange, power)
  local value, changed = ui.slider('##' .. key, settings[key]--[[@as number]], min, max, labelFormat, power)
  if changed then
    settings[key] = value
    if onChange then onChange(value) end
  end
  if tooltip then lastItemHoveredTooltip(tooltip) end
  return value
end

---@param color rgbm The RGB color to calculate brightness for
---@return number brightness The perceptual brightness value (0-1, where 0 is black and 1 is white)
---Calculate perceptual brightness (0-1 range) using Rec. 709 coefficients for blue and red, halved for green.
local function getBrightness(color)
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

  return 0.2126 * lr + (0.7152 / 2) * lg + 0.0722 * lb
end

---@param index integer @Car index
---Caches the driver tag color for the specified car index.
local function getDriverColor(index)
  local name = ac.getDriverName(index)
  if not name or name == '' then return end

  local color = ac.DriverTags(name).color:clone()
  local isDefaultColor = (index == 0 and color == rgbm.colors.yellow) or (index > 0 and color == rgbm.colors.white)
  if isDefaultColor then color:set(rgbm.colors.gray) end

  local existingColor = chat.userNameColors[name]

  local shouldUpdate = (not existingColor and color ~= rgbm.colors.gray) or (existingColor and ((existingColor == rgbm.colors.gray and color ~= rgbm.colors.gray) or existingColor ~= color))

  if shouldUpdate then chat.userNameColors[name] = color end
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
  local msg = { -1, 'App', message, os.time() }
  table.insert(chat.messages, msg)
  chat.msgCacheGen = chat.msgCacheGen + 1
  moveAppUp()

  if deleteAfter then
    setTimeout(function()
      for i = 1, #chat.messages do
        if chat.messages[i] == msg then
          table.remove(chat.messages, i)
          chat.msgCacheGen = chat.msgCacheGen + 1
          chat.layout.forceFullRebuild = true
          break
        end
      end
    end, deleteAfter)
  end
end

---Loads emojis from src/emj/emojis.txt, fully supporting emoji grapheme clusters, and groups them by category.
---Disclosure: this piece of shit was written by Claude, it is black magic to me.
local function loadEmojis()
  local path = ac.getFolder(ac.FolderID.ScriptOrigin) .. '\\src\\emj\\emojis.txt'
  local f = io.open(path, 'rb')
  if not f then return end

  local content = f:read('*a')
  f:close()

  local VS16 = 0xFE0F
  local ZWJ = 0x200D

  local function isContinuationByte(b) return b and b >= 0x80 and b <= 0xBF end

  local function decodeUTF8(line, pos)
    local b1 = line:byte(pos)
    if not b1 then return nil, nil end

    --Claude: ASCII
    if b1 < 0x80 then return b1, 1 end

    --Claude: 2-byte sequence
    if b1 >= 0xC2 and b1 <= 0xDF then
      local b2 = line:byte(pos + 1)

      if not isContinuationByte(b2) then return nil, nil end

      local cp = (b1 - 0xC0) * 0x40 + (b2 - 0x80)

      return cp, 2
    end

    --Claude: 3-byte sequence
    if b1 >= 0xE0 and b1 <= 0xEF then
      local b2 = line:byte(pos + 1)
      local b3 = line:byte(pos + 2)

      if not isContinuationByte(b2) or not isContinuationByte(b3) then return nil, nil end

      --Claude: Reject overlong encodings and UTF-16 surrogate range.
      if b1 == 0xE0 and b2 < 0xA0 then return nil, nil end

      if b1 == 0xED and b2 >= 0xA0 then return nil, nil end

      local cp = (b1 - 0xE0) * 0x1000 + (b2 - 0x80) * 0x40 + (b3 - 0x80)

      return cp, 3
    end

    --Claude: 4-byte sequence
    if b1 >= 0xF0 and b1 <= 0xF4 then
      local b2 = line:byte(pos + 1)
      local b3 = line:byte(pos + 2)
      local b4 = line:byte(pos + 3)

      if not isContinuationByte(b2) or not isContinuationByte(b3) or not isContinuationByte(b4) then return nil, nil end

      --Claude: Reject overlong encodings and > U+10FFFF.
      if b1 == 0xF0 and b2 < 0x90 then return nil, nil end

      if b1 == 0xF4 and b2 > 0x8F then return nil, nil end

      local cp = (b1 - 0xF0) * 0x40000 + (b2 - 0x80) * 0x1000 + (b3 - 0x80) * 0x40 + (b4 - 0x80)

      return cp, 4
    end

    return nil, nil
  end

  local function codepointToString(line, pos, len) return line:sub(pos, pos + len - 1) end

  local function isSkinTone(cp) return cp >= 0x1F3FB and cp <= 0x1F3FF end

  local function isRegionalIndicator(cp) return cp >= 0x1F1E6 and cp <= 0x1F1FF end

  local function isTag(cp) return cp >= 0xE0020 and cp <= 0xE007F end

  local function readVS16(line, pos)
    local cp, len = decodeUTF8(line, pos)

    if cp == VS16 then return pos + len, line:sub(pos, pos + len - 1) end

    return pos, ''
  end

  local function readSkinTone(line, pos)
    local cp, len = decodeUTF8(line, pos)

    if cp and isSkinTone(cp) then return pos + len, line:sub(pos, pos + len - 1) end

    return pos, ''
  end

  local function readKeycap(line, pos)
    local cp, len = decodeUTF8(line, pos)

    if cp == 0x20E3 then return pos + len, line:sub(pos, pos + len - 1) end

    return pos, ''
  end

  local function isTagEnd(cp) return cp == 0xE007F end

  --Claude: Consume subdivision flag tag sequence: 🏴 + TAG SPEC + CANCEL TAG
  local function readTagSequence(line, pos, cluster)
    local start = pos
    local tagCount = 0

    while pos <= #line do
      local cp, len = decodeUTF8(line, pos)

      if not cp or not isTag(cp) then break end

      cluster = cluster .. codepointToString(line, pos, len)
      pos = pos + len
      tagCount = tagCount + 1

      if isTagEnd(cp) then return cluster, pos end
    end

    --Claude: A tag character sequence without CANCEL TAG isn't a valid emoji tag sequence. Return bytes consumed so the caller can skip the whole partial run instead of just one byte.
    if tagCount > 0 then return nil, pos - start end

    return cluster, pos
  end

  local function getNextCluster(line, pos)
    local start = pos

    local baseCp, baseLen = decodeUTF8(line, pos)
    if not baseCp then return nil, pos - start, 'invalid UTF-8' end

    local cluster = codepointToString(line, pos, baseLen)
    pos = pos + baseLen

    --Claude: Regional Indicator pair
    if isRegionalIndicator(baseCp) then
      local cp2, len2 = decodeUTF8(line, pos)

      if not cp2 or not isRegionalIndicator(cp2) then return nil, pos - start, 'singleton regional indicator' end

      cluster = cluster .. codepointToString(line, pos, len2)
      pos = pos + len2

      return cluster, pos
    end

    --Claude: Black flag + tag sequence
    if baseCp == 0x1F3F4 then
      local taggedCluster, taggedPos = readTagSequence(line, pos, cluster)

      if taggedCluster == nil then
        --Claude: taggedPos is bytes consumed by the partial tag run;
        --Claude: add on what was consumed before it (the base flag itself).
        return nil, (pos - start) + taggedPos, 'malformed tag sequence'
      end

      if taggedPos ~= pos then return taggedCluster, taggedPos end
    end

    --Claude: VS16
    do
      local newPos, suffix = readVS16(line, pos)

      if suffix ~= '' then
        cluster = cluster .. suffix
        pos = newPos
      end
    end

    --Claude: Skin tone
    do
      local newPos, suffix = readSkinTone(line, pos)

      if suffix ~= '' then
        cluster = cluster .. suffix
        pos = newPos
      end
    end

    --Claude: Keycap
    do
      local newPos, suffix = readKeycap(line, pos)

      if suffix ~= '' then
        cluster = cluster .. suffix
        pos = newPos
      end
    end

    --Claude: ZWJ sequences
    while true do
      local cp, len = decodeUTF8(line, pos)

      if cp ~= ZWJ then break end

      cluster = cluster .. codepointToString(line, pos, len)
      pos = pos + len

      --Claude: ZWJ must be followed by another code point.
      local nextCp, nextLen = decodeUTF8(line, pos)

      if not nextCp then return nil, pos - start, 'ZWJ at end of cluster' end

      --Claude: A ZWJ element cannot itself start with another ZWJ.
      if nextCp == ZWJ then return nil, pos - start, 'consecutive ZWJ' end

      cluster = cluster .. codepointToString(line, pos, nextLen)
      pos = pos + nextLen

      --Claude: VS16 after ZWJ element.
      do
        local newPos, suffix = readVS16(line, pos)

        if suffix ~= '' then
          cluster = cluster .. suffix
          pos = newPos
        end
      end

      --Claude: Skin tone after ZWJ element.
      do
        local newPos, suffix = readSkinTone(line, pos)

        if suffix ~= '' then
          cluster = cluster .. suffix
          pos = newPos
        end
      end

      --Claude: Keycap after a ZWJ element.
      do
        local newPos, suffix = readKeycap(line, pos)

        if suffix ~= '' then
          cluster = cluster .. suffix
          pos = newPos
        end
      end
    end

    return cluster, pos
  end

  --Claude: Parse file
  local groups = {}
  local currentGroup = nil

  for line in content:gmatch('[^\r\n]+') do
    local groupName = line:match('^#%s*group:%s*(.-)%s*$')

    if groupName then
      currentGroup = {
        name = groupName,
        emojis = {},
      }

      groups[#groups + 1] = currentGroup
    elseif currentGroup and line:find('%S') then
      local pos = 1

      while pos <= #line do
        local b = line:byte(pos)

        if b <= 32 then
          pos = pos + 1
        else
          local cluster, newPos, err = getNextCluster(line, pos)

          if not cluster then
            --Claude: Don't silently accept malformed data.
            ac.log(string.format('[emoji] malformed sequence in group "%s" at byte %d: %s', currentGroup.name, pos, err or 'unknown error'))

            --Claude: Recover by skipping exactly what was consumed by the malformed run (at least 1 byte) so a broken entry can't trap the parser or spam the log per byte.
            pos = pos + math.max(1, newPos or 0)
          else
            currentGroup.emojis[#currentGroup.emojis + 1] = cluster
            pos = newPos
          end
        end
      end
    end
  end

  emoji.groups = groups
  emoji.activeGroup = math.min(emoji.activeGroup, math.max(#groups, 1))
end

---Populates the nonTrafficPlayers table with the names of players that are not hiding labels. AssettoServer traffic cars if HideAiCars is enabled for example.
local function updateNonTrafficPlayers()
  for i, car in ac.iterateCars() do
    local driverName = ac.getDriverName(i - 1)
    if driverName and driverName ~= '' and not car.isHidingLabels then nonTrafficPlayers[driverName] = true end
  end
end

---@return table? @the currently displaying notification queue
---Finds the single queue item currently sliding in/holding/sliding out.
local function getActiveNotification()
  for _, notif in ipairs(notification.queue) do
    if notif.state == 'active' then return notif end
  end
end

---@return number @the current max chat input length in characters
---Chat input max length to keep chatbox from growing too tall.
local function getInputMaxLength() return math.floor(490 * (13 / settings.chatFontSize) ^ 2) end

--- Escapes Lua pattern metacharacters in a string.
---@param s string Input string to escape.
---@return string escaped The escaped string.
---@return integer count Number of characters escaped.
local function escapePattern(s) return s:gsub('([%(%)%.%%%+%-%*%?%[%]%^%$])', '%%%1') end

--#endregion

--#region GENERAL LOGIC FUNCTIONS

---Updates the colors based on the current mode.
local function updateColors()
  colors.final.display:set(pickThemeColor(colors.displayColorLight, colors.displayColorDark))
  colors.final.displayTransp:set(pickThemeColor(colors.transparent.displayLight, colors.transparent.displayDark))
  colors.final.elements:set(pickThemeColor(colors.displayColorDark, colors.displayColorLight))
  colors.final.outline:set(pickThemeColor(colors.outlineColorLight, colors.outlineColorDark))
  colors.final.input:set(pickThemeColor(colors.transparent.black50, colors.transparent.white50))
  colors.final.message:set(pickThemeColor(colors.iMessageLightGray, colors.iMessageDarkGray))
  colors.final.contactPill:set(pickThemeColor(colors.displayColorLight, colors.iMessageDarkGray))
  colors.final.contactOutline:set(pickThemeColor(colors.outlineColorLight, colors.outlineColorMedium))

  colors.final.emojiPicker:set(pickThemeColor(colors.emojiPickerButtonLight, colors.emojiPickerButtonDark))
  colors.final.emojiPickerOutline:set(pickThemeColor(colors.transparent.black10, colors.transparent.white10))
  colors.final.emojiPickerActive:set(rgbm(0, 0.49, 1, 1))

  colors.final.notifBg:set(pickThemeColor(colors.notifBgColorLight, colors.notifBgColorDark))
  colors.final.notifBgBlur:set(pickThemeColor(colors.communityAverage:clone():mul(colors.notifBgBlurColorLight), colors.communityAverage:clone():mul(colors.notifBgBlurColorDark)))
  colors.final.notifTitle:set(pickThemeColor(colors.notifTitleColorLight, colors.notifTitleColorDark))

  colors.final.messageOwn:set(settings.customColor and settings.messageColorSelf or colors.iMessageBlue)
  colors.final.messageFriend:set(settings.customColor and settings.messageColorFriend or colors.iMessageGreen)

  colors.final.messageOwnText:set(getBrightness(colors.final.messageOwn) <= 0.225 and rgbm.colors.white or rgbm.colors.black)
  colors.final.messageFriendText:set(getBrightness(colors.final.messageFriend) <= 0.225 and rgbm.colors.white or rgbm.colors.black)

  updateFadeCanvas()
end

---@param imagePath string
---Calculates the average color of the community image, for notification banner glow
local function getAverageCommunityImageColor(imagePath)
  if colors.communityAverage ~= rgbm() then return end

  local imgSize = ui.imageSize(imagePath)
  if imgSize.x == 0 or imgSize.y == 0 then
    ac.log('Image not loaded or invalid')
    return
  end

  local canvas = ui.ExtraCanvas(imgSize, 1, render.AntialiasingMode.None)
  canvas:update(function() ui.drawImage(imagePath, vec2(0, 0), imgSize) end)
  canvas:accessData(function(err, data)
    if err then
      ac.log('Failed to access data: ' .. err)
      return
    end

    local totalR, totalG, totalB = 0, 0, 0
    local count = 0
    local w, h = data:size():unpack()

    for y = 0, h - 1 do
      for x = 0, w - 1 do
        local col = data:color(x, y)
        totalR = totalR + col.r
        totalG = totalG + col.g
        totalB = totalB + col.b
        count = count + 1
      end
    end

    local avgR = totalR / count
    local avgG = totalG / count
    local avgB = totalB / count

    colors.communityAverage = rgbm(avgR, avgG, avgB, 1)
    updateColors()

    canvas:dispose()
  end)
end

local appWindow = ac.accessAppWindow('IMGUI_LUA_Smartphone_main')

---Forces the app to be inside the visible ui space, optionally moves it to the bottom of the screen.
local function forceAppIntoScreen()
  if not appWindow or not appWindow:valid() then return end

  local pos = appWindow:position()
  local size = appWindow:size() + vec2(25, 0)
  local screen = ac.getUI().windowSize

  local targetX = math.max(0, math.min(pos.x, screen.x - size.x))
  local targetY

  if settings.forceBottom then
    targetY = screen.y - size.y
  else
    targetY = math.max(0, math.min(pos.y, screen.y - size.y))
  end

  if (pos.x ~= targetX or pos.y ~= targetY) and not ui.isMouseDragging(ui.MouseButton.Left, 0) then appWindow:move(vec2(targetX, targetY)) end
end

---@param current number @current value
---@param target number @value to move toward
---@param step number @maximum change allowed this call
---@return number @current moved toward target by up to step, without overshooting
---Moves a value toward a target by a fixed step, clamping so it never overshoots past the target.
local function moveToward(current, target, step)
  local delta = target - current
  if math.abs(delta) <= step then return target end
  return math.floor(current + (delta > 0 and step or -step))
end

---@param dt number @Delta time in seconds since last update.
local function updateAppMovement(dt)
  if not settings.appMove then
    if movement.distance ~= 0 then
      movement.distance = 0
      movement.smooth = 0
    end
    return
  end

  local scaledMaxDistance = scaleNum(movement.maxDistance)

  if app.hovered or chat.input.active then movement.forceFullUp = true end

  local isPeekRaise = settings.notifBannerEnabled and not movement.forceFullUp

  local peekDistance = 0
  if isPeekRaise and not settings.notifBannerFullRaise then
    peekDistance = scaleNum(movement.maxDistance - movement.notifDistance)
    if peekDistance < 0 then peekDistance = 0 end
  end

  local targetUpDistance = movement.forceFullUp and 0 or peekDistance
  local moveSpeedBase = (movement.forceFullUp or isPeekRaise) and 100 or 50
  local minimumStayApplies = movement.forceFullUp or settings.notifBannerFullRaise

  if movement.distance <= targetUpDistance and not movement.up then
    movement.down = true

    if movement.timer > 0 then movement.timer = movement.timer - dt end

    local minimumStayMet = not minimumStayApplies or movement.timer <= 0
    local hasNotif = getActiveNotification() ~= nil
    if minimumStayMet and not hasNotif then
      movement.notifTailTimer = movement.notifTailTimer - dt
    else
      movement.notifTailTimer = movement.notifTailDelay
    end

    if not (minimumStayMet and not hasNotif and movement.notifTailTimer <= 0) then return end

    movement.timer = 0
  end

  if movement.down and movement.timer <= 0 then
    movement.distance = math.floor(movement.distance + dt * moveSpeedBase * (settings.appMoveSpeed * app.scale))
    movement.smooth = math.floor(math.smootherstep(math.lerpInvSat(movement.distance, 0, scaledMaxDistance)) * scaledMaxDistance)

    if movement.distance >= scaledMaxDistance then
      movement.distance = scaledMaxDistance
      movement.down = false
      movement.forceFullUp = false
      movement.up = true
    end
  elseif movement.up and movement.timer > 0 then
    movement.distance = moveToward(movement.distance, targetUpDistance, dt * moveSpeedBase * (settings.appMoveSpeed * app.scale))
    movement.smooth = math.floor(math.smootherstep(math.lerpInvSat(movement.distance, 0, scaledMaxDistance)) * scaledMaxDistance)

    if movement.distance == targetUpDistance then
      movement.up = false
      movement.timer = settings.appMoveTimer
    end
  end
end

---@param title string @bold title line, e.g. the sender's username
---@param body string @message text shown below the title
---@param isServer boolean? @whether this is a server message, used for queue priority
---Queues a notification banner. With server priority off, notifications queue and show in order. With it on, user messages get gracefully skipped.
local function showNotification(title, body, isServer)
  local queue = notification.queue
  local entry = { title = title, body = body, isServer = isServer or false }
  local active = getActiveNotification()

  if not active or (settings.notifBannerServerPriority and entry.isServer and not active.isServer) then
    if active then active.state = 'covering' end
    entry.state, entry.distance, entry.smooth, entry.phase, entry.timer = 'active', 0, 0, 'in', 0
    queue[#queue + 1] = entry
    return
  end

  entry.state = 'queued'

  if settings.notifBannerServerPriority and entry.isServer then
    local insertAt = #queue + 1
    for i, s in ipairs(queue) do
      if s.state == 'queued' and not s.isServer then
        insertAt = i
        break
      end
    end
    table.insert(queue, insertAt, entry)
    return
  end

  queue[#queue + 1] = entry
end

---@param dt number @Delta time in seconds since last update.
---Updates the notification banner's slide animation.
local function updateNotifications(dt)
  local queue = notification.queue
  local notif = getActiveNotification()
  if not notif then return end

  local maxDistance = scaleNum(notification.maxDistance)

  if notif.phase == 'in' then
    notif.distance = moveToward(notif.distance, maxDistance, dt * 100 * (notification.speed * app.scale))

    if notif.distance >= maxDistance then
      notif.phase = 'hold'
      notif.timer = notification.duration
      for i = #queue, 1, -1 do
        if queue[i].state == 'covering' then table.remove(queue, i) end
      end
    end
  elseif notif.phase == 'hold' then
    notif.timer = notif.timer - dt
    if notif.timer <= 0 then notif.phase = 'out' end
  elseif notif.phase == 'out' then
    notif.distance = moveToward(notif.distance, 0, dt * 100 * (notification.speed * app.scale))

    if notif.distance <= 0 then
      for i, s in ipairs(queue) do
        if s == notif then
          table.remove(queue, i)
          break
        end
      end
      for _, s in ipairs(queue) do
        if s.state == 'queued' then
          s.state, s.distance, s.smooth, s.phase, s.timer = 'active', 0, 0, 'in', 0
          break
        end
      end
      return
    end
  end

  notif.smooth = math.floor(math.smootherstep(math.lerpInvSat(notif.distance, 0, maxDistance)) * maxDistance)
end

---@param event table @audio event table (audio.category.event)
---Plays the specified audio event.
local function playAudio(event)
  if not settings.enableAudio or not event or not event.category then return end

  local category = event.category
  local enableSetting = 'enable' .. category:sub(1, 1):upper() .. category:sub(2)
  if not settings[enableSetting] then return end

  local volumeSetting = 'volume' .. category:sub(1, 1):upper() .. category:sub(2)
  local audioEvent = ac.AudioEvent.fromFile({ filename = event.file, use3D = false, loop = false }, false)

  audioEvent.cameraInteriorMultiplier = 1
  audioEvent.cameraExteriorMultiplier = 1
  audioEvent.volume = settings[volumeSetting]
  audioEvent:start()
  setTimeout(function() audioEvent:dispose() end, audioEvent:getDuration(), 'audioEvent')
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

---Switches the phone mode automatically based on the current time.
local function automaticModeSwitch()
  if not settings.darkModeAuto then
    if player.phoneMode then
      player.phoneMode = false
      updateColors()
    end
    return
  end

  local sim = ac.getSim()
  local currentTime = sim.timeHours + sim.timeMinutes / 60
  local shouldBeDark = not (currentTime > settings.darkModeAutoLightTime and currentTime < settings.darkModeAutoDarkTime)

  if player.phoneMode ~= shouldBeDark then
    player.phoneMode = shouldBeDark
    updateColors()
  end
end

--#endregion

--#region SONG INFO FUNCTIONS

---@param expanded boolean @sets the width of the island
---Sets the width of the dynamic island.
local function setDynamicIslandSize(expanded)
  local width = expanded and songInfo.dynamicIslandBaseWidths.y or songInfo.dynamicIslandBaseWidths.x
  songInfo.dynamicIslandSizeActive:set(width, songInfo.dynamicIslandSizeActive.y)
end

---@param forced? boolean @Whether to force updating the song information even if the artist and title have not changed.
---Updates the global songInfo table with the currently playing track’s artist and title, handles cases of unknown artists or paused playback, and formats the scrolling text display.
local function updateSongInfo(forced)
  if not settings.songInfo then return end

  local current = ac.currentlyPlaying()

  if not forced and current.artist == songInfo.artist and current.title == songInfo.title and current.isPlaying == not songInfo.isNotPlaying then return end

  if (current.artist == '' and current.title == '') or not current.isPlaying then
    songInfo.final = ''

    if songInfo.dynamicIslandSizeActive.x == songInfo.dynamicIslandBaseWidths.y then setDynamicIslandSize(false) end
    songInfo.isNotPlaying = true
  else
    if (current.artist:lower() == 'unknown artist' or current.artist == '') and current.title ~= '' then
      songInfo.artist, songInfo.title = splitTitle(current.title)
    else
      songInfo.artist = current.artist
      songInfo.title = current.title
    end

    songInfo.final = (songInfo.artist ~= '' and songInfo.artist:lower() ~= 'unknown artist') and (songInfo.artist .. ' - ' .. songInfo.title) or songInfo.title
    songInfo.hasCover = current.hasCover

    if songInfo.final ~= songInfo.cached.text then songInfo.scrollTime = 0 end

    if songInfo.dynamicIslandSizeActive.x == songInfo.dynamicIslandBaseWidths.x then setDynamicIslandSize(true) end
    songInfo.isNotPlaying = not current.isPlaying
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

  if songInfo.cached.size == nil or songInfo.cached.text ~= text or songInfo.cached.scale ~= app.scale then
    songInfo.cached.size = ui.measureDWriteText(text, fontSize)
    songInfo.cached.text = text
    songInfo.cached.scale = app.scale
  end

  local textSize = songInfo.cached.size
  if not textSize then
    ui.popDWriteFont()
    return
  end

  if textSize.x <= size.x - scaleNum(12) and not settings.songInfoScrollAlways then static = true end

  if static then
    ui.setCursor(ceilVec2(pos.x, pos.y + (size.y - textSize.y) / 2))
    ui.dwriteTextAligned(text, fontSize, ui.Alignment.Center, ui.Alignment.Start, vec2(size.x, textSize.y), false, rgbm.colors.white)
  else
    local scrollSpacing = settings.songInfoAutoSpacing and size.x / 1.5 or settings.songInfoSpacing
    local scrollStepWidth = math.ceil(textSize.x + scrollSpacing)
    local scrollDirection = settings.songInfoScrollDirection == 0 and -1 or 1
    local scrollX = scrollDirection * (songInfo.scrollTime % scrollStepWidth)
    songInfo.scrollTime = songInfo.scrollTime % scrollStepWidth

    ui.pushClipRect(pos, pos + size)
    for i = -1, math.ceil(size.x / scrollStepWidth) do
      ui.dwriteDrawText(text, fontSize, ceilVec2(pos.x + scrollX + i * scrollStepWidth, pos.y + (size.y - textSize.y) / 2), rgbm.colors.white)
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
  if not chat.input.sendCooldown then
    playAudio(audio.keyboard.enter)

    ac.sendChatMessage(message or chat.input.text)

    table.insert(chat.input.history, { 0, player.driverName, chat.input.text, os.time() })
    if #chat.input.history > 15 then table.remove(chat.input.history, 1) end

    chat.input.sendCooldown = true

    if chat.input.hovered then
      chat.input.text = ''
    else
      if chat.input.mentioned ~= '' then chat.input.mentioned = '' end
      chat.input.active = false
    end

    chat.input.historyIndex = 0
    chat.scroll.forceAutoscroll = true
    setTimeout(function() chat.scroll.forceAutoscroll = false end, 0.1)
    setTimeout(function() chat.input.sendCooldown = false end, 1)
  end
end

---@param isPlayer boolean @Whether the message is from a player or the server.
---@param message string @The raw message text.
---@return string|boolean? hideReason @One of: 'annoying', 'kickban', 'race', or false.
---@return boolean shouldAlert @Whether this message should trigger a critical alert sound.
---Determines whether a message matches one of the configured filters.
local function matchMessage(isPlayer, message)
  local lowerMessage = message:lower()
  local lowerPlayerName = player.driverName:lower()
  local shouldAlert = false

  if isPlayer then
    for _, pattern in ipairs(chat.hideStrings.player) do
      if message:match(pattern) then return 'annoying', false end
    end

    return nil, false
  end

  for _, reason in ipairs(chat.hideStrings.server) do
    if lowerMessage:find(reason) then
      if lowerMessage:find(lowerPlayerName) then
        shouldAlert = true
      elseif lowerMessage:find('^you') or lowerMessage:find('^it is currently night') then
        shouldAlert = true
      else
        return 'kickban', shouldAlert
      end
    end
  end

  if lowerMessage:find('in a race%.$') and not lowerMessage:find('you') and not lowerMessage:find(lowerPlayerName) then return 'race', shouldAlert end

  return false, shouldAlert
end

---Deletes the oldest messages from the chat.
local function deleteOldestMessages()
  local currentTime = os.time()
  local index = 1
  local removedCount = 0

  while index <= #chat.messages do
    if #chat.messages > settings.chatKeepSize and currentTime - chat.messages[index][4] > (settings.chatOlderThan * 60) then
      table.remove(chat.messages, index)
      removedCount = removedCount + 1
    else
      index = index + 1
    end
  end

  if removedCount > 0 then
    chat.msgCacheGen = chat.msgCacheGen + 1
    chat.layout.pendingRemoveCount = chat.layout.pendingRemoveCount + removedCount
    if chat.latestUserMessage then chat.latestUserMessage = chat.latestUserMessage > removedCount and chat.latestUserMessage - removedCount or nil end
    local activeUserNames = {}
    for i = 1, #chat.messages do
      activeUserNames[chat.messages[i][2]] = true
    end
    for userName, _ in pairs(chat.userNameColors) do
      if not activeUserNames[userName] then chat.userNameColors[userName] = nil end
    end
  end
end

---Custom keyboard handling for input field, may god have mercy on my soul.
local function handleKeyboardInput()
  local keyboardInput = ui.captureKeyboard(false, true)
  local msgLen = utf8len(chat.input.text) > 0
  local typed = keyboardInput:queue()
  local inputMaxLength = getInputMaxLength()

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
    emoji.picker = false
    return
  elseif ui.keyboardButtonDown(ui.KeyIndex.Control) and ui.keyboardButtonPressed(ui.KeyIndex.V, true) then
    local clipboardText = ui.getClipboardText()
    if utf8len(chat.input.text .. clipboardText) > inputMaxLength then return end
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

  if utf8len(chat.input.text .. typed) > inputMaxLength then return end

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

  ---I know that ui.setDriverPopup() exists, but the "Tag in Chat" button there inserts the name into the csp chat app.
  ---Since thats probably one of the more used buttons, I decided to make a custom popup instead, which means that none of the Admin tools (Setting Ballast/Restrictor, Giving Penalties and Kick/Banning) are available.
  ---Setting Ballast/Restrictor/Penalties using Lua requires physics access which apps do not have online. Kick & Banning is not possible at all (Only initiating a Vote).
  ---I could make buttons that type out commands but Kunos acServer and AssettoServer have different command syntax.
  ---Checking which server integration is used would be a pain in the ass and the app isnt really meant to be used for adminning anyways so I wont bother.
  if ui.beginPopup('chatPlayerPopup' .. userName, nil, 0) then
    moveAppUp()

    if ui.modernMenuItem('Tag in chat', ui.Icons.Tag, false, ui.SelectableFlags.None, false) then
      playAudio(audio.keyboard.keystroke)
      if chat.input.text == chat.input.placeholder then chat.input.text = '' end
      chat.input.active = true
      chat.input.text = chat.input.text .. '@' .. userName
      ui.closePopup()
    end

    ui.newLine(app.popupNewlineOffset)
    ui.separator()

    if player.cspVersion >= 3459 then
      local friendString = ac.DriverTags(userName).friend and 'Remove as Friend' or 'Mark as Friend'
      ui.newLine(app.popupNewlineOffset)
      if ui.modernMenuItem(friendString, ui.Icons.Befriend, false, ui.SelectableFlags.DontClosePopups, false) then
        playAudio(audio.keyboard.enter)
        ac.DriverTags(userName).friend = not ac.DriverTags(userName).friend
        chat.msgCacheGen = chat.msgCacheGen + 1
        chat.layout.forceFullRebuild = true
      end

      ui.newLine(app.popupNewlineOffset)
      if ui.modernMenuItem('Mute', ui.Icons.Ban, false, ui.SelectableFlags.DontClosePopups, false) then
        playAudio(audio.keyboard.enter)
        ui.modalPopup(
          'Confirm Mute',
          'Are you sure you want to mute ' .. userName .. '?\nYou will no longer be able to read their chat messages\nUnmute them via the Drivers list in the CSP Chat app',
          'Confirm',
          'Cancel',
          ui.Icons.Confirm,
          ui.Icons.Cancel,
          function(confirmed)
            if confirmed then
              ac.DriverTags(userName).muted = not ac.DriverTags(userName).muted
              chat.msgCacheGen = chat.msgCacheGen + 1
              chat.layout.forceFullRebuild = true
            end
            playAudio(audio.keyboard.enter)
          end
        )
      end
    end

    if car.isConnected then
      ui.newLine(app.popupNewlineOffset)
      ui.separator()

      local watchString = car.focused and 'Stop Watching' or 'Watch Closely'
      ui.newLine(app.popupNewlineOffset)
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
local function drawPhone()
  ui.setCursor(vec2(0, 0 + movement.smooth))
  ui.childWindow('OnTopImages', vec2(app.images.phoneAtlasSize.x / 2, app.images.phoneAtlasSize.y), false, flags.window, function()
    ui.drawImage(app.images.phoneAtlasPath, scaleVec2(0, 0), scaleVec2(app.size.x, app.size.y), rgbm.colors.white, vec2(0, 0), vec2(1 / 2, 1))
    if not (settings.darkMode or player.phoneMode) then ui.drawImage(app.images.phoneAtlasPath, scaleVec2(0, 0), scaleVec2(app.size.x, app.size.y), colors.glowColor, vec2(1 / 2, 0), vec2(1, 1)) end
  end)
end

---Draws the ping.
local function drawPing()
  local ping = ac.getCar(0).ping
  local pingSize = scaleVec2(20, 20)
  local pingPos = scaleVec2(238, 20)
  local isHovered = app.hovered and ui.rectHovered(pingPos, pingPos + pingSize, true)

  if ping > -1 then
    if isHovered then
      ui.tooltip(app.tooltipPadding, function()
        ui.text('Current Ping: ' .. ping .. ' ms')
        ui.separator()
        ui.textColored('Click to send to chat', colors.footerText)
      end)
      if not ui.isMouseDragging(ui.MouseButton.Left, 0) then ui.setMouseCursor(ui.MouseCursor.Hand) end
      if ui.mouseReleased(ui.MouseButton.Left) then sendChatMessage('I currently have a ping of ' .. ping .. ' ms') end
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
    if isHovered then ui.tooltip(app.tooltipPadding, function() ui.text('Currently offline or ping unavailable') end) end

    local animFrame = math.floor(os.clock() * 2) % 3
    local textureStartUV = (2 - animFrame) / 5
    local textureEndUV = (3 - animFrame) / 5

    ui.drawImage(app.images.pingAtlasPath, pingPos, pingPos + pingSize, colors.final.elements, vec2(textureStartUV, 0), vec2(textureEndUV, 1))
  end
end

---Draws the time.
local function drawTime()
  local currentMinute = math.floor(os.time() / 60)
  if time.cached.minute ~= currentMinute or time.cached.format ~= settings.use12HourClock then
    time.cached.minute = currentMinute
    time.cached.format = settings.use12HourClock
    local now = os.date('%H:%M') ---@cast now string
    if settings.use12HourClock then
      time.cached.text = format12HourTime(now)
      time.cached.period = player.timePeriod
    else
      time.cached.text = now
    end
  end

  local timeText = time.cached.text
  local fontSize = scaleNum(13)
  local measurementText = '00:00'

  ui.pushDWriteFont(app.font.bold)

  if app.clockText.size == nil or app.clockText.scale ~= app.scale then
    local textSize = ui.measureDWriteText(measurementText, fontSize)
    app.clockText.size = vec2(math.ceil(textSize.x), math.ceil(textSize.y))
    app.clockText.scale = app.scale
  end

  local textArea = app.clockText.size
  if not textArea then
    ui.popDWriteFont()
    return
  end

  local rightEdge = scaleNum(62)
  local areaLeft = rightEdge - textArea.x
  local areaTop = scaleNum(22)

  ui.setCursor(vec2(areaLeft, areaTop))
  ui.dwriteTextAligned(timeText, fontSize, ui.Alignment.End, ui.Alignment.Center, textArea, false, colors.final.elements)
  ui.popDWriteFont()

  if app.hovered and ui.itemHovered() then
    if not ui.isMouseDragging(ui.MouseButton.Left, 0) and player.isOnline then ui.setMouseCursor(ui.MouseCursor.Hand) end

    ui.tooltip(app.tooltipPadding, function()
      ui.text('Current Ingame Time: ' .. timeText)
      if player.isOnline then
        ui.separator()
        ui.textColored('Click to send to chat', colors.footerText)
      end
    end)

    if ui.itemClicked(ui.MouseButton.Left) and player.isOnline then
      timeText = settings.use12HourClock and timeText .. ' ' .. time.cached.period or timeText
      sendChatMessage("It's currently " .. timeText .. ' my local time')
    end
  end
end

---Draws the dynamic island.
local function drawDynamicIsland()
  local islandHeight = songInfo.dynamicIslandSizeActive.y
  local borderRadius = scaleNum(10)
  local left = scaleVec2(app.size.x / 2 - songInfo.dynamicIslandSizeActive.x, songInfo.dynamicIslandSizeActive.y)
  local right = scaleVec2(app.size.x / 2 + songInfo.dynamicIslandSizeActive.x, songInfo.dynamicIslandSizeActive.y * 2)

  ui.drawRectFilled(left, right, rgbm.colors.black, borderRadius)

  if not settings.songInfoHidesCamera or not settings.songInfo or songInfo.isNotPlaying then
    local islandTop = scaleNum(islandHeight)
    local islandBottom = scaleNum(islandHeight * 2)
    local camTotalHeight = scaleNum(islandHeight - 2)
    local camSize = camTotalHeight / 2
    local camTop = islandTop + math.floor((islandBottom - islandTop - camTotalHeight) / 2)
    local camPosY = camTop + camSize
    local camPosX = scaleNum(app.size.x / 2 + 30)

    ui.drawImage(app.images.phoneCamera, vec2(camPosX - camSize, camPosY - camSize), vec2(camPosX + camSize, camPosY + camSize))
  end
end

---Draws the song information.
local function drawSongInfo()
  if settings.songInfo then
    if not songInfo.isNotPlaying then
      local coverSize = scaleVec2(16, 16)
      local islandTop = scaleNum(20)
      local islandBottom = scaleNum(40)
      local coverTop = islandTop + math.floor((islandBottom - islandTop - coverSize.x) / 2)
      local imgPosX = scaleNum(app.size.x / 2 - 75)
      local imgPos = vec2(imgPosX, coverTop)
      local rounding = scaleNum(4)

      if songInfo.hasCover then
        --I'm using --[[@as ui.MediaPlayer]] here because ac.MusicData is not in the valid imageSources for some reason even though lua.lib says to pass ac.MusicData in like this.
        ui.drawImageRounded(ac.currentlyPlaying() --[[@as ui.MediaPlayer]], imgPos, imgPos + coverSize, rounding, ui.CornerFlags.All)
      else
        ui.drawImageRounded(app.images.defaultCover, imgPos, imgPos + coverSize, rounding, ui.CornerFlags.All)
      end
    end

    local fontSize = scaleNum(12)
    local pos = settings.songInfoGradient and scaleVec2(86, 21) or scaleVec2(89, 21)
    local textSize = settings.songInfoGradient and scaleVec2(135, 15) or scaleVec2(132, 15)

    drawSongInfoText(songInfo.final, pos, textSize, fontSize)

    if settings.songInfoGradient and songInfo.dynamicIslandSizeActive.x == songInfo.dynamicIslandBaseWidths.y then
      local gradientWidth = scaleNum(settings.songInfoGradientWidth)
      local gradientColor = rgbm(0, 0, 0, settings.songInfoGradientIntensity)
      ui.drawRectFilledMultiColor(pos, vec2(pos.x + gradientWidth, pos.y + textSize.y), gradientColor, rgbm.colors.transparent, rgbm.colors.transparent, gradientColor)
      ui.drawRectFilledMultiColor(vec2(pos.x + textSize.x - gradientWidth, pos.y), pos + textSize, rgbm.colors.transparent, gradientColor, gradientColor, rgbm.colors.transparent)
    end

    if app.hovered and songInfo.final ~= '' then
      if ui.rectHovered(pos, pos + textSize, true) then
        if not ui.isMouseDragging(ui.MouseButton.Left, 0) and player.isOnline then ui.setMouseCursor(ui.MouseCursor.Hand) end

        ui.tooltip(app.tooltipPadding, function()
          ui.text('Current Song: ' .. songInfo.artist .. ' - ' .. songInfo.title)
          if player.isOnline then
            ui.separator()
            ui.textColored('Click to send to chat', colors.footerText)
          end
        end)

        if ui.mouseClicked(ui.MouseButton.Left) and player.isOnline then sendChatMessage("I'm currently listening to: " .. songInfo.final) end
      end
    end
  end
end

---Draws the Status Bar containing the time, ping and dynamic island.
local function drawStatusBar()
  ui.setCursor(vec2(0, movement.smooth))
  ui.childWindow('StatusBar', scaleVec2(app.size.x, 45), false, flags.window, function()
    drawTime()
    drawPing()
    drawDynamicIsland()
    drawSongInfo()
  end)
end

---Draws the contact in the chat window.
local function drawContact()
  if not communities then return error('Communities table does not exist, probably caused by a broken app install') end

  local community = communities[player.serverCommunity]

  ui.setCursor(vec2(0, movement.smooth))
  ui.childWindow('Contact', scaleVec2(app.size.x, 110), false, flags.window, function()
    local winHalf = scaleNum(app.size.x / 2)
    local fontSize = scaleNum(12)

    ui.pushDWriteFont(app.font.semiBold)

    local contactName = community.contact
    local contactTextSize = ui.measureDWriteText(contactName, fontSize)
    local contactTextCenter = math.ceil(winHalf - contactTextSize.x / 2)
    local contactTextPosY = scaleNum(83)

    local pillPaddingX = scaleNum(8)
    local pillPaddingY = scaleNum(4)
    local pillPosTL = vec2(contactTextCenter - pillPaddingX, contactTextPosY - pillPaddingY)
    local pillPosBR = vec2(contactTextCenter + contactTextSize.x + pillPaddingX, contactTextPosY + contactTextSize.y + pillPaddingY)
    local pillRounding = (pillPosBR.y - pillPosTL.y) / 2
    local pillOutline = math.round(app.scale * 1, 2)

    ui.beginOutline()
    ui.drawRectFilled(pillPosTL, pillPosBR, colors.final.contactPill, pillRounding)
    ui.endOutline(colors.final.contactOutline, pillOutline)

    ui.setCursor(vec2(contactTextCenter, contactTextPosY))
    ui.dwriteTextAligned(contactName, fontSize, ui.Alignment.Start, ui.Alignment.Center, contactTextSize, false, colors.final.elements)

    ui.popDWriteFont()

    local imgSize = scaleVec2(36, 36)
    local imgPos = vec2((ui.availableSpaceX() / 2) - (imgSize.x / 2), scaleNum(47))
    local imgRounding = scaleNum(20)

    ui.drawImageRounded(community.image, imgPos, imgPos + imgSize, imgRounding, ui.CornerFlags.All)

    if app.hovered then
      if ui.rectHovered(imgPos, imgPos + imgSize) then
        if not ui.isMouseDragging(ui.MouseButton.Left, 0) then ui.setMouseCursor(ui.MouseCursor.Hand) end

        ui.tooltip(app.tooltipPadding, function()
          ui.text(community.text)
          ui.separator()
          ui.textColored('Click to open in Browser', colors.footerText)
        end)

        if ui.mouseReleased(ui.MouseButton.Left) then
          playAudio(audio.keyboard.enter)
          os.openURL(community.url, false)
        end
      end
    end
  end)
end

---@param t number @unix timestamp
---@return string @formatted time string
---Formats a message's timestamp for display.
local function formatMessageTimestamp(t)
  local localTime = os.date('%H:%M', t) ---@cast localTime string
  return settings.use12HourClock and format12HourTime(localTime) .. ' ' .. player.timePeriod or localTime
end

---@param message table @chat message entry
---@param userNameFontSize number @font size for the username
---@param contentFontSize number @font size for the message text
---@param timestampFontSize number @font size for the timestamp
---@param timestamp number @unix timestamp
---@param showTimestamp boolean @whether this message shows a timestamp
---@param fontWeight ui.DWriteFont @font weight to measure the message text with
---@param wrapWidth number @wrap width for the message text
---@return table @cached {userNameTextSize, messageTextSize, timestampSize}
---Gets the cached text sizes for a message, measuring and caching them if needed.
local function getMessageSizes(message, userNameFontSize, contentFontSize, timestampFontSize, timestamp, showTimestamp, fontWeight, wrapWidth)
  if message.cache and message.cacheGen == chat.msgCacheGen then return message.cache end

  local userIndex = message[1]
  local cache = {}

  if userIndex >= 0 then
    ui.pushDWriteFont(app.font.bold)
    cache.userNameTextSize = ui.measureDWriteText(message[2], userNameFontSize)
    ui.popDWriteFont()
  end

  ui.pushDWriteFont(userIndex >= 0 and fontWeight or app.font.bold)
  cache.messageTextSize = ui.measureDWriteText(message[3], contentFontSize, wrapWidth)
  ui.popDWriteFont()

  if userIndex >= 0 and showTimestamp then
    ui.pushDWriteFont(app.font.bold)
    cache.timestampSize = ui.measureDWriteText(formatMessageTimestamp(timestamp), timestampFontSize)
    ui.popDWriteFont()
  end

  message.cache = cache
  message.cacheGen = chat.msgCacheGen
  return cache
end

---@param messages table @messages sorted ascending by Y
---@param entryCount number @number of valid entries
---@param visibleTop number @top Y of the visible scroll window
---@return number @index of the first potentially visible entry
---Gets the first visible message entry, so the render loop doesn't have to scan every message every frame.
local function getFirstVisibleMessageIndex(messages, entryCount, visibleTop)
  local lo, hi = 1, entryCount + 1
  while lo < hi do
    local mid = math.floor((lo + hi) / 2)
    if messages[mid].endY >= visibleTop then
      hi = mid
    else
      lo = mid + 1
    end
  end
  return lo
end

---@param entry table @message layout entry to fill in, mutated in place
---@param message table @raw chat.messages entry
---@param rawIndex number @this message's index in chat.messages
---@param messageY number @Y cursor before this message
---@param lastUserIndex number|nil @userIndex of the previous message
---@param lastUserName string|nil @username of the previous message
---@return boolean @true if the message is filtered out
---@return number @Y cursor after this message
---@return number|nil @new lastUserIndex
---@return string|nil @new lastUserName
---Positions a single message entry for both full and selective layout rebuilds.
local function positionMessageEntry(entry, message, rawIndex, messageY, lastUserIndex, lastUserName)
  local contentFontSize = scaleNum(settings.chatFontSize)
  local userNameFontSize = scaleNum(settings.chatFontSize - 2)
  local timestampFontSize = scaleNum(settings.chatFontSize - 4)
  local userNameOffsetY = scaleNum(settings.chatFontSize - 2 + 13)
  local messagePadding = scaleVec2(15, 10)

  local userIndex = message[1]
  local userName = message[2]
  local content = message[3]
  local timestamp = message[4]
  local showTimestamp = message[5]
  local isMentioned = message[6]

  if (settings.focusMode and (userIndex > 0 and not checkIfFriend(userName))) or ac.DriverTags(userName).muted then return true, messageY, lastUserIndex, lastUserName end

  local fontWeight = app.font.regular
  if (rawIndex == chat.latestUserMessage and settings.chatLatestBold) or (isMentioned and userIndex > 0) then fontWeight = app.font.bold end

  local wrapWidth = userIndex == -1 and scaleNum(220) or scaleNum(190)
  local sizes = getMessageSizes(message, userNameFontSize, contentFontSize, timestampFontSize, timestamp, showTimestamp, fontWeight, wrapWidth)
  local messageTextSize = sizes.messageTextSize or vec2(0, 0)
  local timestampSize = sizes.timestampSize or vec2(0, 0)

  entry.rawIndex = rawIndex
  entry.userIndex = userIndex
  entry.userName = userName
  entry.text = content
  entry.time = timestamp
  entry.fontWeight = fontWeight
  entry.sizes = sizes
  entry.startY = messageY
  entry.userNameY = nil
  entry.timestampY = nil
  entry.bubbleY = nil
  entry.textY = nil

  if userIndex >= 0 then
    local showUsernameLine = (not lastUserIndex or lastUserIndex ~= userIndex) or (not lastUserName or lastUserName ~= userName)

    if showUsernameLine then
      if lastUserIndex and lastUserIndex ~= -1 then messageY = math.ceil(messageY - userNameOffsetY / 2) end
      entry.userNameY = messageY
      messageY = math.ceil(messageY + userNameOffsetY)
    end

    messageY = math.ceil(messageY + messageTextSize.y)
    entry.bubbleY = messageY

    if settings.chatShowTimestamps and showTimestamp then
      entry.timestampY = messageY
      messageY = math.ceil(messageY + timestampSize.y)
    end

    messageY = math.ceil(messageY + messagePadding.y + messagePadding.y / 2)
  else
    if lastUserIndex ~= nil and lastUserIndex ~= userIndex then messageY = math.ceil(messageY - messagePadding.y) end
    entry.textY = messageY
    messageY = math.ceil(messageY + messageTextSize.y + messagePadding.y / 2)
  end

  entry.endY = messageY

  return false, messageY, userIndex, userName
end

---@param layoutMessages table @positioned message entries, sorted ascending by rawIndex
---@param messageCount number @number of valid layout entries
---@param rawIndex number @raw chat.messages index to look up
---@return number|nil @layout entry index whose rawIndex matches, nil if filtered out
---Finds the layout entry for a raw chat message index using binary search.
local function getEntryIndexForRawIndex(layoutMessages, messageCount, rawIndex)
  local lo, hi = 1, messageCount + 1
  while lo < hi do
    local mid = math.floor((lo + hi) / 2)
    if layoutMessages[mid].rawIndex >= rawIndex then
      hi = mid
    else
      lo = mid + 1
    end
  end
  if lo <= messageCount and layoutMessages[lo].rawIndex == rawIndex then return lo end
  return nil
end

---@return table @positioned message entries (chat.layout.messages)
---@return number @number of valid entries
---@return number @total height of all messages
---Builds the message layout selectively when possible, otherwise performs a full rebuild.
local function buildMessageLayout()
  if chat.layout.cacheGen == chat.msgCacheGen then return chat.layout.messages, chat.layout.messageCount, chat.layout.totalHeight end

  local firstMessagePadding = scaleNum(366)
  local layoutMessages = chat.layout.messages
  local rawCount = #chat.messages

  local measurementSettingsChanged = chat.layout.appliedSettings.fontSize ~= settings.chatFontSize
    or chat.layout.appliedSettings.showTimestamps ~= settings.chatShowTimestamps
    or chat.layout.appliedSettings.use12HourClock ~= settings.use12HourClock
    or chat.layout.appliedSettings.scale ~= app.scale
    or chat.layout.appliedSettings.focusMode ~= settings.focusMode

  if chat.layout.messageCount > 0 and not chat.layout.forceFullRebuild and not measurementSettingsChanged then
    local pendingRemoveCount = chat.layout.pendingRemoveCount
    local previousRawCount = chat.layout.oldRawCount - pendingRemoveCount

    if rawCount >= previousRawCount then
      local oldMessageCount = chat.layout.messageCount
      local removeCount = 0

      if pendingRemoveCount > 0 then
        local lo, hi = 1, oldMessageCount + 1
        while lo < hi do
          local mid = math.floor((lo + hi) / 2)
          if layoutMessages[mid].rawIndex > pendingRemoveCount then
            hi = mid
          else
            lo = mid + 1
          end
        end
        removeCount = lo - 1
      end

      local keepCount = oldMessageCount - removeCount

      if keepCount > 0 or pendingRemoveCount == 0 then
        local messageCount = keepCount
        local messageY, lastUserIndex, lastUserName

        if pendingRemoveCount > 0 then
          for i = 1, keepCount do
            layoutMessages[i] = layoutMessages[removeCount + i]
          end
          for j = keepCount + 1, oldMessageCount do
            layoutMessages[j] = nil
          end

          local firstKeptMessage = layoutMessages[1]
          local oldFirstEndY = firstKeptMessage.endY
          local rawIndex = firstKeptMessage.rawIndex - pendingRemoveCount
          positionMessageEntry(firstKeptMessage, chat.messages[rawIndex], rawIndex, firstMessagePadding, nil, nil)
          local heightShift = firstKeptMessage.endY - oldFirstEndY

          messageY, lastUserIndex, lastUserName = firstKeptMessage.endY, firstKeptMessage.userIndex, firstKeptMessage.userName

          for i = 2, keepCount do
            local keptMessage = layoutMessages[i]
            keptMessage.rawIndex = keptMessage.rawIndex - pendingRemoveCount
            keptMessage.startY = keptMessage.startY + heightShift
            keptMessage.endY = keptMessage.endY + heightShift
            if keptMessage.bubbleY then keptMessage.bubbleY = keptMessage.bubbleY + heightShift end
            if keptMessage.userNameY then keptMessage.userNameY = keptMessage.userNameY + heightShift end
            if keptMessage.timestampY then keptMessage.timestampY = keptMessage.timestampY + heightShift end
            if keptMessage.textY then keptMessage.textY = keptMessage.textY + heightShift end
            messageY, lastUserIndex, lastUserName = keptMessage.endY, keptMessage.userIndex, keptMessage.userName
          end
        else
          local lastEntry = layoutMessages[oldMessageCount]
          messageY, lastUserIndex, lastUserName = chat.layout.totalHeight, lastEntry.userIndex, lastEntry.userName
        end

        local recalcFrom = messageCount + 1

        if rawCount > previousRawCount then
          local firstNewMessage = chat.messages[previousRawCount + 1]
          recalcFrom = messageCount
          while recalcFrom >= 1 do
            local candidate = layoutMessages[recalcFrom]
            if candidate.userIndex ~= firstNewMessage[1] then break end
            if os.date('%H:%M', chat.messages[candidate.rawIndex][4]) ~= os.date('%H:%M', firstNewMessage[4]) then break end
            recalcFrom = recalcFrom - 1
          end
          recalcFrom = recalcFrom + 1
        end

        local latestUserMessage = chat.layout.oldLatestUserMessage
        if latestUserMessage and latestUserMessage ~= chat.latestUserMessage then
          local adjustedOldLatest = latestUserMessage - pendingRemoveCount
          if adjustedOldLatest >= 1 then
            local foundAt = getEntryIndexForRawIndex(layoutMessages, messageCount, adjustedOldLatest)
            if foundAt then recalcFrom = math.min(recalcFrom, foundAt) end
          end
        end

        if chat.layout.appliedSettings.latestBold ~= settings.chatLatestBold and chat.latestUserMessage then
          local foundAt = getEntryIndexForRawIndex(layoutMessages, messageCount, chat.latestUserMessage)
          if foundAt then recalcFrom = math.min(recalcFrom, foundAt) end
        end

        chat.layout.oldLatestUserMessage = chat.latestUserMessage
        chat.layout.appliedSettings.latestBold = settings.chatLatestBold

        if recalcFrom <= messageCount then
          if recalcFrom == 1 then
            messageY, lastUserIndex, lastUserName = firstMessagePadding, nil, nil
          else
            local before = layoutMessages[recalcFrom - 1]
            messageY, lastUserIndex, lastUserName = before.endY, before.userIndex, before.userName
          end
          for i = recalcFrom, messageCount do
            local rawIndex = layoutMessages[i].rawIndex
            local _
            _, messageY, lastUserIndex, lastUserName = positionMessageEntry(layoutMessages[i], chat.messages[rawIndex], rawIndex, messageY, lastUserIndex, lastUserName)
          end
        end

        for rawIndex = previousRawCount + 1, rawCount do
          local message = chat.messages[rawIndex]
          messageCount = messageCount + 1
          local entry = layoutMessages[messageCount]
          if not entry then
            entry = {}
            layoutMessages[messageCount] = entry
          end
          local skipped, newMsgDist, newLastUserIndex, newLastUserName = positionMessageEntry(entry, message, rawIndex, messageY, lastUserIndex, lastUserName)
          if skipped then
            messageCount = messageCount - 1
          else
            messageY, lastUserIndex, lastUserName = newMsgDist, newLastUserIndex, newLastUserName
          end
        end

        chat.layout.cacheGen = chat.msgCacheGen
        chat.layout.messageCount = messageCount
        chat.layout.totalHeight = messageY
        chat.layout.oldRawCount = rawCount
        chat.layout.pendingRemoveCount = 0

        return layoutMessages, messageCount, messageY
      end
    end
  end

  local entryCount = 0
  local messageY = firstMessagePadding
  local lastDrawnUserIndex = nil
  local lastDrawnUserName = nil

  for i = 1, rawCount do
    local message = chat.messages[i]
    entryCount = entryCount + 1
    local entry = layoutMessages[entryCount]
    if not entry then
      entry = {}
      layoutMessages[entryCount] = entry
    end
    local skipped, newMsgDist, newLastUserIndex, newLastUserName = positionMessageEntry(entry, message, i, messageY, lastDrawnUserIndex, lastDrawnUserName)
    if skipped then
      entryCount = entryCount - 1
    else
      messageY, lastDrawnUserIndex, lastDrawnUserName = newMsgDist, newLastUserIndex, newLastUserName
    end
  end

  chat.layout.cacheGen = chat.msgCacheGen
  chat.layout.messageCount = entryCount
  chat.layout.totalHeight = messageY
  chat.layout.oldRawCount = rawCount
  chat.layout.pendingRemoveCount = 0
  chat.layout.forceFullRebuild = false
  chat.layout.oldLatestUserMessage = chat.latestUserMessage
  chat.layout.appliedSettings.latestBold = settings.chatLatestBold
  chat.layout.appliedSettings.fontSize = settings.chatFontSize
  chat.layout.appliedSettings.showTimestamps = settings.chatShowTimestamps
  chat.layout.appliedSettings.use12HourClock = settings.use12HourClock
  chat.layout.appliedSettings.scale = app.scale
  chat.layout.appliedSettings.focusMode = settings.focusMode

  return layoutMessages, entryCount, messageY
end

---Draws the chat messages.
local function drawMessages()
  if not player.isOnline then return end

  local clipTop = scaleVec2(0, 0, true)
  local clipBottom = scaleVec2(app.size.x, 501, true)
  ui.pushClipRect(clipTop, clipBottom)

  local messagesPos = scaleVec2(10, 18, true)
  local childSize = scaleVec2(270, 483 - chat.input.offset / app.scale)
  local entries, entryCount, totalHeight = buildMessageLayout()
  ui.setCursor(messagesPos)
  local lastMessagePadding = entries[entryCount].userIndex == -1 and 0 or scaleNum(8)
  ui.setNextWindowContentSize(vec2(0, totalHeight - lastMessagePadding))
  ui.childWindow('Messages', childSize, false, flags.window, function()
    local winWidth = ui.windowWidth()
    local winHalfWidth = winWidth / 2
    local messageFontSize = scaleNum(settings.chatFontSize)
    local userNameFontSize = scaleNum(settings.chatFontSize - 2)
    local timestampFontSize = scaleNum(settings.chatFontSize - 4)
    local userNameOffsetX = scaleNum(13)
    local messagePadding = scaleVec2(15, 10)
    local messageMaxWidth = scaleNum(250)
    local messageRounding = scaleNum(10)

    if #chat.messages > 0 then
      local winHeight = ui.windowHeight()
      local scrollBuffer = scaleNum(200)

      local totalHeightChanged = totalHeight ~= chat.scroll.lastTotalHeight
      chat.scroll.lastTotalHeight = totalHeight

      local hoveredAutoscroll = (not app.hovered or chat.scroll.forceAutoscroll) or (chat.input.active and chat.input.hovered) and ui.getScrollY() ~= ui.getScrollMaxY()
      local shouldPin = (chat.scroll.wasAtBottom and totalHeightChanged) or hoveredAutoscroll
      local revealHeight = totalHeight

      if shouldPin then
        local scrollTarget = ui.getScrollMaxY()
        if math.abs(ui.getScrollY() - scrollTarget) > 1 then
          revealHeight = math.min(chat.scroll.stickyHeight, totalHeight)
          ui.setScrollY(scrollTarget, false, true)
        else
          chat.scroll.stickyHeight = totalHeight
        end
      else
        chat.scroll.stickyHeight = totalHeight
      end

      local visibleTop = ui.getScrollY() - scrollBuffer
      local visibleBottom = ui.getScrollY() + winHeight + scrollBuffer

      local startIndex = getFirstVisibleMessageIndex(entries, entryCount, visibleTop)

      for i = startIndex, entryCount do
        local entry = entries[i]
        if entry.startY > visibleBottom or entry.endY > revealHeight then break end

        local sizes = entry.sizes
        local userNameTextSize = sizes.userNameTextSize
        local messageTextSize = sizes.messageTextSize
        local timestampSize = sizes.timestampSize
        local messageUsernameColor = rgbm.colors.gray
        if settings.chatUsernameColor then messageUsernameColor = chat.userNameColors[entry.userName] or rgbm.colors.gray end

        if entry.userIndex == 0 then
          if entry.userNameY or entry.timestampY then
            ui.pushDWriteFont(app.font.bold)
            if entry.userNameY then
              ui.setCursor(ceilVec2(userNameOffsetX, entry.userNameY))
              ui.dwriteTextAligned(entry.userName, userNameFontSize, ui.Alignment.End, ui.Alignment.Start, ceilVec2(messageMaxWidth, userNameTextSize.y), false, messageUsernameColor)
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
          if entry.userNameY or entry.timestampY then
            ui.pushDWriteFont(app.font.bold)

            if entry.userNameY then
              ui.setCursor(ceilVec2(userNameOffsetX / 2, entry.userNameY))
              ui.dwriteTextAligned(entry.userName, userNameFontSize, ui.Alignment.Start, ui.Alignment.Start, ceilVec2(math.min(userNameTextSize.x, messageMaxWidth), userNameTextSize.y), false, messageUsernameColor)

              if app.hovered then
                if ui.itemHovered() then
                  ui.setMouseCursor(ui.MouseCursor.Hand)
                  if ac.getDriverName(entry.userIndex) == entry.userName then ui.setDriverTooltip(entry.userIndex) end
                  chat.popup.hovered = { userIndex = entry.userIndex, userName = entry.userName }
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
          if checkIfFriend(entry.userName) then
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

      chat.scroll.wasAtBottom = (ui.getScrollMaxY() - ui.getScrollY()) < scaleNum(50)
    end
    if chat.popup.hovered then chatPlayerPopup(chat.popup.hovered.userIndex, chat.popup.hovered.userName) end

    if (app.hovered and not emoji.picker) and ui.mouseWheel() ~= 0 then
      local mouseWheel = (ui.mouseWheel() * -1) * (scaleNum(settings.chatScrollDistance))
      ui.setScrollY(mouseWheel, true, true)
    end
  end)

  ui.setCursor(messagesPos)
  ui.childWindow('MessagesFade', childSize, false, flags.window, function()
    local fadeHeight = scaleNum(75)
    local fadeSize = vec2(ui.availableSpaceX(), fadeHeight)

    if not app.canvas.messageFade or app.canvas.messageFadeSize.x ~= fadeSize.x or app.canvas.messageFadeSize.y ~= fadeSize.y then
      if app.canvas.messageFade then app.canvas.messageFade:dispose() end

      app.canvas.messageFade = ui.ExtraCanvas(fadeSize, 1, render.TextureFlags.None)
      app.canvas.messageFadeSize = fadeSize
      app.canvas.update.message = true
    end

    if app.canvas.update.message then
      app.canvas.messageFade:update(function()
        app.canvas.messageFade:clear(colors.final.displayTransp)
        ui.drawRectFilledMultiColor(vec2(0, 0), fadeSize, colors.final.display, colors.final.display, colors.final.displayTransp, colors.final.displayTransp)
      end)

      app.canvas.update.message = false
    end

    local barHeight = scaleNum(30)
    local barInset = scaleNum(5)
    local rounding = scaleNum(15)
    local peekDistance = scaleNum(movement.maxDistance - movement.notifDistance)
    local peek = math.lerpInvSat(movement.distance, 0, peekDistance)
    local capY = math.floor((peek - 1) * barHeight)
    local fadeY = capY + barHeight - scaleNum(2)

    ui.drawImageRounded(app.canvas.messageFade, vec2(0, fadeY), vec2(fadeSize.x, fadeY + fadeHeight), rounding * (1 - peek), ui.CornerFlags.Top)
    ui.drawRectFilled(vec2(barInset, capY), vec2(fadeSize.x - barInset, capY + barHeight), colors.final.display, rounding, ui.CornerFlags.Top)
  end)

  ui.popClipRect()
end

---Draws the emoji picker button and window.
local function drawEmojiPicker()
  local buttonPos = scaleVec2(28, app.size.y - 17, true)
  local buttonSize = scaleVec2(12, 12)
  local emojiSizePicker = scaleNum(20)
  local groupIconDrawSize = scaleVec2(22, 22)
  local iconHoverRounding = scaleNum(5)
  local groupCount = #emoji.groups
  local iconStep = 1 / math.max(groupCount, 1)

  ui.pushDWriteFont(app.font.regular)

  if emoji.char.size == nil or emoji.char.scale ~= app.scale then
    emoji.char.size = ui.measureDWriteText('😀', emojiSizePicker)
    emoji.char.scale = app.scale
  end

  local emojiCharSize = emoji.char.size
  if not emojiCharSize then
    ui.popDWriteFont()
    return
  end

  ui.setCursor(buttonPos)
  local cursorPos = ui.getCursor()
  local buttonHovered = player.isOnline and app.hovered and ui.rectHovered(cursorPos - buttonSize, cursorPos + buttonSize)
  if player.isOnline and app.hovered then emoji.pickerHovered = buttonHovered end

  local spacing = scaleVec2(2, 2)
  if buttonHovered then ui.drawRectFilled(cursorPos - (buttonSize + spacing), cursorPos + (buttonSize + spacing), colors.iMessageSelected, iconHoverRounding - scaleNum(1)) end

  local emojiPickerIconColor = emoji.picker and colors.final.emojiPickerActive or colors.final.emojiPicker
  ui.drawImage(app.images.emojiIcons, cursorPos - buttonSize, cursorPos + buttonSize, emojiPickerIconColor, vec2(0, 0), vec2(iconStep, 1))

  if not player.isOnline then
    ui.popDWriteFont()
    return
  end

  if buttonHovered then
    if not ui.isMouseDragging(ui.MouseButton.Left, 0) then ui.setMouseCursor(ui.MouseCursor.Hand) end
    if ui.mouseReleased(ui.MouseButton.Left) then
      emoji.picker = not emoji.picker
      playAudio(audio.keyboard.enter)
    end
  end

  if not emoji.picker then
    ui.popDWriteFont()
    return
  end

  local groupRowHeight = scaleNum(34)
  local windowSize = scaleVec2(266, 461 - (chat.input.offset / app.scale))
  local windowPos = scaleVec2(12, 40, true)
  local gridSize = vec2(windowSize.x, windowSize.y - groupRowHeight)

  local activeGroup = emoji.groups[emoji.activeGroup]
  if activeGroup then
    local emojiOffset = scaleVec2(0, 3)
    local emojiSpacing = emojiOffset.y
    local emojis = activeGroup.emojis
    local emojiCount = #emojis
    local emojisPerRow = math.max(1, math.floor((gridSize.x + emojiSpacing) / (emojiCharSize.x + emojiSpacing)))
    local usedWidth = emojisPerRow * emojiCharSize.x + (emojisPerRow - 1) * emojiSpacing
    local emojiStartPos = vec2((gridSize.x - usedWidth) / 2, 0)
    local rowCount = math.ceil(emojiCount / emojisPerRow)
    local contentHeight = emojiStartPos.y + rowCount * (emojiCharSize.y + emojiSpacing)

    ui.setCursor(windowPos)
    ui.setNextWindowContentSize(vec2(0, contentHeight))
    ui.childWindow('EmojiPickerGrid', gridSize, false, flags.emojiWindow, function()
      local gridHovered = ui.windowHovered()
      if gridHovered then emoji.pickerHovered = true end

      if emoji.activeGroupDrawn ~= emoji.activeGroup then
        ui.setScrollY(0, false, false)
        emoji.activeGroupDrawn = emoji.activeGroup
      end

      ui.setCursor(emojiStartPos)
      ui.beginOutline()
      ui.beginGroup(gridSize.x)

      for i = 1, emojiCount do
        local itemCursor = ui.getCursor()
        if ui.rectHovered(itemCursor, itemCursor + emojiCharSize) then
          emoji.pickerHovered = true
          if not ui.isMouseDragging(ui.MouseButton.Left, 0) then ui.setMouseCursor(ui.MouseCursor.Hand) end
          ui.drawRectFilled(itemCursor + (emojiOffset / 2), itemCursor + emojiCharSize + (emojiOffset / 2), colors.iMessageSelected, scaleNum(5))
        end

        ui.dwriteText(emojis[i], emojiSizePicker)

        if ui.itemClicked(ui.MouseButton.Left, true) then
          playAudio(audio.keyboard.keystroke)
          if utf8len(chat.input.text .. emojis[i]) >= getInputMaxLength() then goto continue end
          if not chat.input.active then chat.input.active = true end
          if chat.input.text == chat.input.placeholder then chat.input.text = '' end
          chat.input.text = chat.input.text .. emojis[i]
        end

        ::continue::

        ui.sameLine(0, emojiSpacing)
        if i % emojisPerRow == 0 and i ~= emojiCount then ui.newLine(emojiSpacing) end
      end
      ui.endGroup()
      ui.endOutline(colors.final.emojiPickerOutline, scaleNum(1))

      if gridHovered and ui.mouseWheel() ~= 0 then
        local mouseWheel = (ui.mouseWheel() * -1) * scaleNum(settings.chatScrollDistance)
        ui.setScrollY(mouseWheel, true, true)
      end
    end)
  end

  ui.setCursor(windowPos)
  ui.childWindow('EmojiPickerFade', gridSize, false, flags.window, function()
    local fadeHeight = scaleNum(4)
    local fadeSize = vec2(ui.availableSpaceX(), gridSize.y)

    if not app.canvas.emojiFade or app.canvas.emojiFadeSize.x ~= fadeSize.x or app.canvas.emojiFadeSize.y ~= fadeSize.y then
      if app.canvas.emojiFade then app.canvas.emojiFade:dispose() end
      app.canvas.emojiFade = ui.ExtraCanvas(fadeSize, 1, render.TextureFlags.None)
      app.canvas.emojiFadeSize = fadeSize
      app.canvas.update.emoji = true
    end

    if app.canvas.update.emoji then
      app.canvas.emojiFade:update(function()
        app.canvas.emojiFade:clear(colors.final.displayTransp)
        ui.drawRectFilledMultiColor(vec2(0, 0), vec2(fadeSize.x, fadeHeight), colors.final.display, colors.final.display, colors.final.displayTransp, colors.final.displayTransp)
        ui.drawRectFilledMultiColor(vec2(0, fadeSize.y - fadeHeight), vec2(fadeSize.x, fadeSize.y), colors.final.displayTransp, colors.final.displayTransp, colors.final.display, colors.final.display)
      end)
      app.canvas.update.emoji = false
    end

    ui.drawImage(app.canvas.emojiFade, vec2(0, 0), fadeSize)
  end)

  local groupBarPos = windowPos + vec2(0, gridSize.y)
  local groupButtonWidth = windowSize.x / math.max(groupCount, 1)
  for i = 1, groupCount do
    local buttonStart = groupBarPos + vec2((i - 1) * groupButtonWidth, 0)
    local buttonEnd = buttonStart + vec2(groupButtonWidth, groupRowHeight)
    local buttonCenter = (buttonStart + buttonEnd) / 2
    local isGroupHovered = ui.rectHovered(buttonStart, buttonEnd)

    if isGroupHovered then
      ui.drawRectFilled(buttonCenter - (groupButtonWidth / 2.2), buttonCenter + (groupButtonWidth / 2.2), colors.iMessageSelected, iconHoverRounding)
      ui.tooltip(app.tooltipPadding, function() ui.text(emoji.groups[i].name) end)
    end

    local iconColor = i == emoji.activeGroup and colors.final.emojiPickerActive or colors.final.emojiPicker
    ui.drawImage(app.images.emojiIcons, buttonCenter - (groupIconDrawSize / 2), buttonCenter + (groupIconDrawSize / 2), iconColor, vec2((i - 1) * iconStep, 0), vec2(i * iconStep, 1))

    if isGroupHovered then
      emoji.pickerHovered = true
      if not ui.isMouseDragging(ui.MouseButton.Left, 0) or i == emoji.activeGroup then ui.setMouseCursor(ui.MouseCursor.Hand) end
      if i ~= emoji.activeGroup and ui.mouseReleased(ui.MouseButton.Left) then
        emoji.activeGroup = i
        playAudio(audio.keyboard.enter)
      end
    end
  end

  ui.popDWriteFont()
end

---Draws the custom input box for the chat.
local function drawCustomChatInput()
  local inputSize = scaleVec2(235, 32 + chat.input.offset / app.scale)
  local inputBoxSize = scaleVec2(232, 27 + chat.input.offset / app.scale)
  local inputFontSize = scaleNum(settings.chatFontSize)
  local inputWrap = scaleNum(190)

  local winHeight = scaleNum(app.size.y)
  local posX = scaleNum(42)
  local posY = winHeight - scaleNum(32) - chat.input.offset + movement.smooth

  ui.setCursor(vec2(posX, posY))
  ui.childWindow('ChatInput', inputSize, false, flags.input, function()
    ui.beginOutline()
    ui.drawRectFilled(scaleVec2(2, 2), inputBoxSize, colors.final.display, scaleNum(10))
    ui.endOutline(colors.final.outline, math.max(1, math.round(1 * app.scale, 1)))

    local displayText = ''

    ui.pushDWriteFont(app.font.regular)

    if player.isOnline then
      chat.input.hovered = ui.windowHovered(ui.HoveredFlags.RectOnly)
      local inputClicked = chat.input.hovered and ui.mouseClicked(ui.MouseButton.Left)

      if chat.input.hovered then ui.setMouseCursor(ui.MouseCursor.TextInput) end

      if not chat.input.sendHovered then
        if inputClicked or chat.input.mentioned ~= '' then
          if not chat.input.active then chat.input.text = '' end
          chat.input.active = true
          if emoji.picker then emoji.picker = false end
        elseif ui.mouseClicked(ui.MouseButton.Left) and not emoji.pickerHovered and not chat.input.hovered then
          chat.input.active = false
          chat.input.text = chat.input.placeholder
          chat.input.selected = nil
          chat.input.historyIndex = 0
          emoji.picker = false
        end
      end

      if chat.input.active then
        handleKeyboardInput()
        colors.final.input:set(pickThemeColor(rgbm.colors.black, rgbm.colors.white))
        if chat.input.mentioned ~= '' and chat.input.text ~= chat.input.mentioned then chat.input.mentioned = '' end
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
    ui.pushClipRect(ui.getCursor(), ui.getCursor() + inputBoxSize - scaleVec2(0, 9, true))
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
            emoji.picker = false
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

---Draws latest message notifications.
local function drawNotifications()
  local queue = notification.queue
  if not getActiveNotification() then return end

  local maxDistance = scaleNum(notification.maxDistance)
  local bannerSize = scaleVec2(257, 75)
  local imgSize = scaleVec2(15, 15)
  local titleFontSize = scaleNum(10)
  local contentFontSize = scaleNum(12)
  local contentFontColor = colors.final.elements
  local bodyMaxWidth = scaleNum(230)

  local bannerPos = scaleVec2(16, 46) + vec2(0, movement.smooth)

  for i = 1, #queue do
    local notif = queue[i]
    if notif.state ~= 'queued' then
      ui.setCursor(bannerPos)
      ui.childWindow('NotificationDropDown' .. i, bannerSize, false, flags.window, function()
        ui.offsetCursorY(notif.smooth - maxDistance)
        ui.drawRectFilled(ui.getCursor(), ui.getCursor() + bannerSize, colors.final.notifBg, scaleNum(13), ui.CornerFlags.All)
        ui.glowEllipseFilled(ui.getCursor() + (bannerSize / 2), scaleVec2(100, 25), colors.final.notifBgBlur)
        ui.offsetCursor(scaleVec2(10, 10))
        ui.drawImageRounded(app.images.defaultMessage, ui.getCursor(), ui.getCursor() + imgSize, scaleNum(3), ui.CornerFlags.All)

        ui.offsetCursor(scaleVec2(20, 1))
        ui.pushDWriteFont(app.font.regular)
        ui.dwriteDrawText('MESSAGES', titleFontSize, ui.getCursor(), colors.final.notifTitle)
        ui.dwriteDrawText('now', titleFontSize, ui.getCursor() + scaleVec2(195, 0), colors.final.notifTitle)
        ui.popDWriteFont()

        ui.offsetCursor(scaleVec2(-20, 22))
        ui.pushDWriteFont(app.font.bold)
        ui.dwriteDrawText(notif.title, contentFontSize, ui.getCursor(), contentFontColor)
        ui.popDWriteFont()

        ui.offsetCursor(scaleVec2(0, 17))
        ui.pushDWriteFont(app.font.regular)
        local bodyText = notif.body
        if ui.measureDWriteText(bodyText, contentFontSize).x > bodyMaxWidth then
          while #bodyText > 0 and ui.measureDWriteText(bodyText .. '...', contentFontSize).x > bodyMaxWidth do
            bodyText = bodyText:sub(1, -2)
          end
          bodyText = bodyText .. '...'
        end
        ui.dwriteDrawText(bodyText, contentFontSize, ui.getCursor(), contentFontColor)
        ui.popDWriteFont()

        if notif.state == 'active' and ui.rectHovered(bannerPos, bannerPos + bannerSize) and ui.mouseClicked(ui.MouseButton.Left) then
          notif.phase = 'out'
          moveAppUp()
        end
      end)
    end
  end
end

--#endregion

--#region APP UPDATER

local Updater = require('updater/universal')
local Communities = require('updater/communities')

local appFolder = ac.getFolder(ac.FolderID.ScriptOrigin) .. '\\'
local hasCarKey = #io.scanDir(appFolder, '*.carkey') > 0

Updater.init {
  onUpdateAvailable = function() sendAppMessage('Update Available!\nInstall via App Settings') end,
  onCheckComplete = function() Communities.checkForUpdate(communities) end,
}

--#endregion

--#region APP EVENTS

if player.isOnline then
  ac.onChatMessage(function(message, senderCarIndex)
    local isPlayer = senderCarIndex > -1
    local userName = ac.getDriverName(senderCarIndex) or 'Someone'
    local isFriend = userName ~= 'Someone' and checkIfFriend(userName) or false
    local escapedPlayerName = escapePattern(player.driverName:lower())
    local isMentioned = message:lower():find('%f[%a_]' .. escapedPlayerName .. '%f[%A_]') ~= nil
    local hideReason, shouldAlert = matchMessage(isPlayer, message)

    local hideMessage = hideReason == 'annoying' and settings.chatHideAnnoying or hideReason == 'kickban' and settings.chatHideKickBan or hideReason == 'race' and settings.chatHideRaceMsg

    if shouldAlert then setTimeout(function() playAudio(audio.notification.critical) end, audio.notification.timeout) end

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

      chat.msgCacheGen = chat.msgCacheGen + 1

      if senderCarIndex ~= -1 then
        local prevLatestMsg = chat.messages[chat.latestUserMessage]
        if prevLatestMsg then prevLatestMsg.cache = nil end
        chat.latestUserMessage = #chat.messages
      end

      local suppressNotif = settings.notifBannerHideWhenAppUp and movement.distance == 0

      local fullMovement = true
      if settings.notifBannerEnabled and settings.notifBannerMessages and senderCarIndex ~= 0 and not suppressNotif then
        fullMovement = false
        local hideNotif = (settings.focusMode and not isFriend) or ac.DriverTags(userName).muted
        if not hideNotif then showNotification(isPlayer and userName or 'Server', message, not isPlayer) end
      end

      if not settings.focusMode or isFriend or not isPlayer then moveAppUp(fullMovement) end

      if isPlayer then
        if senderCarIndex == 0 then
          playAudio(audio.message.send)
        else
          if isFriend or not settings.messagesFriendsOnly then playAudio(audio.message.receive) end
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
  local function handleConnectionEvent(connectedCarIndex, action)
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
      chat.msgCacheGen = chat.msgCacheGen + 1

      if settings.messagesServer and (not settings.messagesFriendsOnly or isFriend) then playAudio(audio.message.receive) end
      if settings.notificationsFriendConnections and isFriend then setTimeout(function() playAudio(audio.notification.regular) end, audio.notification.timeout) end

      local suppressNotif = settings.notifBannerHideWhenAppUp and movement.distance == 0

      local fullMovement = true
      if settings.notifBannerEnabled and settings.notifBannerConnections and not suppressNotif then
        fullMovement = false
        local body = userName
        if settings.notifBannerCarName and car then body = body .. ' (' .. car:name() .. ')' end
        showNotification('Just ' .. action:sub(2) .. ' the server', body, true)
      end

      moveAppUp(fullMovement)
    end

    if userName ~= 'A Player' and car then
      if action == ' left' then nonTrafficPlayers[userName] = nil end
    end
  end

  ac.onClientConnected(function(connectedCarIndex)
    if settings.connectionEvents then handleConnectionEvent(connectedCarIndex, ' joined') end
  end)

  ac.onClientDisconnected(function(connectedCarIndex)
    if settings.connectionEvents then handleConnectionEvent(connectedCarIndex, ' left') end
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
  updateNonTrafficPlayers()

  if settings.focusMode then settings.focusMode = false end

  if Updater.state.updateStatus == 5 then sendAppMessage('Update Available!\nInstall via App Settings') end

  chat.msgCacheGen = chat.msgCacheGen + 1
  chat.layout.forceFullRebuild = true

  player.serverCommunity = getServerCommunity()
end

--#endregion

--#region APP SETTINGS WINDOW
function script.windowMainSettings()
  local hideFooter = false
  ui.tabBar('TabBar', function()
    ui.tabItem('Update', function()
      Updater.drawUI()
      hideFooter = true
    end)

    ui.tabItem('App', function()
      ui.tabBar('AppTabs', function()
        ui.tabItem('General', function()
          ui.indent(app.settingsIndentOffset)
          settingsSlider('appScale', 0.5, 2, 'App Scale: %.01f', nil, function(newVal)
            moveAppUp(true)
            local roundedNewScale = math.round(newVal, 1)
            settings.appScale = roundedNewScale
            app.scale = roundedNewScale
            app.images.phoneAtlasSize = ui.imageSize(app.images.phoneAtlasPath):div(vec2(2, 2)):scale(app.scale)
            chat.msgCacheGen = chat.msgCacheGen + 1
          end)
          ui.unindent(app.settingsIndentOffset)

          settingsCheckbox('Force App to Bottom', 'forceBottom', 'If enabled, app will be forced to the bottom of the screen')

          settingsCheckbox('Chat Inactivity Minimizes Phone', 'appMove', 'If enabled, the app will move down to free screen space', function(newVal)
            if newVal then
              movement.up = false
              movement.timer = settings.appMoveTimer
            end
          end)

          if settings.appMove then
            ui.indent(app.settingsIndentOffset)
            settingsSlider('appMoveTimer', 1, 120, 'Inactivity: %.0f seconds', 'Time before app moves down', function(newVal) movement.timer = newVal end)

            settingsSlider('appMoveSpeed', 1, 50, 'Speed: %.0f', 'How fast the app should move up/down')
            ui.unindent(app.settingsIndentOffset)
          end

          settingsCheckbox('Use 12h Clock', 'use12HourClock', 'If enabled, uses 12 hour time format\nMessage timestamps will include AM/PM', function() chat.msgCacheGen = chat.msgCacheGen + 1 end)
        end)

        ui.tabItem('Theme', function()
          settingsCheckbox('Dark Mode', 'darkMode', 'If enabled, app will use dark mode', function(newVal)
            if newVal then settings.darkModeAuto = false end
            updateColors()
          end)

          if not settings.darkMode then
            settingsCheckbox('Automatic Light/Dark Mode', 'darkModeAuto', 'If enabled, app will automatically switch between dark/light mode', function(newVal) updateColors() end)

            if settings.darkModeAuto then
              ui.indent(app.settingsIndentOffset)
              local sim = ac.getSim()
              ui.text(string.format('Current Time: %02d:%02d', sim.timeHours, sim.timeMinutes))

              local darkVal = math.floor(settings.darkModeAutoDarkTime * 2 + 0.5)
              local darkTimeStr = string.format('Dark Mode After: %02d:%02d', math.floor(darkVal / 2), (darkVal % 2) * 30)
              settings.darkModeAutoDarkTime = ui.slider('##darkModeAutoDarkTime', darkVal, 0, 47, darkTimeStr, true) / 2
              lastItemHoveredTooltip('The time at which the app will switch to dark mode')

              local lightVal = math.floor(settings.darkModeAutoLightTime * 2 + 0.5)
              local lightTimeStr = string.format('Light Mode After: %02d:%02d', math.floor(lightVal / 2), (lightVal % 2) * 30)
              settings.darkModeAutoLightTime = ui.slider('##darkModeAutoLightTime', lightVal, 0, 47, lightTimeStr, true) / 2
              lastItemHoveredTooltip('The time at which the app will switch to light mode')
              ui.unindent(app.settingsIndentOffset)
            end
          end

          settingsCheckbox('Custom Message Colors', 'customColor', 'If enabled, allows you to recolor certain elements', function() updateColors() end)
          if settings.customColor then
            ui.offsetCursorY(-5)
            local colorPickerWidth = 130
            ui.dummy(vec2(colorPickerWidth * 2, 0))
            ui.columns(2, false)
            ui.text('Own Messages')
            ui.setNextItemWidth(colorPickerWidth)
            local messageColorSelfChanged = ui.colorPicker('Display Color Picker', settings.messageColorSelf, flags.colorpicker)
            if ui.modernButton('Reset to default' .. '\u{200B}', 0, ui.ButtonFlags.None, nil, app.modernButtonOffset, nil) then
              settings.messageColorSelf = colors.iMessageBlue:clone()
              updateColors()
            end

            ui.nextColumn()

            ui.text('Friend Messages')
            ui.setNextItemWidth(colorPickerWidth)
            local messageColorFriendChanged = ui.colorPicker('Text Color Picker', settings.messageColorFriend, flags.colorpicker)
            if ui.modernButton('Reset to default' .. '\u{200C}', 0, ui.ButtonFlags.None, nil, app.modernButtonOffset, nil) then
              settings.messageColorFriend = colors.iMessageGreen:clone()
              updateColors()
            end

            if messageColorFriendChanged or messageColorSelfChanged then
              settings.messageColorSelf = settings.messageColorSelf:clone()
              settings.messageColorFriend = settings.messageColorFriend:clone()
              updateColors()
            end
            ui.columns(0)
          end
        end)

        ui.tabItem('Music', function()
          settingsCheckbox('Show Music Information', 'songInfo', 'If enabled, shows current song information if detected\nCheck your CSP Music settings if there are issues', function(newVal)
            if not newVal then
              songInfo.final = ''
              songInfo.artist = ''
              songInfo.title = ''
              songInfo.isNotPlaying = false
              setDynamicIslandSize(false)
            end
          end)

          if settings.songInfo then
            ui.indent(app.settingsIndentOffset)

            settingsCheckbox('Always Scroll Text', 'songInfoScrollAlways', 'If enabled, will scroll text even if it could be displayed in full without scrolling', function() updateSongInfo(true) end)

            settingsCheckbox('Auto Spacing', 'songInfoAutoSpacing', 'Automatically spaces the song text based on app size')

            if not settings.songInfoAutoSpacing then settingsSlider('songInfoSpacing', 0, 300, 'Spacing: %.0f', 'The amount of spacing between the end and start of the song', nil, true) end

            settingsSlider('songInfoScrollSpeed', 1, 300, 'Scroll Speed: %.0f', 'Speed that the text is scrolled at')

            local scrollDirStr = settings.songInfoScrollDirection == 0 and 'Left' or 'Right'
            settings.songInfoScrollDirection = ui.slider('##songInfoScrollDirection', settings.songInfoScrollDirection, 0, 1, 'Scroll Direction: ' .. scrollDirStr, true)

            settingsCheckbox('Enable Edge Gradients', 'songInfoGradient', 'If enabled, left and right edges of the text will be blended in with a gradient')
            if settings.songInfoGradient then
              ui.indent(app.settingsIndentOffset)
              settingsSlider('songInfoGradientWidth', 0, 100, 'Gradient Width: %.0f', 'Width of the gradient')
              settingsSlider('songInfoGradientIntensity', 0.01, 1, 'Gradient Intensity: %.2f', 'Intensity of the gradient')
              ui.unindent(app.settingsIndentOffset)
            end

            settingsCheckbox('Hide Selfie Camera', 'songInfoHidesCamera', 'If enabled, will hide the selfie camera below the song information')

            ui.unindent(app.settingsIndentOffset)
          end
        end)
      end)
    end)

    ui.tabItem('Chat', function()
      ui.tabBar('ChatTabs', function()
        ui.tabItem('Visuals', function()
          ui.indent(app.settingsIndentOffset)
          settingsSlider('chatFontSize', 6, 36, 'Chat Fontsize: %.0f', nil, function() chat.msgCacheGen = chat.msgCacheGen + 1 end)

          settingsSlider('chatScrollDistance', 1, 100, 'Chat Scroll Distance: %.0f', 'Distance to scroll the chat per mouse wheel scroll')
          ui.unindent(app.settingsIndentOffset)

          settingsCheckbox('Show Timestamps', 'chatShowTimestamps', 'If enabled, shows message timestamps', function() chat.msgCacheGen = chat.msgCacheGen + 1 end)

          settingsCheckbox('Use Colored Usernames', 'chatUsernameColor', 'If enabled, uses colored usernames if possible\nServers can overwrite CM tag colors')

          settingsCheckbox('Highlight Latest Message', 'chatLatestBold', 'If enabled, text of the latest message will always be bold', function()
            local latestMsg = chat.messages[chat.latestUserMessage]
            if latestMsg then latestMsg.cache = nil end
            chat.msgCacheGen = chat.msgCacheGen + 1
          end)
        end)

        ui.tabItem('Filters', function()
          settingsCheckbox('Chat History Settings', 'chatHistorySettings', 'If enabled, allows you to change the chat message history settings\nDefault:\n500 messages minimum\nAfter 500 messages, the oldest will be removed if they are older than 15 minutes')
          if settings.chatHistorySettings then
            ui.indent(app.settingsIndentOffset)
            settingsSlider('chatKeepSize', 10, 1000, 'Always keep %.0f Messages', 'History will always keep at least this many messages regardless of how old they are')

            settingsSlider('chatOlderThan', 1, 60, 'Remove if older than %.0f min', 'Messages older than this will be removed once the history reaches ' .. settings.chatKeepSize .. ' messages')
            ui.unindent(app.settingsIndentOffset)
          end

          settingsCheckbox('Show Join/Leave Messages', 'connectionEvents', 'If enabled, shows server message when a player joins/leaves the server')
          if settings.connectionEvents then
            ui.indent(app.settingsIndentOffset)
            settingsCheckbox('Friends Only', 'connectionEventsFriendsOnly', 'If enabled, only shows join/leave messages of friends')

            settingsCheckbox('Hide Traffic', 'connectionEventsHideTraffic', 'If enabled, hides join/leave messages of hidden AssettoServer traffic cars')
            ui.unindent(app.settingsIndentOffset)
          end

          settingsCheckbox('Hide Kick Ban Messages', 'chatHideKickBan', 'If enabled, hides kick and ban messages from other players')

          settingsCheckbox('Hide Annoying Messages', 'chatHideAnnoying', 'If enabled, hides annoying messages from apps such as Pit Lane Penalty and Real Penalty')
          if settings.chatHideAnnoying then
            ui.indent(app.settingsIndentOffset)
            settingsCheckbox('AssettoServer Race Challenge Results', 'chatHideRaceMsg', 'If enabled, also hides "X just beat Y in a Race" server messages')
            ui.unindent(app.settingsIndentOffset)
          end
        end)

        ui.tabItem('Notifications', function()
          settingsCheckbox('Enable Notifications', 'notifBannerEnabled', 'If enabled, shows a drop-down notification for new messages\nRespects your Filters tab rules:\nIf you have disables connection event messages, no notification will be shown even if enabled here')
          if settings.notifBannerEnabled then
            ui.indent(app.settingsIndentOffset)
            settingsSlider('notifBannerDuration', 1, 60, 'Show Notification for: %.0f seconds', 'How long the notification banner should be displayed', function(newValue) notification.duration = newValue end)

            settingsCheckbox('Use for New Messages', 'notifBannerMessages', 'If enabled, shows a notification for new chat messages')

            settingsCheckbox('Use for Connection Events', 'notifBannerConnections', 'If enabled, shows a notification when a player joins/leaves the server')
            if settings.notifBannerConnections then
              ui.indent(app.settingsIndentOffset)
              settingsCheckbox('Show Player Selected Car', 'notifBannerCarName', "If enabled, includes the player's car in connection event notifications")
              ui.unindent(app.settingsIndentOffset)
            end

            settingsCheckbox('Hide When App Already Up', 'notifBannerHideWhenAppUp', 'If enabled, no notification banner is shown if the app is already maximized')

            settingsCheckbox('Maximize App on Notification', 'notifBannerFullRaise', 'If enabled, the app maximizes for notifications instead of only peeking up to reveal the banner')

            settingsCheckbox('Prioritize Server Messages', 'notifBannerServerPriority', 'If enabled, queued user chat notifications get skipped so server messages play back to back')

            ui.unindent(app.settingsIndentOffset)
          end
        end)
      end)
    end)

    ui.tabItem('Audio', function()
      settingsCheckbox('Enable Audio', 'enableAudio', 'Toggles all app audio')

      if settings.enableAudio then
        ui.tabBar('AudioTabs', function()
          ui.tabItem('Typing', function()
            settingsCheckbox('Enable Keystroke Audio', 'enableKeyboard', 'If enabled, the app will play keystroke sounds when typing')
            if settings.enableKeyboard then
              ui.indent(app.settingsIndentOffset)
              settingsSlider('volumeKeyboard', 0.1, 10, 'Keystroke Volume: %.1f')
              if ui.modernButton('Play Test Keystroke', 0, ui.ButtonFlags.None, nil, app.modernButtonOffset, nil) then playTestAudio(audio.keyboard) end
              ui.unindent(app.settingsIndentOffset)
            end
          end)

          ui.tabItem('Messages', function()
            settingsCheckbox('Enable Message Audio', 'enableMessage', 'If enabled, the app will play message received sounds')
            if settings.enableMessage then
              ui.indent(app.settingsIndentOffset)
              settingsSlider('volumeMessage', 0.1, 10, 'Message Volume: %.1f')
              if ui.modernButton('Play Test Message', 0, ui.ButtonFlags.None, nil, app.modernButtonOffset, nil) then playTestAudio(audio.message) end

              settingsCheckbox('Friend Only', 'messagesFriendsOnly', 'If enabled, the app will only play the message received sound for player messages from friends')

              settingsCheckbox('Server Messages', 'messagesServer', 'If enabled, the app will play the message received sound for messages from the server')
              ui.unindent(app.settingsIndentOffset)
            end
          end)

          ui.tabItem('Notifications', function()
            settingsCheckbox('Enable Notification Audio', 'enableNotification', 'If enabled, the app will play notification sounds')
            if settings.enableNotification then
              ui.indent(app.settingsIndentOffset)
              settingsSlider('volumeNotification', 0.1, 10, 'Notification Volume: %.1f')
              if ui.modernButton('Play Test Notification', 0, ui.ButtonFlags.None, nil, app.modernButtonOffset, nil) then playTestAudio(audio.notification) end

              settingsCheckbox('@' .. player.driverName .. ' mentions', 'notificationsMentions', 'If enabled, the app will play the notification sound when you are mentioned in chat')

              settingsCheckbox('Friend Messages', 'notificationsFriendMessages', 'If enabled, the app will play the notification sound when a friend sends a chat message')
              if settings.connectionEvents then settingsCheckbox('Friend Join/Leave', 'notificationsFriendConnections', 'If enabled, the app will play the notification sound when a friend joins/leaves the server') end
              ui.unindent(app.settingsIndentOffset)
            end
          end)
        end)
      end
    end)

    if hasCarKey then
      ui.tabItem('Focus Mode', function()
        ui.textColored('IF YOU ENABLE THIS I WILL TAKE NO RESPONSIBILITY\nWHEN YOU IGNORE ADMIN MESSAGES AND GET BANNED', rgbm.colors.red)
        settingsCheckbox('Enable Focus Mode', 'focusMode', 'If enabled, only displays messages from yourself, friends and the server')
      end)
    end
  end)

  if not hideFooter then
    ui.separator()
    ui.textColored('CTRL + LEFT CLICK on sliders to type in exact values', colors.footerText)
  end
end

--#endregion

--#region APP MAIN WINDOW

function script.windowMain(dt)
  app.images.ready = app.images.ready or ui.isImageReady(app.images.phoneAtlasPath)
  if not app.images.ready then return end

  local community = communities[player.serverCommunity]
  if not community.ready then
    community.ready = ui.isImageReady(community.image)
    if community.ready then getAverageCommunityImageColor(community.image) end
  end

  local rounded = math.round(settings.appScale, 1)
  settings.appScale = settings.appScale ~= rounded and rounded or settings.appScale
  app.scale = app.scale ~= settings.appScale and settings.appScale or app.scale

  if app.size == vec2(0, 0) or app.images.phoneAtlasSize == vec2(0, 0) then
    local phoneFull = ui.imageSize(app.images.phoneAtlasPath)
    app.size = app.size == vec2(0, 0) and vec2(phoneFull.x / 4, phoneFull.y / 2) or app.size
    app.images.phoneAtlasSize = app.images.phoneAtlasSize == vec2(0, 0) and phoneFull:div(vec2(2, 2)):scale(app.scale) or app.images.phoneAtlasSize
  end

  if settings.songInfo then songInfo.scrollTime = songInfo.scrollTime + math.min(dt, 1 / 30) * (settings.songInfoScrollSpeed * app.scale) end

  updateAppMovement(dt)
  updateNotifications(dt)
  automaticModeSwitch()
  updateSongInfo()

  app.hovered = ui.windowHovered(bit.bor(ui.HoveredFlags.AllowWhenBlockedByPopup, ui.HoveredFlags.ChildWindows, ui.HoveredFlags.AllowWhenBlockedByActiveItem))
  if app.hovered or chat.input.active then moveAppUp() end

  forceAppIntoScreen()

  ui.childWindow('Phone', vec2(app.images.phoneAtlasSize.x / 2, app.images.phoneAtlasSize.y), false, flags.window, function()
    drawDisplay()

    if not emoji.picker then
      drawMessages()
      drawContact()
    end

    drawStatusBar()
    drawNotifications()
    drawEmojiPicker()
    drawCustomChatInput()
    drawPhone()
  end)
end

--#endregion
