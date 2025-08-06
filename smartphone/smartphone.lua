--made by C1XTZ
--if you're reading any of this let me preface this by saying: If you're going 'what the fuck is this idiot doing??' it's likely that I said the same thing while writing it.
---@meta
---@diagnostic disable: lowercase-global

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

    updateLastCheck = 0,
    updateStatus = 0,
    updateAvailable = false,
    updateURL = '',

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

    dataCheckFailed = false,

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
    hovered = false,
    tooltipPadding = vec2(5, 5),
    images = {
        phoneAtlasPath = '.\\src\\img\\phone.png',
        phoneAtlasSize = vec2(),
        phoneCamera = '.\\src\\img\\cam.png',
        pingAtlasPath = '.\\src\\img\\connection.png',
        emojiPicker = '.\\src\\img\\picker.png',
        defaultCover = '.\\src\\img\\player.png',
    },
    font = {
        regular = ui.DWriteFont('Inter Variable Text', '.\\src\\ttf'):weight(ui.DWriteFont.Weight.Medium),
        bold = ui.DWriteFont('Inter Variable Text', '.\\src\\ttf'):weight(ui.DWriteFont.Weight.Bold),
    },
    modernButtonOffset = (-8) * ac.getUI().uiScale
}

local player = {
    car = ac.getCar(0),
    driverName = ac.getDriverName(0),
    cspVersion = ac.getPatchVersionCode(),
    isOnline = ac.getSim().isOnlineRace,
    serverIP = ac.getServerIP(),
    serverCommunity = 'default',
    timePeriod = '',
    phoneMode = settings.darkMode
}

local communities = stringify.parse(io.load('.\\apps\\lua\\smartphone\\src\\communities\\data\\list.lua') --[[@as string]]) --[[@as table]]

local movement = {
    maxDistance = 487,
    timer = settings.appMoveTimer,
    down = true,
    up = false,
    distance = 0,
    smooth = 0
}

local songInfo = {
    artist = '',
    title = '',
    final = '',
    hasCover = false,
    isPaused = false,
    dynamicIslandSize = vec2(40, 20),
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
    emojis = {},
    usernameColors = {},
    popupVertSpacing = -18 * ac.getUI().uiScale,
    latestNonServerMessage = nil,
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
        pos = pos + (s:byte(pos) >= 0xF0 and 4 or
            s:byte(pos) >= 0xE0 and 3 or
            s:byte(pos) >= 0xC0 and 2 or 1)
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

---@param value number @The value to be scaled.
---@return number @The scaled value.
---Scales the given value by the app scale.
local function scale(value)
    return math.floor(app.scale * value)
end

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
                if ip == player.serverIP then
                    return community
                end
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
    if (index == 0 and color == rgbm.colors.yellow) or (index > 0 and color == rgbm.colors.white) then
        color:set(rgbm.colors.gray)
    end
    local existingColor = chat.usernameColors[name]
    if not existingColor or existingColor == rgbm.colors.gray or color ~= rgbm.colors.gray then
        chat.usernameColors[name] = color
    end
end

---@param light rgbm @rgbm color to use if light mode
---@param dark rgbm @rgbm color to use if dark mode
---@return rgbm @rgbm color to be used for the given mode
---Picks the appropriate color based on the current mode.
local function pickThemeColor(light, dark)
    return (settings.darkMode or player.phoneMode) and dark or light
end

---@param message any @The message to be sent.
---@param deleteAfter? number @The amount of time to wait before deleting the message.
---Sends a chat message as the app using the server index.
local function sendAppMessage(message, deleteAfter)
    table.insert(chat.messages, { -1, 'App', message, os.time() })
    local msgIndex = #chat.messages

    if deleteAfter then
        setTimeout(function()
            table.remove(chat.messages, msgIndex)
        end, deleteAfter)
    end

    moveAppUp()
end

---Loads emojis from the data_emoji.txt file, fully supporting emoji grapheme clusters.
---Disclosure: this piece of shit was vibecoded because it is black magic to me.
local function loadEmojis()
    local path = ac.getFolder(ac.FolderID.ExtCfgSys) .. '\\data_emoji.txt'
    local f = io.open(path, 'r')
    if not f then return {} end
    local content = f:read('*a')
    f:close()

    local emojis = {}
    local vs16 = '\239\184\143'
    local zwj = '\226\128\141'

    for line in content:gmatch('[^\r\n]+') do
        if line:byte(1) ~= 35 and line:find('%S') then
            local i = 1
            local len = #line
            while i <= len do
                local c = line:byte(i)
                if c <= 32 then
                    i = i + 1
                else
                    local clen = (c >= 240 and 4) or (c >= 224 and 3) or (c >= 192 and 2) or 1
                    local cluster = line:sub(i, i + clen - 1)
                    i = i + clen

                    if line:sub(i, i + 2) == vs16 then
                        cluster = cluster .. vs16
                        i = i + 3
                    end

                    while line:sub(i, i + 2) == zwj do
                        cluster = cluster .. zwj
                        i = i + 3
                        if i > len then break end
                        local nc = line:byte(i)
                        local nlen = (nc >= 240 and 4) or (nc >= 224 and 3) or (nc >= 192 and 2) or 1
                        cluster = cluster .. line:sub(i, i + nlen - 1)
                        i = i + nlen
                        if line:sub(i, i + 2) == vs16 then
                            cluster = cluster .. vs16
                            i = i + 3
                        end
                    end

                    emojis[#emojis + 1] = cluster
                end
            end
        end
    end

    chat.emojis = emojis
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
local screenSpace = ac.getSim().windowHeight
local appBottom
---Forces the app to be at the bottom of the screen.
local function forceAppToBottom()
    if not appWindow or not appWindow:valid() then return end

    if not appBottom or appBottom ~= screenSpace - appWindow:size().y then
        appBottom = screenSpace - appWindow:size().y
    end

    if appWindow:position().y ~= appBottom and not ui.isMouseDragging(ui.MouseButton.Left, 0) then
        appWindow:move(vec2(appWindow:position().x, appBottom))
    end
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

    local scaledMaxDistance = scale(movement.maxDistance)

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
    if not settings.enableAudio or not event then return end
    local categoryFound
    for category, events in pairs(audio) do
        for _, eventData in pairs(events) do
            if event == eventData then
                categoryFound = category
                break
            end
        end
        if categoryFound then break end
    end
    if not categoryFound then return end

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
        t[#t + 1] = v
    end

    local key = tbl
    audioIndexes[key] = (audioIndexes[key] or 0) + 1
    if audioIndexes[key] > #t then
        audioIndexes[key] = 1
    end

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
    if player.cspVersion >= 3459 then
        local sunAngle = ac.getSunAngle()
        local timeHours = sim.timeHours

        local shouldBeDark = false
        if (timeHours > 12 and sunAngle > settings.darkModeAutoDarkAngle) or (timeHours < 12 and sunAngle > settings.darkModeAutoLightAngle) then
            shouldBeDark = true
        end

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
---@return vec2 @updated size of the island
---Sets the width of the dynamic island.
local function setDynamicIslandSize(enable)
    local width = enable and 80 or 40
    return songInfo.dynamicIslandSize:set(width, 20)
end

---@param forced? boolean @Whether to force updating the song information even if the artist and title have not changed.
---Updates the global songInfo table with the currently playing track’s artist and title, handles cases of unknown artists or paused playback, and formats the scrolling text display.
local function updateSongInfo(forced)
    if not settings.songInfo then return end
    local current = ac.currentlyPlaying()

    if not forced and current.artist == songInfo.artist and current.title == songInfo.title and current.isPlaying == not songInfo.isPaused then
        return
    end

    if current.artist == '' and current.title == '' and not current.isPlaying then
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
    local textSize = ui.measureDWriteText(text, fontSize)

    if textSize.x <= size.x - scale(4) and not settings.songInfoscrollAlways then
        static = true
    end

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
            ui.dwriteDrawText(text, fontSize, vec2(pos.x + scrollX + i * stepW, pos.y + (size.y - textSize.y) / 2), rgbm.colors.white)
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
            if message:match(pattern) then
                return true
            end
        end
    else
        for _, reason in ipairs(chat.serverHideStrings) do
            if lowerMessage:find(reason) then
                if lowerMessage:find(lowerPlayerName) then
                    setTimeout(function()
                        playAudio(audio.notification.critical)
                    end, audio.notification.timeout)
                else
                    if (lowerMessage:find('^you') or lowerMessage:find('^it is currently night')) then
                        setTimeout(function()
                            playAudio(audio.notification.critical)
                        end, audio.notification.timeout)
                    else
                        return true
                    end
                end
            end
        end

        if settings.chatHideRaceMsg and lowerMessage:find('in a race%%%.$') then
            if not lowerMessage:find('you') and not lowerMessage:find(lowerPlayerName) then
                return true
            end
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
            if not activeUsernames[username] then
                chat.usernameColors[username] = nil
            end
        end
    end
end

---Custom keyboard handling for input field, may god have mercy on my soul.
local function handleKeyboardInput()
    local keyboardInput = ui.captureKeyboard(false, true)
    local msgLen = utf8len(chat.input.text) > 0
    local typed = keyboardInput:queue()
    local inputMaxLen = math.floor(490 * (13 / settings.chatFontSize) ^ 2)

    if (ui.keyPressed(ui.Key.Backspace) or ui.keyPressed(ui.Key.Delete)) then
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

    if ui.itemClicked(ui.MouseButton.Right) then
        playAudio(audio.keyboard.enter)
        ui.openPopup('chatPlayerPopup' .. userIndex)
    end

    if ui.beginPopup('chatPlayerPopup' .. userIndex, ui.WindowFlags.None, 0) then
        moveAppUp()

        if ui.modernMenuItem('Tag in chat', ui.Icons.Tag, false, ui.SelectableFlags.None, false) then
            playAudio(audio.keyboard.keystroke)
            if chat.input.text == chat.input.placeholder then chat.input.text = '' end
            chat.input.active = true
            chat.input.text = chat.input.text .. '@' .. userName
            ui.closePopup()
        end

        ui.newLine(chat.popupVertSpacing)
        ui.separator()

        if player.cspVersion >= 3459 then
            local friendString = ac.DriverTags(userName).friend and 'Remove as Friend' or 'Mark as Friend'
            ui.newLine(chat.popupVertSpacing)
            if ui.modernMenuItem(friendString, ui.Icons.Befriend, false, ui.SelectableFlags.DontClosePopups, false) then
                playAudio(audio.keyboard.enter)
                ac.DriverTags(userName).friend = not ac.DriverTags(userName).friend
            end

            ui.newLine(chat.popupVertSpacing)
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
            ui.newLine(chat.popupVertSpacing)
            ui.separator()

            local watchString = ac.getCar(userIndex).focused and 'Stop Watching' or 'Watch Closely'
            ui.newLine(chat.popupVertSpacing)
            if ui.modernMenuItem(watchString, ui.Icons.VideoCamera, false, ui.SelectableFlags.DontClosePopups, false) then
                playAudio(audio.keyboard.enter)
                if ac.getCar(userIndex).focused then ac.focusCar(0) else ac.focusCar(userIndex) end
            end
        end

        ui.endPopup()
    end
end

--#endregion

--#region DRAWING FUNCTIONS

---Draws the background.
local function drawDisplay()
    ui.drawRectFilled(vec2(scale(5), 0 + movement.smooth), ui.windowSize() - vec2(5, 0):scale(app.scale), colors.final.display, scale(50), ui.CornerFlags.Top)
end

---Draws the iPhone images.
local function drawiPhone()
    ui.setCursor(vec2(0, 0))
    ui.childWindow('OnTopImages', vec2(app.images.phoneAtlasSize.x / 2, app.images.phoneAtlasSize.y), false, flags.window, function()
        ui.drawImage(app.images.phoneAtlasPath, vec2(0, movement.smooth), vec2(app.images.phoneAtlasSize.x / 2, app.images.phoneAtlasSize.y + movement.smooth), rgbm.colors.white, vec2(0 / 2, 0), vec2(1 / 2, 1))
        if not (settings.darkMode or player.phoneMode) then
            local padding = scale(2)
            ui.drawImage(app.images.phoneAtlasPath, vec2(padding, movement.smooth), vec2(math.ceil(app.images.phoneAtlasSize.x / 2 - padding), app.images.phoneAtlasSize.y + movement.smooth), colors.glowColor, vec2(1 / 2, 0), vec2(2 / 2, 1))
        end
    end)
end

---Draws the ping.
local function drawPing()
    local ping = player.car.ping
    local pingSize = vec2(20, 20):scale(app.scale)
    local pingPosition = vec2(scale(238), pingSize.y + movement.smooth)
    local isHovered = app.hovered and ui.rectHovered(pingPosition, pingPosition + pingSize, true)

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

        ui.drawImage(app.images.pingAtlasPath, pingPosition, pingPosition + pingSize, colors.final.elements, vec2(textureStartUV, 0), vec2(textureEndUV, 1))
    else
        if isHovered then ui.tooltip(app.tooltipPadding, function() ui.text('Currently offline or ping unavailable.') end) end

        local animFrame = math.floor(os.clock() * 2) % 3
        local textureStartUV = (2 - animFrame) / 5
        local textureEndUV = (3 - animFrame) / 5

        ui.drawImage(app.images.pingAtlasPath, pingPosition, pingPosition + pingSize, colors.final.elements, vec2(textureStartUV, 0), vec2(textureEndUV, 1))
    end
end

---Draws the time.
local function drawTime()
    local time = os.date('%H:%M') --[[@as string]]
    local timeText = settings.badTime and to12hTime(time) or time
    local timeSize = scale(13)
    local timePosition = vec2(23, 22):scale(app.scale) + vec2(0, movement.smooth)
    ui.setCursor(timePosition)
    ui.pushDWriteFont(app.font.bold)
    local timeTextSize = ui.measureDWriteText(timeText, timeSize)
    ui.dwriteTextAligned(timeText, timeSize, ui.Alignment.Start, ui.Alignment.Center, timeTextSize, false, colors.final.elements)
    ui.popDWriteFont()

    if app.hovered then
        local tooltipText = player.isOnline and 'Current Time: ' .. timeText .. '\nClick to send to chat.' or 'Current Time: ' .. timeText
        lastItemHoveredTooltip(tooltipText, player.isOnline and true or false)
        if ui.itemClicked(ui.MouseButton.Left) and player.isOnline then
            timeText = settings.badTime and timeText .. ' ' .. player.timePeriod or timeText
            sendChatMessage('It\'s currently ' .. timeText .. ' my local time.')
        end
    end
end

---@param winHalfWidth number @Half of the window width.
---Draws the dynamic island.
local function drawDynamicIsland(winHalfWidth)
    local islandSize = songInfo.dynamicIslandSize:clone():scale(app.scale)
    local borderRadius = scale(10)

    ui.drawRectFilled(vec2(winHalfWidth - islandSize.x, islandSize.y + movement.smooth), vec2(winHalfWidth + islandSize.x, islandSize.y * 2 + movement.smooth), rgbm.colors.black, borderRadius)

    if not settings.hideCamera or not settings.songInfo or songInfo.isPaused then
        local camSize = scale(songInfo.dynamicIslandSize.y - 2) / 2
        local camPosX = math.ceil(winHalfWidth + scale(30))
        local camPosY = scale(songInfo.dynamicIslandSize.y * 1.5) + movement.smooth

        ui.drawImage(app.images.phoneCamera, vec2(camPosX - camSize, camPosY - camSize), vec2(camPosX + camSize, camPosY + camSize))
    end
end

---@param winWidth number @Window width.
---@param winHalfWidth number @Half of the window width.
---Draws the header of the chat window.
local function drawHeader(winWidth, winHalfWidth)
    local headerPadding = vec2(11, 9):scale(app.scale)
    local headerSize = vec2(winWidth - scale(11), scale(100) + movement.smooth)
    local headerText = 'Server Chat'
    local headerTextFontsize = scale(12)
    ui.pushDWriteFont(app.font.regular)
    local headerTextSize = ui.measureDWriteText(headerText, headerTextFontsize)

    ui.drawRectFilled(vec2(headerPadding.x, headerPadding.y + movement.smooth), headerSize, colors.final.header, scale(30), ui.CornerFlags.Top)
    ui.drawSimpleLine(vec2(headerPadding.x, headerSize.y), vec2(headerSize.x, headerSize.y), colors.final.headerLine)
    ui.setCursor(vec2(math.floor(winHalfWidth - (headerTextSize.x / 2)), scale(84) + movement.smooth))
    ui.dwriteTextAligned(headerText, headerTextFontsize, 0, 1, headerTextSize, false, colors.final.elements)
    ui.popDWriteFont()

    local headerImageSize = vec2(36, 36):scale(app.scale)
    local headerImagePosition = vec2(129, 47):scale(app.scale) + vec2(0, movement.smooth)
    local headerImageRounding = scale(20)

    if not communities then return error('Communities table is nil.') end

    if ui.isImageReady(communities[player.serverCommunity].image) then
        ui.drawImageRounded(communities[player.serverCommunity].image, headerImagePosition, headerImagePosition + headerImageSize, headerImageRounding, ui.CornerFlags.All)
    else
        ui.drawImageRounded(communities['default'].image, headerImagePosition, headerImagePosition + headerImageSize, headerImageRounding, ui.CornerFlags.All)
    end

    if app.hovered then
        if ui.rectHovered(headerImagePosition, headerImagePosition + headerImageSize) then
            ui.tooltip(app.tooltipPadding, function() ui.text(communities[player.serverCommunity].text .. '\nClick to open in Browser.') end)
            if not ui.isMouseDragging(ui.MouseButton.Left, 0) then ui.setMouseCursor(ui.MouseCursor.Hand) end
            if ui.mouseReleased(ui.MouseButton.Left) then
                playAudio(audio.keyboard.enter)
                os.openURL(communities[player.serverCommunity].url, false)
            end
        end
    end
end

---@param winHalfWidth number @Half of the window width.
---Draws the song information.
local function drawSongInfo(winHalfWidth)
    if settings.songInfo then
        --I'm using --[[@as ui.MediaPlayer]] here because ac.MusicData is not in the valid imageSources for some reason?
        if not songInfo.isPaused then
            local imageSize = vec2(16, 16):scale(app.scale)
            local imageOffset = vec2(-75, 22):scale(app.scale)
            local imageRounding = scale(4)
            local imagePos = vec2(winHalfWidth + imageOffset.x, imageOffset.y + movement.smooth)
            if songInfo.hasCover then
                ui.drawImageRounded(ac.currentlyPlaying() --[[@as ui.MediaPlayer]], imagePos, imagePos + imageSize, imageRounding, ui.CornerFlags.All)
            else
                ui.drawImageRounded(app.images.defaultCover, imagePos, imagePos + imageSize, imageRounding, ui.CornerFlags.All)
            end
        end
        local songFontSize = scale(12)
        local songPosition = vec2(scale(88), scale(22) + movement.smooth)
        local songTextSize = vec2(136, 15):scale(app.scale)
        drawSongInfoText(songInfo.final, songPosition, songTextSize, songFontSize)
        if app.hovered and songInfo.final ~= '' then
            if ui.rectHovered(songPosition, songPosition + songTextSize, true) then
                local tooltipText = player.isOnline and 'Current Song: ' .. songInfo.artist .. ' - ' .. songInfo.title .. '\nClick to send to chat.' or 'Current Song: ' .. songInfo.artist .. ' - ' .. songInfo.title
                if not ui.isMouseDragging(ui.MouseButton.Left, 0) and player.isOnline then ui.setMouseCursor(ui.MouseCursor.Hand) end
                ui.tooltip(app.tooltipPadding, function() ui.text(tooltipText) end)
                if ui.mouseClicked(ui.MouseButton.Left) and player.isOnline then
                    sendChatMessage('I\'m currently listening to: ' .. songInfo.final)
                end
            end
        end
    end
end

---@param winWidth number @Window width.
---@param winHalfWidth number @Half of the window width.
---Draws the chat messages.
local function drawMessages(winWidth, winHalfWidth)
    if not player.isOnline then return end

    ui.pushClipRect(vec2(0, 0), vec2(winWidth, (scale(500) - chat.input.offset) + movement.smooth))
    ui.setCursor(vec2(13, 100):scale(app.scale) + vec2(0, movement.smooth))
    ui.childWindow('Messages', vec2(266, 400 - chat.input.offset):scale(app.scale), false, flags.window, function()
        winWidth = ui.windowWidth()
        winHalfWidth = winWidth / 2
        local messageFontSize = scale(settings.chatFontSize)
        local usernameFontSize = scale(settings.chatFontSize - 2)
        local timestampFontSize = scale(settings.chatFontSize - 4)
        local usernameOffset = vec2(scale(10), usernameFontSize + scale(13))
        local messagePadding = vec2(15, 10):scale(app.scale)
        local messageMaxWidth = scale(250)
        local messageRounding = scale(10)
        if #chat.messages > 0 then
            local msgDist = scale(370)
            local lastDrawnUserIndex = nil
            local lastDrawnUserName = nil

            for i = 1, #chat.messages do
                local message = chat.messages[i]
                local messageUserIndex = message[1]
                local messageUserIndexLast = lastDrawnUserIndex
                local messageUsername = message[2]
                local messageUsernameLast = lastDrawnUserName
                local messageUsernameColor = rgbm.colors.gray
                if settings.chatUsernameColor then messageUsernameColor = chat.usernameColors[messageUsername] or rgbm.colors.gray end
                local messageTextContent = message[3]
                local messageTime = message[4]
                local messageTimestamp = settings.badTime and to12hTime(os.date('%H:%M', messageTime) --[[@as string]]) .. ' ' .. player.timePeriod or os.date('%H:%M', messageTime) --[[@as string]]

                local fontWeight = app.font.regular

                if (settings.focusMode and (messageUserIndex > 0 and not checkIfFriend(messageUsername))) or ac.DriverTags(messageUsername).muted then goto continue end

                if (i == chat.latestNonServerMessage and settings.chatLatestBold) or (messageTextContent:lower():find('%f[%a_]' .. player.driverName:lower() .. '%f[%A_]') and messageUserIndex > 0) then
                    fontWeight = app.font.bold
                else
                    fontWeight = app.font.regular
                end

                if messageUserIndex == 0 then
                    ui.pushDWriteFont(app.font.bold)
                    local userNameTextSize = ui.measureDWriteText(messageUsername, usernameFontSize)

                    if (not messageUserIndexLast or messageUserIndexLast ~= messageUserIndex) or (not messageUsernameLast or messageUsernameLast ~= messageUsername) then
                        if messageUserIndexLast and messageUserIndexLast ~= -1 then msgDist = math.ceil(msgDist - usernameOffset.y / 2) end
                        ui.setCursor(vec2(usernameOffset.x, msgDist))
                        ui.dwriteTextAligned(messageUsername, usernameFontSize, ui.Alignment.End, ui.Alignment.Start, vec2(messageMaxWidth, userNameTextSize.y), false, messageUsernameColor)
                        msgDist = math.ceil(msgDist + usernameOffset.y)
                    end

                    ui.popDWriteFont()
                    ui.pushDWriteFont(fontWeight)
                    local messageTextSize = ui.measureDWriteText(messageTextContent, messageFontSize, scale(190))
                    msgDist = math.ceil(msgDist + messageTextSize.y)
                    ui.setCursor(vec2(winWidth - scale(5), msgDist))
                    ui.drawRectFilled(ui.getCursor() - vec2(math.ceil(messageTextSize.x + messagePadding.x), math.ceil(messageTextSize.y + messagePadding.y)), ui.getCursor(), colors.final.messageOwn, messageRounding)
                    ui.setCursor(ui.getCursor() - vec2(math.ceil(messageTextSize.x + messagePadding.x / 2), math.ceil(messageTextSize.y + messagePadding.y / 2)))
                    ui.dwriteTextAligned(messageTextContent, messageFontSize, ui.Alignment.Start, ui.Alignment.Start, vec2(messageTextSize.x, messageTextSize.y + messageRounding), true, colors.final.messageOwnText)
                    ui.popDWriteFont()

                    if settings.chatShowTimestamps then
                        ui.pushDWriteFont(app.font.bold)
                        local timestampSize = ui.measureDWriteText(messageTimestamp, timestampFontSize)
                        ui.setCursor(vec2(math.ceil(winWidth - timestampSize.x - scale(6)), msgDist))
                        ui.dwriteTextAligned(messageTimestamp, timestampFontSize, ui.Alignment.Start, ui.Alignment.Start, timestampSize, true, rgbm.colors.gray)
                        ui.popDWriteFont()
                        msgDist = math.ceil(msgDist + timestampSize.y)
                    end

                    msgDist = math.ceil(msgDist + messagePadding.y + messagePadding.y / 2)
                elseif messageUserIndex > 0 then
                    local bubbleColor, messageTextColor = colors.final.message, pickThemeColor(rgbm.colors.black, rgbm.colors.white)

                    if checkIfFriend(messageUsername) then
                        bubbleColor = colors.final.messageFriend
                        messageTextColor = colors.final.messageFriendText
                    end

                    ui.pushDWriteFont(app.font.bold)
                    local userNameTextSize = ui.measureDWriteText(messageUsername, usernameFontSize)

                    if (not messageUserIndexLast or messageUserIndexLast ~= messageUserIndex) or (not messageUsernameLast or messageUsernameLast ~= messageUsername) then
                        if messageUserIndexLast and messageUserIndexLast ~= -1 then msgDist = math.ceil(msgDist - usernameOffset.y / 2) end
                        ui.setCursor(vec2(usernameOffset.x / 2, msgDist))
                        ui.dwriteTextAligned(messageUsername, usernameFontSize, ui.Alignment.Start, ui.Alignment.Start, vec2(math.min(userNameTextSize.x, messageMaxWidth), userNameTextSize.y), false, messageUsernameColor)
                        msgDist = math.ceil(msgDist + usernameOffset.y)

                        if app.hovered then
                            if ui.itemHovered() then
                                ui.setMouseCursor(ui.MouseCursor.Hand)
                                if ac.getDriverName(messageUserIndex) == messageUsername then ui.setDriverTooltip(messageUserIndex) end
                            end
                            chatPlayerPopup(messageUserIndex, messageUsername)
                        end
                    end

                    ui.popDWriteFont()
                    ui.pushDWriteFont(fontWeight)
                    local messageTextSize = ui.measureDWriteText(messageTextContent, messageFontSize, scale(190))
                    msgDist = math.ceil(msgDist + messageTextSize.y)
                    ui.setCursor(vec2(math.ceil(messageTextSize.x + messagePadding.x + scale(5)), msgDist))
                    ui.drawRectFilled(ui.getCursor() - vec2(math.ceil(messageTextSize.x + messagePadding.x), math.ceil(messageTextSize.y + messagePadding.y)), ui.getCursor(), bubbleColor, messageRounding)
                    ui.setCursor(ui.getCursor() - vec2(math.ceil(messageTextSize.x + messagePadding.x / 2), math.ceil(messageTextSize.y + messagePadding.y / 2)))
                    ui.dwriteTextAligned(messageTextContent, messageFontSize, ui.Alignment.Start, ui.Alignment.Start, vec2(messageTextSize.x, messageTextSize.y + messageRounding), true, messageTextColor)
                    ui.popDWriteFont()

                    if settings.chatShowTimestamps then
                        ui.pushDWriteFont(app.font.bold)
                        local timestampSize = ui.measureDWriteText(messageTimestamp, timestampFontSize)
                        ui.setCursor(vec2(scale(5), msgDist))
                        ui.dwriteTextAligned(messageTimestamp, timestampFontSize, ui.Alignment.Start, ui.Alignment.Start, timestampSize, true, rgbm.colors.gray)
                        ui.popDWriteFont()
                        msgDist = math.ceil(msgDist + timestampSize.y)
                    end

                    msgDist = math.ceil(msgDist + messagePadding.y + messagePadding.y / 2)
                elseif messageUserIndex == -1 then
                    ui.pushDWriteFont(app.font.bold)
                    local messageTextSize = ui.measureDWriteText(messageTextContent, messageFontSize, scale(220))

                    if lastDrawnUserIndex == nil then
                        msgDist = math.ceil(msgDist - messageTextSize.y / 2)
                        ui.setCursor(vec2(math.ceil(winHalfWidth - messageTextSize.x / 2), math.ceil(msgDist)))
                        ui.dwriteTextAligned(messageTextContent, messageFontSize, ui.Alignment.Center, ui.Alignment.Start, vec2(messageTextSize.x, messageTextSize.y + messageRounding), true, rgbm.colors.gray)
                        ui.popDWriteFont()
                        msgDist = math.ceil(msgDist + messageTextSize.y + messagePadding.y / 2)
                    else
                        if lastDrawnUserIndex == messageUserIndex then
                            ui.setCursor(vec2(math.ceil(winHalfWidth - messageTextSize.x / 2), math.ceil(msgDist)))
                            ui.dwriteTextAligned(messageTextContent, messageFontSize, ui.Alignment.Center, ui.Alignment.Start, vec2(messageTextSize.x, messageTextSize.y + messageRounding), true, rgbm.colors.gray)
                            ui.popDWriteFont()
                            msgDist = math.ceil(msgDist + messageTextSize.y + messagePadding.y / 2)
                        else
                            msgDist = math.ceil(msgDist - messagePadding.y)
                            ui.setCursor(vec2(math.ceil(winHalfWidth - messageTextSize.x / 2), math.ceil(msgDist)))
                            ui.dwriteTextAligned(messageTextContent, messageFontSize, ui.Alignment.Center, ui.Alignment.Start, vec2(messageTextSize.x, messageTextSize.y + messageRounding), true, rgbm.colors.gray)
                            ui.popDWriteFont()
                            msgDist = math.ceil(msgDist + messageTextSize.y + messagePadding.y / 2)
                        end
                    end
                end

                lastDrawnUserIndex = messageUserIndex
                lastDrawnUserName = messageUsername

                if (not app.hovered or chat.scrollBool) or (chat.input.active and chat.input.hovered) and ui.getScrollY() ~= ui.getScrollMaxY() then ui.setScrollHereY(-1) end

                ::continue::
            end
        end

        if (app.hovered and not chat.emojiPicker) and ui.mouseWheel() ~= 0 then
            local mouseWheel = (ui.mouseWheel() * -1) * (scale(settings.chatScrollDistance))
            ui.setScrollY(mouseWheel, true, true)
        end
    end)
    ui.popClipRect()
end

---@param winHeight number @Window height.
---Draws the emoji picker button and window.
local function drawEmojiPicker(winHeight)
    local buttonPos = vec2(26, 17):scale(app.scale)
    local buttonSize = vec2(24, 24):scale(app.scale)
    local buttonBgRad = scale(12)
    local emojiSizePicker = scale(20)
    ui.pushDWriteFont(app.font.regular)
    local emojiSize = ui.measureDWriteText('😀', emojiSizePicker)
    if movement.distance > 0 and chat.emojiPicker then chat.emojiPicker = false end

    ui.setCursor(vec2(buttonPos.x, winHeight - buttonPos.y + movement.smooth))
    local cursorPos = ui.getCursor()
    ui.drawImage(app.images.emojiPicker, cursorPos - buttonSize / 2, cursorPos + buttonSize / 2, colors.final.emojiPicker)

    if not player.isOnline then return end

    if app.hovered then
        cursorPos = ui.getCursor()
        chat.emojiPickerHovered = ui.rectHovered(cursorPos - buttonSize / 2, cursorPos + buttonSize / 2 + movement.smooth)

        if chat.emojiPickerHovered and ui.mouseReleased(ui.MouseButton.Left) then
            chat.emojiPicker = not chat.emojiPicker
            playAudio(audio.keyboard.enter)
        end

        if chat.emojiPickerHovered then
            if not ui.isMouseDragging(ui.MouseButton.Left, 0) then ui.setMouseCursor(ui.MouseCursor.Hand) end
            ui.drawEllipseFilled(vec2(buttonPos.x, winHeight - buttonPos.y + movement.smooth), buttonBgRad, colors.final.emojiPickerBG, 100)
        end
    end

    if not chat.emojiPicker then
        ui.popDWriteFont()
        return
    end

    local windowSize = vec2(185, 235):scale(app.scale)
    local windowPos = vec2(18, 272):scale(app.scale)
    local rounding = scale(10)
    local emojiStartPos = vec2(5, 0):scale(app.scale)
    local emojiOffset = vec2(0, 2):scale(app.scale)
    local emojisPerRow = 6
    local emojiCount = #chat.emojis
    local bottomPadding = scale(8)

    ui.setCursor(vec2(windowPos.x, winHeight - windowPos.y - chat.input.offset))

    ui.childWindow('EmojiPickerBG', windowSize, false, flags.emojiWindow, function()
        ui.drawRectFilled(vec2(0, 0), windowSize, colors.final.message, rounding)

        ui.setCursor(vec2(0, 0))
        ui.childWindow('EmojiPickerEmojis', windowSize, false, flags.emojiWindow, function()
            ui.dummy(emojiStartPos)
            ui.setCursorX(emojiStartPos.x)
            ui.beginGroup(windowSize.x)

            for i = 1, emojiCount do
                cursorPos = ui.getCursor()
                if ui.rectHovered(cursorPos, cursorPos + emojiSize) then
                    chat.emojiPickerHovered = true
                    if not ui.isMouseDragging(ui.MouseButton.Left, 0) then ui.setMouseCursor(ui.MouseCursor.Hand) end
                    ui.drawRectFilled(cursorPos + emojiOffset, cursorPos + emojiSize + emojiOffset, colors.iMessageSelected, scale(5))
                end

                ui.beginOutline()
                ui.dwriteText(chat.emojis[i], emojiSizePicker)
                ui.endOutline(colors.transparent.black10, scale(2))

                if ui.itemClicked(ui.MouseButton.Left, true) then
                    playAudio(audio.keyboard.keystroke)
                    if not chat.input.active then chat.input.active = true end
                    if chat.input.text == chat.input.placeholder then chat.input.text = '' end
                    chat.input.text = chat.input.text .. chat.emojis[i]
                end

                ui.sameLine(0, emojiOffset.y)
                if i % emojisPerRow == 0 and i ~= emojiCount then
                    ui.newLine(emojiOffset.y)
                end
            end

            ui.newLine(bottomPadding)
            ui.endGroup()
        end)
    end)

    ui.popDWriteFont()
end

---@param winHeight number @Window height.
---Draws the custom input box for the chat.
local function drawInputCustom(winHeight)
    local inputSize = vec2(235, 32):scale(app.scale) + vec2(0, chat.input.offset)
    local inputBoxSize = inputSize - vec2(5, 5):scale(app.scale)
    local inputFontSize = scale(settings.chatFontSize)
    local inputWrap = scale(190)
    ui.setCursor(vec2(scale(42), (winHeight - scale(32) - chat.input.offset) + movement.smooth))
    ui.childWindow('ChatInput', inputSize, false, flags.input, function()
        ui.beginOutline()
        ui.drawRectFilled(vec2(2, 2):scale(app.scale), inputBoxSize, colors.final.display, scale(10))
        ui.endOutline(pickThemeColor(colors.transparent.black10, colors.transparent.white10), math.max(1, math.round(1 * app.scale, 1)))
        local displayText = ''
        ui.pushDWriteFont(app.font.regular)

        if player.isOnline then
            chat.input.hovered = ui.windowHovered(ui.HoveredFlags.RectOnly)
            local inputClicked = chat.input.hovered and ui.mouseClicked(ui.MouseButton.Left)

            if chat.input.hovered then
                ui.setMouseCursor(ui.MouseCursor.TextInput)
            end

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

                if withCaret > textSize then
                    inputWrap = inputWrap + scale(4)
                end

                displayText = displayText .. '|'
            end
        else
            displayText = chat.input.placeholder
        end

        if chat.input.selected then
            local selectedTextSize = ui.measureDWriteText(chat.input.text, inputFontSize, inputWrap) + vec2(4, 0):scale(app.scale)
            ui.setCursor(vec2(8, 6):scale(app.scale))
            ui.drawRectFilled(ui.getCursor(), ui.getCursor() + selectedTextSize, colors.iMessageSelected)
        end

        local inputTextSize = ui.measureDWriteText(displayText, inputFontSize, inputWrap):max(vec2(0, math.round(17.291 * app.scale, 3)))
        ui.setCursor(vec2(10, 6):scale(app.scale))
        ui.pushClipRect(ui.getCursor(), ui.getCursor() + inputBoxSize - vec2(0, 9):scale(app.scale) + movement.smooth)
        ui.dwriteTextAligned(displayText, inputFontSize, ui.Alignment.Start, ui.Alignment.End, inputTextSize, true, colors.final.input)
        ui.popDWriteFont()
        ui.popClipRect()

        if not player.isOnline then return end

        if chat.input.text ~= chat.input.placeholder and chat.input.text ~= '' then
            local circleRad = scale(10)
            local circlePadding = circleRad + scale(2)
            local arrowRad = vec2(7, 7):scale(app.scale)
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

        chat.input.offset = math.min(math.floor(inputTextSize.y - scale(17)), scale(390))
    end)
end

--#endregion

--#region APP UPDATER

local updateStatus = {
    text = {
        [0] = 'C1XTZ: You shouldn\'t be reading this',
        [1] = 'Updated: The app was successfully updated',
        [2] = 'No Change: The latest version is already installed',
        [3] = 'No Change: A newer version is already installed',
        [4] = 'Error: Something went wrong, aborted update',
        [5] = 'Update Available to Download and Install'
    },
    color = {
        [0] = rgbm.colors.white,
        [1] = rgbm.colors.lime,
        [2] = rgbm.colors.white,
        [3] = rgbm.colors.white,
        [4] = rgbm.colors.red,
        [5] = rgbm.colors.lime
    }
}

local appName = 'smartphone'
local appFolder = ac.getFolder(ac.FolderID.ACApps) .. '\\lua\\' .. appName .. '\\'
local manifest = ac.INIConfig.load(appFolder .. '\\manifest.ini', ac.INIFormat.Extended)
local appVersion = manifest:get('ABOUT', 'VERSION', 0.01)
local releaseURL = 'https://api.github.com/repos/C1XTZ/ac-smartphone/releases/latest'
local mainFile, assetFile = appName .. '.lua', appName .. '.zip'
local carKeyFile = #io.scanDir(appFolder, '*.carkey') > 0

---@param downloadUrl string @The URL to download the update from
---Applies the update from the specified URL.
local function updateApplyUpdate(downloadUrl)
    web.get(downloadUrl, function(downloadErr, downloadResponse)
        if downloadErr then
            settings.updateStatus = 4
            error(downloadErr)
            return
        end

        local mainFileContent
        for _, file in ipairs(io.scanZip(downloadResponse.body)) do
            local content = io.loadFromZip(downloadResponse.body, file)
            if content then
                local filePath = file:match('(.*)')
                if filePath then
                    filePath = filePath:gsub(appName .. '/', '')
                    if filePath == mainFile then
                        mainFileContent = content
                    else
                        if io.save(appFolder .. filePath, content) then print('Updating: ' .. file) end
                    end
                end
            end
        end

        if mainFileContent then
            if io.save(appFolder .. mainFile, mainFileContent) then print('Updating: ' .. mainFile) end
        end

        settings.updateStatus = 1
        settings.updateAvailable = false
        settings.updateURL = ''
    end)
end

---Updates the community data from github.
local function updateCommunityData()
    web.get('https://raw.githubusercontent.com/C1XTZ/ac-smartphone/master/smartphone/src/communities/data/list.lua', function(err, response)
        if err or response.status ~= 200 then
            settings.dataCheckFailed = true
            return error('Couldn\'t get community data from github.')
        end

        local data = stringify.parse(response.body)
        if not data or not communities then return error('Web request or Communities table is nil.') end
        if communities.version[1] == data.version[1] then
            return ac.log('Already using latest community data.')
        end

        local file = io.open(ac.getFolder(ac.FolderID.ACAppsLua) .. '\\smartphone\\src\\communities\\data\\list.lua', 'w+')
        if file then
            file:write(stringify(data))
            file:close()
        end

        for name, community in pairs(data --[[@as table]]) do
            if name ~= 'default' and community.image then
                local filename = community.image:match('([^\\]+)$')
                local remoteImageUrl = 'https://raw.githubusercontent.com/C1XTZ/ac-smartphone/master/smartphone/src/communities/img/' .. filename
                web.get(remoteImageUrl, function(err2, response2)
                    if err2 or response2.status ~= 200 then
                        settings.dataCheckFailed = true
                        return err2('Couldn\'t get community data from github.')
                    end
                    io.save(community.image, response2.body)
                end)
            end
        end
        settings.dataCheckFailed = false
        return ac.log('Updated to latest community data.')
    end)
end

---@param forced? boolean @Forces the update check to run.
---Checks for updates and handles the app update process.
local function updateCheckVersion(forced)
    local now = os.time()
    local checkInterval = settings.updateLastCheck and 3600 or 43200
    if now - settings.updateLastCheck <= checkInterval and not forced then return end
    settings.updateLastCheck = now

    web.get(releaseURL, function(err, response)
        if err then
            settings.updateStatus = 4
            return error(err)
        end

        local latestRelease = JSON.parse(response.body)
        local tagName, releaseAssets, getDownloadUrl = latestRelease.tag_name, latestRelease.assets, function(asset) return asset.browser_download_url end

        if not (tagName and tagName:match('^v%d%d?%.%d%d?$')) then
            settings.updateStatus = 4
            return error('URL unavailable or no Version recognized, aborted update')
        end

        local version = tonumber(tagName:sub(2))

        if appVersion > version then
            settings.updateStatus = 3
            settings.updateAvailable = false
        elseif appVersion == version then
            settings.updateStatus = 2
            settings.updateAvailable = false
        else
            local downloadUrl
            for _, asset in ipairs(releaseAssets) do
                if asset.name == assetFile then
                    downloadUrl = getDownloadUrl(asset)
                    break
                end
            end

            if not downloadUrl then
                settings.updateStatus = 4
                return error('No matching asset found, aborted update')
            end

            sendAppMessage('Update Available!\nInstall via App Settings')
            settings.updateAvailable = true
            settings.updateURL = downloadUrl
            settings.updateStatus = 5
        end

        if settings.updateStatus ~= 5 then
            updateCommunityData()
        end
    end)
end

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

            table.insert(chat.messages, { senderCarIndex, isPlayer and userName or 'Server', message, os.time() })

            if not settings.focusMode or isFriend or not isPlayer then moveAppUp() end

            if senderCarIndex ~= -1 then chat.latestNonServerMessage = #chat.messages end

            if isPlayer then
                if senderCarIndex == 0 then
                    playAudio(audio.message.send)
                else
                    if isFriend or settings.messagesNonFriends then
                        playAudio(audio.message.receive)
                    end
                    if (isFriend and settings.notificationsFriendMessages) or (isMentioned and settings.notificationsMentions) then
                        setTimeout(function()
                            playAudio(audio.notification.regular)
                        end, audio.notification.timeout)
                    end
                end
            else
                if settings.messagesServer then
                    playAudio(audio.message.receive)
                end
            end
        end
        return false
    end)
end

if player.isOnline then
    ---@param connectedCarIndex number @Car index of the car that joined/left
    ---@param action string @joined/left string
    ---Adds system messages for join/leave events.
    local function connectionHandler(connectedCarIndex, action)
        local userName = ac.getDriverName(connectedCarIndex) or 'Someone'
        local isFriend = userName ~= 'Someone' and checkIfFriend(userName) or false

        if not settings.connectionEventsFriendsOnly or isFriend then
            deleteOldestMessages()
            table.insert(chat.messages, { -1, 'Server', userName .. action .. ' the Server', os.time() })

            if settings.messagesServer and (settings.messagesNonFriends or isFriend) then playAudio(audio.message.receive) end
            if settings.notificationsFriendConnections and isFriend then
                setTimeout(function()
                    playAudio(audio.notification.regular)
                end, audio.notification.timeout)
            end

            moveAppUp()
        end
    end

    ac.onClientConnected(function(connectedCarIndex)
        if settings.connectionEvents then connectionHandler(connectedCarIndex, ' joined') end
    end)

    ac.onClientDisconnected(function(connectedCarIndex)
        if settings.connectionEvents then connectionHandler(connectedCarIndex, ' left') end
    end)
end

function onShowWindow()
    updateCheckVersion()
    updateColors()
    updateSongInfo(true)
    loadEmojis()

    if settings.focusMode then settings.focusMode = false end

    if app.scale ~= math.round(settings.appScale, 1) then
        app.scale = math.round(settings.appScale, 1)
        app.images.phoneAtlasSize = ui.imageSize(app.images.phoneAtlasPath):scale(app.scale)
    end

    player.serverCommunity = getServerCommunity()
end

--#endregion

--#region APP SETTINGS WINDOW

function script.windowMainSettings()
    ui.tabBar('TabBar', function()
        ui.tabItem('Update', function()
            ui.text(appName:gsub('^%l', string.upper) .. ' Version ' .. string.format('%.2f', appVersion))

            local updateButtonText = settings.updateAvailable and 'Install Update' or 'Check for Update'

            if ui.modernButton(updateButtonText, 0, ui.ButtonFlags.None, nil, app.modernButtonOffset, nil) then
                if settings.updateAvailable then
                    updateApplyUpdate(settings.updateURL)
                else
                    updateCheckVersion(true)
                end
            end

            local diff = os.time() - settings.updateLastCheck
            if diff > 600 then settings.updateStatus = 0 end
            local units = { 'seconds', 'minutes', 'hours', 'days' }
            local values = { 1, 60, 3600, 86400 }

            local i = #values
            while i > 1 and diff < values[i] do
                i = i - 1
            end

            local timeAgo = math.floor(diff / values[i])
            ui.text('Last checked ' .. timeAgo .. ' ' .. units[i] .. ' ago')

            if settings.updateStatus > 0 then ui.textColored(updateStatus.text[settings.updateStatus], updateStatus.color[settings.updateStatus]) end
        end)
        ui.tabItem('App', function()
            ui.indent()

            settings.appScale = ui.slider('##AppScale', settings.appScale, 0.5, 2, 'App Scale: ' .. '%.01f%')
            if app.scale ~= math.round(settings.appScale, 1) then
                moveAppUp()
                app.scale = math.round(settings.appScale, 1)
                app.images.phoneAtlasSize = ui.imageSize(app.images.phoneAtlasPath):scale(app.scale)
            end

            ui.unindent()

            if ui.checkbox('Dark Mode', settings.darkMode) then
                settings.darkMode = not settings.darkMode
                if settings.darkMode then settings.darkModeAuto = false end
                updateColors()
            end
            lastItemHoveredTooltip('If enabled, app will use dark mode.')

            if not settings.darkMode then
                if ui.checkbox('Automatic Light/Dark Mode', settings.darkModeAuto) then settings.darkModeAuto = not settings.darkModeAuto end
                updateColors()
                lastItemHoveredTooltip('If enabled, app will automatically switch between dark/light mode.')
                if settings.darkModeAuto then
                    ui.indent()
                    if player.cspVersion >= 3459 then
                        ui.text('Current Sun Angle: ' .. math.round(ac.getSunAngle(), 1) .. '°')

                        settings.darkModeAutoDarkAngle = ui.slider('##darkModeAutoDarkAngle', settings.darkModeAutoDarkAngle, 0, 180, 'Evening Sun Angle: ' .. '%.0f°')
                        lastItemHoveredTooltip('The angle at which the app will switch to dark mode.\nLower values mean earlier in the day.')

                        settings.darkModeAutoLightAngle = ui.slider('##darkModeAutoLightAngle', settings.darkModeAutoLightAngle, 0, 180, 'Morning Sun Angle: ' .. '%.0f°')
                        lastItemHoveredTooltip('The angle at which the app will switch to light mode.\nLower values mean later in the day.')
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

            if ui.checkbox('Force App to Bottom', settings.forceBottom) then settings.forceBottom = not settings.forceBottom end
            lastItemHoveredTooltip('If enabled, app will be forced to the bottom of the screen.')

            if ui.checkbox('Use 12h Clock', settings.badTime) then settings.badTime = not settings.badTime end
            lastItemHoveredTooltip('If enabled, uses 12 hour time format.\nMessage timestamps will include AM/PM.')

            if ui.checkbox('Show Music Information', settings.songInfo) then
                settings.songInfo = not settings.songInfo
                if not settings.songInfo then
                    songInfo.final = ''
                    songInfo.artist = ''
                    songInfo.title = ''
                    songInfo.isPaused = false
                    setDynamicIslandSize(false)
                end
            end
            lastItemHoveredTooltip('If enabled, shows current song information if detected.\nCheck your CSP Music settings if there are issues.')

            if settings.songInfo then
                ui.indent()
                if ui.checkbox('Always Scroll Text', settings.songInfoscrollAlways) then
                    settings.songInfoscrollAlways = not settings.songInfoscrollAlways
                    updateSongInfo(true)
                end
                lastItemHoveredTooltip('If enabled, will scroll text even if it could be displayed statically.')

                if ui.checkbox('Hide Selfie Camera', settings.hideCamera) then settings.hideCamera = not settings.hideCamera end
                lastItemHoveredTooltip('If enabled, will hide the selfie camera below the song information.')

                settings.songInfoSpacing = ui.slider('##Spacing', settings.songInfoSpacing, 0, 300, 'Spacing: %.0f', true)
                lastItemHoveredTooltip('The amount of spacing between the end and start of the song.')

                settings.songInfoScrollSpeed = ui.slider('##ScrollSpeed', settings.songInfoScrollSpeed, 1, 300, 'Scroll Speed: %.0f')
                lastItemHoveredTooltip('Speed that the text is scrolled at.')

                local scrollDirStr = settings.songInfoScrollDirection == 0 and 'Left' or 'Right'
                settings.songInfoScrollDirection = ui.slider('##ScrollDirection', settings.songInfoScrollDirection, 0, 1, 'Scroll Direction: ' .. scrollDirStr, true)
                ui.unindent()
            end
        end)

        ui.tabItem('Chat', function()
            ui.indent()

            settings.chatFontSize = ui.slider('##ChatFontSize', settings.chatFontSize, 6, 36, 'Chat Fontsize: ' .. '%.0f')

            settings.chatScrollDistance = ui.slider('##chatScrollDistance', settings.chatScrollDistance, 1, 100, 'Chat Scroll Distance: ' .. '%.0f')
            lastItemHoveredTooltip('Distance to scroll the chat per mousewheel scroll')

            ui.unindent()

            if ui.checkbox('Chat Inactivity Minimizes Phone', settings.appMove) then
                settings.appMove = not settings.appMove
                if settings.appMove then
                    movement.up = false
                    movement.timer = settings.appMoveTimer
                end
            end
            lastItemHoveredTooltip('If enabled, the app will move down to free screen space.')

            if settings.appMove then
                ui.indent()

                local chatInactive, chatInactiveChange = ui.slider('##appMoveTimer', settings.appMoveTimer, 1, 120, 'Inactivity: ' .. '%.0f seconds')
                settings.appMoveTimer = chatInactive
                if chatInactiveChange then movement.timer = settings.appMoveTimer end
                lastItemHoveredTooltip('Time before app moves down.')

                settings.appMoveSpeed = ui.slider('##appMoveSpeed', settings.appMoveSpeed, 1, 20, 'Speed: ' .. '%.0f')
                lastItemHoveredTooltip('How fast the app should move up/down.')

                ui.unindent()
            end

            if ui.checkbox('Chat History Settings', settings.chatPurge) then settings.chatPurge = not settings.chatPurge end
            lastItemHoveredTooltip('If enabled, allows you to change the chat message history settings')
            if settings.chatPurge then
                ui.indent()

                settings.chatKeepSize = ui.slider('##ChatKeepSize', settings.chatKeepSize, 10, 500, 'Always keep %.0f Messages')

                settings.chatOlderThan = ui.slider('##ChatOlderThan', settings.chatOlderThan, 1, 60, 'Remove if older than %.0f min')

                ui.unindent()
            end

            if ui.checkbox('Use Colored Usernames', settings.chatUsernameColor) then settings.chatUsernameColor = not settings.chatUsernameColor end
            lastItemHoveredTooltip('If enabled, uses colored usernames if possible.\nServers can overwrite CM tag colors.')

            if ui.checkbox('Show Timestamps', settings.chatShowTimestamps) then settings.chatShowTimestamps = not settings.chatShowTimestamps end
            lastItemHoveredTooltip('If enabled, shows message timestamps.')

            if ui.checkbox('Show Join/Leave Messages', settings.connectionEvents) then settings.connectionEvents = not settings.connectionEvents end
            lastItemHoveredTooltip('If enabled, shows server message when a player joins/leaves the server.')
            if settings.connectionEvents then
                ui.indent()

                if ui.checkbox('Friends Only', settings.connectionEventsFriendsOnly) then settings.connectionEventsFriendsOnly = not settings.connectionEventsFriendsOnly end
                lastItemHoveredTooltip('If enabled, only shows join/leave messages of friends.')

                ui.unindent()
            end

            if ui.checkbox('Highlight Latest Message', settings.chatLatestBold) then settings.chatLatestBold = not settings.chatLatestBold end
            lastItemHoveredTooltip('If enabled, text of the latest message will always be bold.')

            if ui.checkbox('Hide Kick Ban Messages', settings.chatHideKickBan) then settings.chatHideKickBan = not settings.chatHideKickBan end
            lastItemHoveredTooltip('If enabled, hides kick and ban messages from other players.')

            if ui.checkbox('Hide Annoying Messages', settings.chatHideAnnoying) then settings.chatHideAnnoying = not settings.chatHideAnnoying end
            lastItemHoveredTooltip('If enabled, hides annoying messages from apps such as Pit Lane Penalty and Real Penalty.')

            if settings.chatHideAnnoying then
                ui.indent()

                if ui.checkbox('Include AssettoServer Race Challenge Messages', settings.chatHideRaceMsg) then settings.chatHideRaceMsg = not settings.chatHideRaceMsg end
                lastItemHoveredTooltip('If enabled, includes "X just beat Y in a Race." server messages.')

                ui.unindent()
            end
        end)

        ui.tabItem('Audio', function()
            if ui.checkbox('Enable Audio', settings.enableAudio) then settings.enableAudio = not settings.enableAudio end
            lastItemHoveredTooltip('Toggles all app audio.')

            ui.indent()
            if settings.enableAudio then
                if ui.checkbox('Enable Keystroke Audio', settings.enableKeyboard) then settings.enableKeyboard = not settings.enableKeyboard end
                lastItemHoveredTooltip('Toggles keystroke sounds when typing.')
                if settings.enableKeyboard then
                    ui.indent()

                    settings.volumeKeyboard = ui.slider('##keyboardVolume', settings.volumeKeyboard, 0.1, 10, 'Keystroke Volume: ' .. '%.1f')

                    if ui.modernButton('Play Test Keystroke', 0, ui.ButtonFlags.None, nil, app.modernButtonOffset, nil) then playTestAudio(audio.keyboard) end

                    ui.unindent()
                end

                if ui.checkbox('Enable Message Audio', settings.enableMessage) then settings.enableMessage = not settings.enableMessage end
                lastItemHoveredTooltip('Toggles message sounds.')
                if settings.enableMessage then
                    ui.indent()

                    settings.volumeMessage = ui.slider('##messageVolume', settings.volumeMessage, 0.1, 10, 'Message Volume: ' .. '%.1f')

                    if ui.modernButton('Play Test Message', 0, ui.ButtonFlags.None, nil, app.modernButtonOffset, nil) then playTestAudio(audio.message) end

                    if ui.checkbox('Non-Friend Messages', settings.messagesNonFriends) then settings.messagesNonFriends = not settings.messagesNonFriends end
                    lastItemHoveredTooltip('Plays message received sound for messages from non-friends.')

                    if ui.checkbox('Server Messages', settings.messagesServer) then settings.messagesServer = not settings.messagesServer end
                    lastItemHoveredTooltip('Plays message received sound for messages from the server.')

                    ui.unindent()
                end

                if ui.checkbox('Enable Notification Audio', settings.enableNotification) then settings.enableNotification = not settings.enableNotification end
                lastItemHoveredTooltip('Toggles notification sounds.')
                if settings.enableNotification then
                    ui.indent()

                    settings.volumeNotification = ui.slider('##notificationVolume', settings.volumeNotification, 0.1, 10, 'Notification Volume: ' .. '%.1f')

                    if ui.modernButton('Play Test Notification', 0, ui.ButtonFlags.None, nil, app.modernButtonOffset, nil) then playTestAudio(audio.notification) end

                    if ui.checkbox('@' .. player.driverName .. ' mentions', settings.notificationsMentions) then settings.notificationsMentions = not settings.notificationsMentions end
                    lastItemHoveredTooltip('Plays notification when you are mentioned in chat.')

                    if ui.checkbox('Friend Messages', settings.notificationsFriendMessages) then settings.notificationsFriendMessages = not settings.notificationsFriendMessages end
                    lastItemHoveredTooltip('Plays notification when friend sends a chat message.')
                    if settings.connectionEvents then
                        if ui.checkbox('Friend Join/Leave', settings.notificationsFriendConnections) then settings.notificationsFriendConnections = not settings.notificationsFriendConnections end
                        lastItemHoveredTooltip('Plays notification when friend joins/leaves the server.')
                    end

                    ui.unindent()
                end
            end
        end)

        ui.tabItem('Coloring', function()
            if ui.checkbox('Enable Custom Coloring', settings.customColor) then
                settings.customColor = not settings.customColor
                updateColors()
            end
            lastItemHoveredTooltip('If enabled, allows you to recolor certain elements.')

            if settings.customColor then
                ui.columns(2, false)
                ui.text('Message Color Own')
                ui.setNextItemWidth(132 * ac.getUI().uiScale)
                local messageColorSelfChange = ui.colorPicker('Display Color Picker', settings.messageColorSelf, flags.colorpicker)
                if ui.modernButton('Reset to default' .. '\u{200B}', 0, ui.ButtonFlags.None, nil, app.modernButtonOffset, nil) then
                    settings.messageColorSelf = colors.iMessageBlue:clone()
                    updateColors()
                end

                ui.nextColumn()

                ui.text('Message Color Friends')
                ui.setNextItemWidth(132 * ac.getUI().uiScale)
                local messageColorFriendChange = ui.colorPicker('Text Color Picker', settings.messageColorFriend, flags.colorpicker)
                if ui.modernButton('Reset to default' .. '\u{200C}', 0, ui.ButtonFlags.None, nil, app.modernButtonOffset, nil) then
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

                if ui.checkbox('Enable Focus Mode', settings.focusMode) then settings.focusMode = not settings.focusMode end
                lastItemHoveredTooltip('If enabled, only displays messages from yourself, friends and the server.')
            end)
        end
    end)
end

--#endregion

--#region APP MAIN WINDOW

function script.windowMain(dt)
    updateAppMovement(dt)
    automaticModeSwitch()
    updateSongInfo()

    local winWidth = ui.windowWidth()
    local winHalfWidth = winWidth / 2
    local winHeight = ui.windowHeight()

    app.hovered = ui.windowHovered(bit.bor(ui.HoveredFlags.AllowWhenBlockedByPopup, ui.HoveredFlags.ChildWindows, ui.HoveredFlags.AllowWhenBlockedByActiveItem))
    player.car = ac.getCar(0)

    if app.images.phoneAtlasSize == vec2(0, 0) then app.images.phoneAtlasSize = ui.imageSize(app.images.phoneAtlasPath):scale(app.scale) end
    if app.hovered or chat.input.active then moveAppUp() end
    if settings.forceBottom then forceAppToBottom() end

    ui.childWindow('Phone', vec2(app.images.phoneAtlasSize.x / 2, app.images.phoneAtlasSize.y), false, flags.window, function()
        drawDisplay()

        drawHeader(winWidth, winHalfWidth)
        drawTime()
        drawPing()
        drawDynamicIsland(winHalfWidth)
        drawSongInfo(winHalfWidth)

        drawMessages(winWidth, winHalfWidth)
        drawEmojiPicker(winHeight)
        drawInputCustom(winHeight)

        drawiPhone()
    end)
end

--#endregion
