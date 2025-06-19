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

    forceBottom = true,
    focusMode = false,

    updateLastCheck = 0,
    updateAutoCheck = false,
    updateInterval = 7,
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

    dataCheckLast = 0,
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
    },
    font = {
        regular = ui.DWriteFont('Inter Variable Text', '.\\src\\ttf'):weight(ui.DWriteFont.Weight.Medium),
        bold = ui.DWriteFont('Inter Variable Text', '.\\src\\ttf'):weight(ui.DWriteFont.Weight.Bold),
    },
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
    isPaused = false,
    dynamicIslandSize = vec2(40, 20)
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
    emojis = {
        '😎', '😄', '😅', '😁', '😂', '😍', '🤩', '😳', '🤠', '🥳',
        '😱', '😤', '😭', '🥴', '🥺', '😡', '🙌', '👍', '👎', '👋',
        '✌️', '🤝', '🙏', '🤷‍♂️', '🤦‍♂️', '🏆', '🎉', '🥇', '🏁', '🚗',
        '🚦', '🛑', '⛽', '⏱️', '🌍', '💡', '❓', '❗', '💬', '🍀',
        '🚀', '💥', '🐢', '🐇', '💀'
    },
    usernameColors = {},
}

local audio = {
    keyboard = {
        keystroke = { file = '.\\src\\aud\\keyboard-keystroke.mp3' },
        enter = { file = '.\\src\\aud\\keyboard-enter.mp3' },
        delete = { file = '.\\src\\aud\\keyboard-delete.mp3' },
    },
    message = {
        recieve = { file = '.\\src\\aud\\message-recieve.mp3' },
        send = { file = '.\\src\\aud\\message-send.mp3' },
    },
    notification = {
        regular = { file = '.\\src\\aud\\notif-regular.mp3' },
        critical = { file = '.\\src\\aud\\notif-critial.mp3' },
    },
}

local flags = {
    window = bit.bor(ui.WindowFlags.NoDecoration, ui.WindowFlags.NoBackground, ui.WindowFlags.NoNav, ui.WindowFlags.NoInputs, ui.WindowFlags.NoScrollbar),
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

---@param value number @The value to be scaled.
---@return number @The scaled value.
---Scales the given value by the app scale.
local function scale(value)
    return math.floor(app.scale * value)
end

---@param title string @combined 'artist - title' string
---@return string @artist name string
---@return string @song title string
---Splits the title string into artist and track name.
local function splitTitle(title)
    local patterns = {
        '^(.-)%s*%- %s*(.+)$',
        '^(.-)%-([^%-]+)$',
    }

    for _, pattern in ipairs(patterns) do
        local artist, track = title:match(pattern)
        if artist and track then
            return artist:match('^%s*(.-)%s*$'), track:match('^%s*(.-)%s*$')
        end
    end

    return 'Unknown Artist', title
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

---@param carIndex number @The index of the car whose drivers friend status is being checked.
---@return boolean @Returns true if the driver at the given index is tagged as a friend.
---Determines whether the driver of the specified car is marked as a friend.
local function checkIfFriend(carIndex)
    if not ac.getDriverName(carIndex) then return false end
    return ac.DriverTags(ac.getDriverName(carIndex) --[[@as string]]).friend
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
---@return rgbm @Driver tag color
---Gets the color of the driver tag for the specified car index.
local function getDriverColor(index)
    local name = ac.getDriverName(index)
    if not name or name == '' then return rgbm.colors.gray end
    local color = ac.DriverTags(name).color:clone()
    if (index == 0 and color == rgbm.colors.yellow) or (index > 0 and color == rgbm.colors.white) then
        color:set(rgbm.colors.gray)
    end
    local existingColor = chat.usernameColors[name]
    if not existingColor or existingColor == rgbm.colors.gray or color ~= rgbm.colors.gray then
        chat.usernameColors[name] = color
    end
    return existingColor and existingColor ~= rgbm.colors.gray and existingColor or color
end

---@param light rgbm @rgbm color to use if light mode
---@param dark rgbm @rgbm color to use if dark mode
---@return rgbm @rgbm color to be used for the given mode
---Picks the appropriate color based on the current mode.
local function pickMode(light, dark)
    return (settings.darkMode or player.phoneMode) and dark or light
end

--#endregion

--#region GENERAL LOGIC FUNCTIONS

---Updates the colors based on the current mode.
local function updateColors()
    colors.final.display:set(pickMode(colors.displayColorLight, colors.displayColorDark))
    colors.final.header:set(pickMode(colors.headerColorLight, colors.headerColorDark))
    colors.final.elements:set(pickMode(colors.displayColorDark, colors.displayColorLight))
    colors.final.headerLine:set(pickMode(colors.headerLineColorLight, colors.headerLineColorDark))
    colors.final.input:set(pickMode(colors.transparent.black50, colors.transparent.white50))
    colors.final.message:set(pickMode(colors.iMessageLightGray, colors.iMessageDarkGray))
    colors.final.emojiPicker:set(pickMode(colors.emojiPickerButtonLight, colors.emojiPickerButtonDark))
    colors.final.emojiPickerBG:set(pickMode(colors.emojiPickerButtonBGLight, colors.emojiPickerButtonBGDark))

    colors.final.messageOwn:set(settings.customColor and settings.messageColorSelf or colors.iMessageBlue)
    colors.final.messageFriend:set(settings.customColor and settings.messageColorFriend or colors.iMessageGreen)

    colors.final.messageOwnText:set(getLuminance(colors.final.messageOwn) <= 0.225 and rgbm.colors.white or rgbm.colors.black)
    colors.final.messageFriendText:set(getLuminance(colors.final.messageFriend) <= 0.225 and rgbm.colors.white or rgbm.colors.black)
end

local appWindow, windowHeight, appBottom = ac.accessAppWindow('IMGUI_LUA_Smartphone_main')
---Forces the app to be at the bottom of the screen.
local function forceAppToBottom()
    if not appWindow or not appWindow:valid() then return end

    windowHeight = ac.getSim().windowHeight
    appBottom = windowHeight - appWindow:size().y

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

---Moves the app up.
local function moveAppUp()
    if settings.appMove then
        movement.timer = settings.appMoveTimer
        movement.up = true
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

    if player.cspVersion >= 3459 then
        local shouldBeDark = ac.getSunAngle() > 84
        if player.phoneMode ~= shouldBeDark then
            player.phoneMode = shouldBeDark
            updateColors()
        end
    else
        local shouldBeDark = ac.getSim().timeHours > 9 and ac.getSim().timeHours < 19
        if player.phoneMode ~= shouldBeDark then
            player.phoneMode = shouldBeDark
            updateColors()
        end
    end
end

---Updates the community data from github.
local function updateCommunityData()
    local now = os.time()
    local checkInterval = settings.dataCheckFailed and 3600 or 43200
    if now - settings.dataCheckLast <= checkInterval then return end

    web.get('https://raw.githubusercontent.com/C1XTZ/ac-smartphone/refs/heads/main/smartphone/src/communities/data/list.lua', function(err, response)
        settings.dataCheckLast = now
        if err or response.status ~= 200 then
            settings.dataCheckFailed = true
            return error('Couldn\'t get community data from github.')
        end

        local data = stringify.parse(response.body)
        if not data or not communities then return error('Web request or Communities table is nil.') end
        if communities.version[1] == data.version[1] then
            return ac.log('Already using latest data.')
        end

        local file = io.open(ac.getFolder(ac.FolderID.ACAppsLua) .. '\\smartphone\\src\\communities\\data\\list.lua', 'w+')
        if file then
            file:write(stringify(data))
            file:close()
        end

        for name, community in pairs(data --[[@as table]]) do
            if name ~= 'default' and community.image then
                local filename = community.image:match('([^\\]+)$')
                local remoteImageUrl = 'https://raw.githubusercontent.com/C1XTZ/ac-smartphone/refs/heads/main/smartphone/src/communities/img/' .. filename
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
        return ac.log('Updated to latest data.')
    end)
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

    if (current.artist:lower() == 'unknown artist' or current.artist == '') and current.title ~= '' then
        current.artist, current.title = splitTitle(current.title)
    end

    if current.artist == '' and current.title == '' and not current.isPlaying then
        songInfo.final = ''
        if songInfo.dynamicIslandSize.x == 80 then setDynamicIslandSize(false) end
        songInfo.isPaused = true
    else
        songInfo.artist = current.artist
        songInfo.title = current.title
        songInfo.final = (current.artist ~= '' and current.artist:lower() ~= 'unknown artist') and (current.artist .. ' - ' .. current.title) or current.title
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
        local scrollX = (settings.songInfoScrollDirection == 0 and -1 or 1) * ((os.clock() * settings.songInfoScrollSpeed) % stepW)
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
                    end, 0.4)
                else
                    if (lowerMessage:find('^you') or lowerMessage:find('^it is currently night')) then
                        setTimeout(function()
                            playAudio(audio.notification.critical)
                        end, 0.4)
                    else
                        return true
                    end
                end
            end
        end

        if settings.chatHideRaceMsg and lowerMessage:find('in a race%.$') then
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
        if #chat.messages > settings.chatKeepSize and
            currentTime - chat.messages[index][4] > (settings.chatOlderThan * 10) then
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

---Custom keybard handling for input field, may god have mercy on my soul.
local function handleKeyboardInput()
    local keyboardInput = ui.captureKeyboard(false, true)
    local msgLen = utf8len(chat.input.text) > 0
    local typed = keyboardInput:queue()
    local inputMaxLen = math.floor(490 * (13 / settings.chatFontSize) ^ 2)

    if (ui.keyPressed(ui.Key.Backspace) or ui.keyPressed(ui.Key.Delete)) then
        playAudio(audio.keyboard.delete)
    elseif ui.keyboardButtonPressed(ui.getKeyIndex(ui.Key.Enter), false) or ui.keyboardButtonPressed(ui.getKeyIndex(ui.Key.Space), true) then
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
        if utf8len(chat.input.text .. ui.getClipboardText()) >= inputMaxLen then return end
        chat.input.text = chat.input.text .. ui.getClipboardText()
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

    if ping > -1 then
        local pingSize = vec2(20, 20):scale(app.scale)
        local pingPosition = vec2(scale(238), pingSize.y + movement.smooth)

        if app.hovered then
            if ui.rectHovered(pingPosition, pingPosition + pingSize, true) then
                ui.tooltip(app.tooltipPadding:scale(app.scale), function() ui.text('Current Ping: ' .. ping .. ' ms\nClick to send to chat.') end)
                if not ui.isMouseDragging(ui.MouseButton.Left, 0) then ui.setMouseCursor(ui.MouseCursor.Hand) end
                if ui.mouseReleased(ui.MouseButton.Left) then sendChatMessage('I currently have a ping of ' .. ping .. ' ms.') end
            end
        end

        if ping < 100 then
            ui.drawImage(app.images.pingAtlasPath, pingPosition, pingPosition + pingSize, colors.final.elements, vec2(0 / 5, 0), vec2(1 / 5, 1))
        elseif ping >= 100 and ping < 200 then
            ui.drawImage(app.images.pingAtlasPath, pingPosition, pingPosition + pingSize, colors.final.elements, vec2(1 / 5, 0), vec2(2 / 5, 1))
        elseif ping >= 200 and ping < 300 then
            ui.drawImage(app.images.pingAtlasPath, pingPosition, pingPosition + pingSize, colors.final.elements, vec2(2 / 5, 0), vec2(3 / 5, 1))
        elseif ping >= 300 then
            ui.drawImage(app.images.pingAtlasPath, pingPosition, pingPosition + pingSize, colors.final.elements, vec2(3 / 5, 0), vec2(4 / 5, 1))
            if math.floor(os.clock() * 2) % 2 == 0 then
                ui.drawImage(app.images.pingAtlasPath, pingPosition, pingPosition + pingSize, colors.final.elements, vec2(4 / 5, 0), vec2(5 / 5, 1))
            end
        end
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
        lastItemHoveredTooltip('Current Time: ' .. timeText .. '\nClick to send to chat.', true)
        if ui.itemClicked(ui.MouseButton.Left) then
            timeText = settings.badTime and timeText .. ' ' .. player.timePeriod or timeText
            sendChatMessage('It\'s currently ' .. timeText .. ' my local time.')
        end
    end
end

---Draws the dynamic island.
local function drawDynamicIsland()
    ui.drawRectFilled(vec2((ui.windowWidth() / 2 - scale(songInfo.dynamicIslandSize.x)), scale(songInfo.dynamicIslandSize.y) + movement.smooth), vec2((ui.windowWidth() / 2 + scale(songInfo.dynamicIslandSize.x)), scale(songInfo.dynamicIslandSize.y * 2) + movement.smooth), rgbm.colors.black, scale(10))
    if not settings.hideCamera or not settings.songInfo or songInfo.isPaused then
        local camSize = scale(songInfo.dynamicIslandSize.y - 2)
        local camPos = math.ceil(ui.windowWidth() / 2 + scale(30))
        ui.drawImage(app.images.phoneCamera, vec2(camPos - camSize / 2, scale(songInfo.dynamicIslandSize.y * 1.5) - (camSize / 2) + movement.smooth), vec2(camPos + camSize / 2, scale(songInfo.dynamicIslandSize.y * 1.5) + (camSize / 2) + movement.smooth))
    end
end

---Draws the header of the chat window.
local function drawHeader()
    local headerPadding = vec2(11, 9):scale(app.scale)
    local headerSize = vec2(ui.windowWidth() - scale(11), scale(100) + movement.smooth)
    local headerText = 'Server Chat'
    local headerTextFontsize = scale(12)
    ui.pushDWriteFont(app.font.regular)
    local headerTextSize = ui.measureDWriteText(headerText, headerTextFontsize)

    ui.drawRectFilled(vec2(headerPadding.x, headerPadding.y + movement.smooth), headerSize, colors.final.header, scale(30), ui.CornerFlags.Top)
    ui.drawSimpleLine(vec2(headerPadding.x, headerSize.y), vec2(headerSize.x, headerSize.y), colors.final.headerLine)
    ui.setCursor(vec2(math.floor((ui.windowWidth() / 2) - (headerTextSize.x / 2)), scale(84) + movement.smooth))
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
            ui.tooltip(app.tooltipPadding:scale(app.scale), function() ui.text(communities[player.serverCommunity].text .. '\nClick to open in Browser.') end)
            if not ui.isMouseDragging(ui.MouseButton.Left, 0) then ui.setMouseCursor(ui.MouseCursor.Hand) end
            if ui.mouseReleased(ui.MouseButton.Left) then os.openURL(communities[player.serverCommunity].url, false) end
        end
    end
end

---Draws the song information.
local function drawSongInfo()
    if settings.songInfo then
        --I'm using --[[@as ui.MediaPlayer]] here because ac.MusicData is not in the valid imageSources for some reason?
        if ui.isImageReady(ac.currentlyPlaying() --[[@as ui.MediaPlayer]]) and songInfo.isPaused == false then
            ui.setCursor(vec2(20, 100):scale(app.scale))
            ui.drawImageRounded(ac.currentlyPlaying() --[[@as ui.MediaPlayer]], vec2((ui.windowWidth() / 2) - scale(74), scale(23) + movement.smooth), vec2((ui.windowWidth() / 2) - scale(60), scale(37) + movement.smooth), scale(3), ui.CornerFlags.All)
        end
        local songFontSize = scale(12)
        local songPosition = vec2(scale(86), scale(22) + movement.smooth)
        local songTextSize = vec2(137, 15):scale(app.scale)

        drawSongInfoText(songInfo.final, songPosition, songTextSize, songFontSize)

        if app.hovered and songInfo.final ~= '' then
            if ui.rectHovered(songPosition, songPosition + songTextSize, true) then
                if not ui.isMouseDragging(ui.MouseButton.Left, 0) then ui.setMouseCursor(ui.MouseCursor.Hand) end
                ui.tooltip(app.tooltipPadding, function() ui.text('Current Song: ' .. songInfo.artist .. ' - ' .. songInfo.title .. '\nClick to send to chat.') end)
                if ui.mouseClicked(ui.MouseButton.Left) then
                    sendChatMessage('I\'m currently listening to: ' .. songInfo.final)
                end
            end
        end
    end
end

---Draws the chat messages.
local function drawMessages()
    ui.pushClipRect(vec2(0, 0), vec2(ui.windowWidth(), (scale(500) - chat.input.offset) + movement.smooth))
    ui.setCursor(vec2(13, 100):scale(app.scale) + vec2(0, movement.smooth))
    ui.childWindow('Messages', vec2(266, 400 - chat.input.offset):scale(app.scale), false, flags.window, function()
        local messageFontSize = scale(settings.chatFontSize)
        local usernameFontSize = scale(settings.chatFontSize - 2)
        local timestampFontSize = scale(settings.chatFontSize - 4)
        local usernameOffset = vec2(scale(10), usernameFontSize + scale(13))
        local messagePadding = vec2(15, 10):scale(app.scale)
        local messageMaxWidth = scale(250)
        local messageRounding = scale(10)
        if #chat.messages > 0 then
            local msgDist = scale(370)
            for i = 1, #chat.messages do
                local messageUserIndex = chat.messages[i][1]
                local messageUserIndexLast = i >= 2 and chat.messages[i - 1][1] or nil
                local messageUsername = chat.messages[i][2]
                local messageUsernameColor = chat.usernameColors[messageUsername] or rgbm.colors.gray
                local messageTextContent = chat.messages[i][3]
                local messageTimestamp = settings.badTime and to12hTime(os.date('%H:%M', chat.messages[i][4]) --[[@as string]]) .. ' ' .. player.timePeriod or os.date('%H:%M', chat.messages[i][4]) --[[@as string]]
                local fontWeight = app.font.regular

                if settings.focusMode and (messageUserIndex > 0 and not checkIfFriend(messageUserIndex)) then goto continue end

                if (i == #chat.messages and settings.chatLatestBold) or (messageTextContent:lower():find('%f[%a_]' .. player.driverName:lower() .. '%f[%A_]') and messageUserIndex > 0) then
                    fontWeight = app.font.bold
                else
                    fontWeight = app.font.regular
                end

                if messageUserIndex == 0 then
                    ui.pushDWriteFont(app.font.bold)
                    local userNameTextSize = ui.measureDWriteText(messageUsername, usernameFontSize)

                    if not messageUserIndexLast or messageUserIndexLast ~= messageUserIndex then
                        if messageUserIndexLast and messageUserIndexLast ~= -1 then msgDist = math.ceil(msgDist - usernameOffset.y / 2) end
                        ui.setCursor(vec2(usernameOffset.x, msgDist))
                        ui.dwriteTextAligned(messageUsername, usernameFontSize, ui.Alignment.End, ui.Alignment.Start, vec2(messageMaxWidth, userNameTextSize.y), false, messageUsernameColor)
                        msgDist = math.ceil(msgDist + usernameOffset.y)
                    end

                    ui.popDWriteFont()
                    ui.pushDWriteFont(fontWeight)
                    local messageTextSize = ui.measureDWriteText(messageTextContent, messageFontSize, scale(190))
                    msgDist = math.ceil(msgDist + messageTextSize.y)
                    ui.setCursor(vec2(ui.windowWidth() - scale(5), msgDist))
                    ui.drawRectFilled(ui.getCursor() - vec2(math.ceil(messageTextSize.x + messagePadding.x), math.ceil(messageTextSize.y + messagePadding.y)), ui.getCursor(), colors.final.messageOwn, messageRounding)
                    ui.setCursor(ui.getCursor() - vec2(math.ceil(messageTextSize.x + messagePadding.x / 2), math.ceil(messageTextSize.y + messagePadding.y / 2)))
                    ui.dwriteTextAligned(messageTextContent, messageFontSize, ui.Alignment.Start, ui.Alignment.Start, vec2(messageTextSize.x, messageTextSize.y + messageRounding), true, colors.final.messageOwnText)
                    ui.popDWriteFont()

                    if settings.chatShowTimestamps then
                        ui.pushDWriteFont(app.font.bold)
                        local timestampSize = ui.measureDWriteText(messageTimestamp, timestampFontSize)
                        ui.setCursor(vec2(math.ceil(ui.windowWidth() - timestampSize.x - scale(6)), msgDist))
                        ui.dwriteTextAligned(messageTimestamp, timestampFontSize, ui.Alignment.Start, ui.Alignment.Start, timestampSize, true, rgbm.colors.gray)
                        ui.popDWriteFont()
                        msgDist = math.ceil(msgDist + timestampSize.y)
                    end

                    msgDist = math.ceil(msgDist + messagePadding.y + messagePadding.y / 2)
                elseif messageUserIndex > 0 then
                    local bubbleColor, messageTextColor = colors.final.message, pickMode(rgbm.colors.black, rgbm.colors.white)
                    local isFriend = checkIfFriend(messageUserIndex)

                    if isFriend then
                        bubbleColor = colors.final.messageFriend
                        messageTextColor = colors.final.messageFriendText
                    end

                    ui.pushDWriteFont(app.font.bold)
                    local userNameTextSize = ui.measureDWriteText(messageUsername, usernameFontSize)

                    if not messageUserIndexLast or messageUserIndexLast ~= messageUserIndex then
                        if messageUserIndexLast and messageUserIndexLast ~= -1 then msgDist = math.ceil(msgDist - usernameOffset.y / 2) end
                        ui.setCursor(vec2(usernameOffset.x / 2, msgDist))
                        ui.dwriteTextAligned(messageUsername, usernameFontSize, ui.Alignment.Start, ui.Alignment.Start, vec2(math.min(userNameTextSize.x, messageMaxWidth), userNameTextSize.y), false, messageUsernameColor)
                        msgDist = math.ceil(msgDist + usernameOffset.y)
                    end

                    if app.hovered then
                        if ui.itemHovered() and not ui.isMouseDragging(ui.MouseButton.Right, 0) then
                            ui.setMouseCursor(ui.MouseCursor.Hand)
                        end
                        if ui.itemClicked(ui.MouseButton.Right) then
                            if chat.input.text == chat.input.placeholder then chat.input.text = '' end
                            chat.input.active = true
                            chat.input.text = chat.input.text .. '@' .. messageUsername
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

                    if i < 2 then
                        msgDist = math.ceil(msgDist - messageTextSize.y / 2)
                        ui.setCursor(vec2(math.ceil(ui.windowWidth() / 2 - messageTextSize.x / 2), math.ceil(msgDist)))
                        ui.dwriteTextAligned(messageTextContent, messageFontSize, ui.Alignment.Center, ui.Alignment.Start, vec2(messageTextSize.x, messageTextSize.y + messageRounding), true, rgbm.colors.gray)
                        ui.popDWriteFont()
                        msgDist = math.ceil(msgDist + messageTextSize.y + messagePadding.y / 2)
                    else
                        if chat.messages[i - 1][1] == messageUserIndex then
                            ui.setCursor(vec2(math.ceil(ui.windowWidth() / 2 - messageTextSize.x / 2), math.ceil(msgDist)))
                            ui.dwriteTextAligned(messageTextContent, messageFontSize, ui.Alignment.Center, ui.Alignment.Start, vec2(messageTextSize.x, messageTextSize.y + messageRounding), true, rgbm.colors.gray)
                            ui.popDWriteFont()
                            msgDist = math.ceil(msgDist + messageTextSize.y + messagePadding.y / 2)
                        else
                            msgDist = math.ceil(msgDist - messagePadding.y)
                            ui.setCursor(vec2(math.ceil(ui.windowWidth() / 2 - messageTextSize.x / 2), math.ceil(msgDist)))
                            ui.dwriteTextAligned(messageTextContent, messageFontSize, ui.Alignment.Center, ui.Alignment.Start, vec2(messageTextSize.x, messageTextSize.y + messageRounding), true, rgbm.colors.gray)
                            ui.popDWriteFont()
                            msgDist = math.ceil(msgDist + messageTextSize.y + messagePadding.y / 2)
                        end
                    end
                end

                if (not app.hovered or chat.scrollBool) or (chat.input.active and chat.input.hovered) and ui.getScrollY() ~= ui.getScrollMaxY() then ui.setScrollHereY(-1) end
                ::continue::
            end
        end

        if app.hovered and ui.mouseWheel() ~= 0 then
            local mouseWheel = (ui.mouseWheel() * -1) * (scale(settings.chatScrollDistance))
            ui.setScrollY(mouseWheel, true, true)
        end
    end)
    ui.popClipRect()
end

---Draws the emoji picker button and window.
local function drawEmojiPicker()
    local buttonPos = vec2(29, 17):scale(app.scale)
    local buttonSize = vec2(24, 24):scale(app.scale)
    local buttonBgRad = scale(12)
    local emojiSizePicker = scale(20)
    ui.pushDWriteFont(app.font.regular)
    local emojiSize = ui.measureDWriteText('😀', emojiSizePicker)
    if movement.distance > 0 and chat.emojiPicker then chat.emojiPicker = false end

    ui.setCursor(vec2(buttonPos.x, ui.windowHeight() - buttonPos.y + movement.smooth))

    ui.drawImage(app.images.emojiPicker, ui.getCursor() - buttonSize / 2, ui.getCursor() + buttonSize / 2, colors.final.emojiPicker)

    if app.hovered then
        chat.emojiPickerHovered = ui.rectHovered(ui.getCursor() - buttonSize / 2, ui.getCursor() + buttonSize / 2 + movement.smooth)

        if chat.emojiPickerHovered and ui.mouseReleased(ui.MouseButton.Left) and player.isOnline then
            chat.emojiPicker = not chat.emojiPicker
            playAudio(audio.keyboard.enter)
        end

        if chat.emojiPickerHovered then
            if not ui.isMouseDragging(ui.MouseButton.Left, 0) then ui.setMouseCursor(ui.MouseCursor.Hand) end
            ui.drawEllipseFilled(vec2(buttonPos.x, ui.windowHeight() - buttonPos.y + movement.smooth), buttonBgRad, colors.final.emojiPickerBG, 100)
        end
    end

    if chat.emojiPicker then
        local windowSize = vec2(185, 233):scale(app.scale)
        local windowPos = vec2(18, 270):scale(app.scale)
        local rounding = scale(10)
        local emojiStartPos = vec2(5, 3):scale(app.scale)
        local emojiOffset = vec2(0, 2):scale(app.scale)

        ui.setCursor(vec2(windowPos.x, ui.windowHeight() - windowPos.y - chat.input.offset))
        ui.childWindow('EmojiPicker', windowSize, false, flags.window, function()
            ui.setCursor(vec2(0, ui.windowHeight() - windowSize.y))
            ui.drawRectFilled(ui.getCursor(), windowSize, colors.final.message, rounding)

            ui.newLine(0)
            ui.setCursor(emojiStartPos)
            ui.beginGroup(windowSize.x)
            for i = 1, #chat.emojis do
                if ui.rectHovered(ui.getCursor(), ui.getCursor() + emojiSize) then
                    chat.emojiPickerHovered = true
                    if not ui.isMouseDragging(ui.MouseButton.Left, 0) then ui.setMouseCursor(ui.MouseCursor.Hand) end
                    ui.drawRectFilled(ui.getCursor() + emojiOffset, ui.getCursor() + emojiSize + emojiOffset, colors.iMessageSelected, scale(5))
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

                if i % 6 == 0 and i ~= #chat.emojis then
                    ui.newLine(emojiOffset.y)
                end
            end
            ui.endGroup()
        end)
    end
    ui.popDWriteFont()
end

---Draws the custom input box for the chat.
local function drawInputCustom()
    local inputSize = vec2(235, 32):scale(app.scale) + vec2(0, chat.input.offset)
    local inputBoxSize = inputSize - vec2(5, 5):scale(app.scale)
    local inputFontSize = scale(settings.chatFontSize)
    local inputWrap = scale(190)
    ui.setCursor(vec2(scale(42), (ui.windowHeight() - scale(32) - chat.input.offset) + movement.smooth))
    ui.childWindow('ChatInput', inputSize, false, flags.input, function()
        ui.beginOutline()
        ui.drawRectFilled(vec2(2, 2):scale(app.scale), inputBoxSize, colors.final.display, scale(10))
        ui.endOutline(pickMode(colors.transparent.black10, colors.transparent.white10), math.max(1, math.round(1 * app.scale, 1)))
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
                colors.final.input:set(pickMode(rgbm.colors.black, rgbm.colors.white))
                if chat.mentioned ~= '' and chat.input.text ~= chat.mentioned then chat.mentioned = '' end
            else
                chat.input.text = chat.input.placeholder
                colors.final.input:set(pickMode(colors.transparent.black50, colors.transparent.white50))
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

        if player.isOnline and (chat.input.text ~= chat.input.placeholder and chat.input.text ~= '') then
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
                        playAudio(audio.keyboard.enter)
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
        [0] = 'C1XTZ: You shouldnt be reading this',
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
local doUpdate = (os.time() - settings.updateLastCheck) / 86400 > settings.updateInterval
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

---@param manual boolean? @Whether the update check is manual
---Checks for updates and handles the update process.
local function updateCheckVersion(manual)
    settings.updateLastCheck = os.time()

    web.get(releaseURL, function(err, response)
        if err then
            settings.updateStatus = 4
            error(err)
            return
        end

        local latestRelease = JSON.parse(response.body)
        local tagName, releaseAssets, getDownloadUrl = latestRelease.tag_name, latestRelease.assets, function(asset) return asset.browser_download_url end

        if not (tagName and tagName:match('^v%d%d?%.%d%d?$')) then
            settings.updateStatus = 4
            error('URL unavailable or no Version recognized, aborted update')
            return
        end
        local version = tonumber(tagName:sub(2))

        if appVersion > version then
            settings.updateStatus = 3
            settings.updateAvailable = false
            return
        elseif appVersion == version then
            settings.updateStatus = 2
            settings.updateAvailable = false
            return
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
                error('No matching asset found, aborted update')
                return
            end

            if manual then
                updateApplyUpdate(downloadUrl)
            else
                settings.updateAvailable = true
                settings.updateURL = downloadUrl
                settings.updateStatus = 5
            end
        end
    end)
end

--#endregion

--#region APP EVENTS

if player.isOnline then
    ac.onChatMessage(function(message, senderCarIndex)
        local escapedMessage = message:gsub('([%(%)%.%%%+%-%*%?%[%]%^%$])', '%%%1')
        local isPlayer = senderCarIndex > -1
        local isFriend = isPlayer and checkIfFriend(senderCarIndex)
        local isMentioned = message:lower():find('%f[%a_]' .. player.driverName:lower() .. '%f[%A_]')
        local hideMessage = matchMessage(isPlayer, escapedMessage) and (isPlayer and settings.chatHideAnnoying or settings.chatHideKickBan)

        if not hideMessage and message:len() > 0 then
            deleteOldestMessages()

            if settings.chatUsernameColor and isPlayer then
                getDriverColor(senderCarIndex)
            end

            table.insert(chat.messages, { senderCarIndex, isPlayer and ac.getDriverName(senderCarIndex) or 'Server', message, os.time() })

            if not settings.focusMode or isFriend or not isPlayer then moveAppUp() end

            if isPlayer then
                if senderCarIndex == 0 then
                    playAudio(audio.message.send)
                else
                    if isFriend or settings.messagesNonFriends then
                        playAudio(audio.message.recieve)
                    end
                    if (isFriend and settings.notificationsFriendMessages) or (isMentioned and settings.notificationsMentions) then
                        setTimeout(function()
                            playAudio(audio.notification.regular)
                        end, 0.4)
                    end
                end
            else
                if settings.messagesServer then
                    playAudio(audio.message.recieve)
                end
            end
        end
        return false
    end)
end

if player.isOnline and settings.connectionEvents then
    ---@param connectedCarIndex number @Car index of the car that joined/left
    ---@param action string @joined/left string
    ---Adds system messages for join/leave events.
    local function connectionHandler(connectedCarIndex, action)
        local isFriend = checkIfFriend(connectedCarIndex)
        if not settings.connectionEventsFriendsOnly or isFriend then
            deleteOldestMessages()
            table.insert(chat.messages, { -1, 'Server', ac.getDriverName(connectedCarIndex) .. action .. ' the Server', os.time() })

            if settings.messagesServer and (settings.messagesNonFriends or isFriend) then playAudio(audio.message.recieve) end
            if settings.notificationsFriendConnections and isFriend then
                setTimeout(function()
                    playAudio(audio.notification.regular)
                end, 0.4)
            end

            moveAppUp()
        end
    end

    ac.onClientConnected(function(connectedCarIndex)
        connectionHandler(connectedCarIndex, ' joined')
    end)

    ac.onClientDisconnected(function(connectedCarIndex)
        connectionHandler(connectedCarIndex, ' left')
    end)
end

function onShowWindow()
    updateColors()
    updateCommunityData()

    updateSongInfo(true)

    if (settings.updateAutoCheck and doUpdate) or settings.updateAvailable then updateCheckVersion() end

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
            ui.text('Currrently running version ' .. string.format('%.2f', appVersion))
            if ui.checkbox('Automatically Check for Updates', settings.updateAutoCheck) then
                settings.updateAutoCheck = not settings.updateAutoCheck
                if settings.updateAutoCheck then updateCheckVersion() end
            end
            if settings.updateAutoCheck then
                ui.text('\t')
                ui.sameLine()
                settings.updateInterval = ui.slider('##UpdateInterval', settings.updateInterval, 1, 60, 'Check for Update every ' .. '%.0f days')
            end
            lastItemHoveredTooltip('If enabled, will automatically check for updates every X days.')

            local updateButtonText = settings.updateAvailable and 'Install Update' or 'Check for Update'
            if ui.button(updateButtonText) then
                if settings.updateAvailable then
                    updateCheckVersion(true)
                else
                    updateCheckVersion(false)
                end
            end
            if settings.updateStatus > 0 then
                ui.textColored(updateStatus.text[settings.updateStatus], updateStatus.color[settings.updateStatus])

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
            end
        end)
        ui.tabItem('App', function()
            ui.text('\t')
            ui.sameLine()
            settings.appScale = ui.slider('##AppScale', settings.appScale, 0.5, 2, 'App Scale: ' .. '%.01f%')
            if app.scale ~= math.round(settings.appScale, 1) then
                moveAppUp()
                app.scale = math.round(settings.appScale, 1)
                app.images.phoneAtlasSize = ui.imageSize(app.images.phoneAtlasPath):scale(app.scale)
            end

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
                ui.text('\t')
                ui.sameLine()
                if ui.checkbox('Always Scroll Text', settings.songInfoscrollAlways) then
                    settings.songInfoscrollAlways = not settings.songInfoscrollAlways
                    updateSongInfo(true)
                end
                lastItemHoveredTooltip('If enabled, will scroll text even if it could be displayed statically.')

                ui.text('\t')
                ui.sameLine()
                if ui.checkbox('Hide Selfie Camera', settings.hideCamera) then settings.hideCamera = not settings.hideCamera end
                lastItemHoveredTooltip('If enabled, will hide the selfie camera below the song information.')

                ui.text('\t')
                ui.sameLine()
                settings.songInfoSpacing = ui.slider('##Spacing', settings.songInfoSpacing, 0, 300, 'Spacing: %.0f', true)
                lastItemHoveredTooltip('The amount of spacing between the end and start of the song.')

                ui.text('\t')
                ui.sameLine()
                settings.songInfoScrollSpeed = ui.slider('##ScrollSpeed', settings.songInfoScrollSpeed, 1, 300, 'Scroll Speed: %.0f')
                lastItemHoveredTooltip('Speed that the text is scrolled at.')

                ui.text('\t')
                ui.sameLine()
                local scrollDirStr = settings.songInfoScrollDirection == 0 and 'Left' or 'Right'
                settings.songInfoScrollDirection = ui.slider('##ScrollDirection', settings.songInfoScrollDirection, 0, 1, 'Scroll Direction: ' .. scrollDirStr, true)
            end
        end)

        ui.tabItem('Chat', function()
            ui.text('\t')
            ui.sameLine()
            settings.chatFontSize = ui.slider('##ChatFontSize', settings.chatFontSize, 6, 36, 'Chat Fontsize: ' .. '%.0f')

            ui.text('\t')
            ui.sameLine()
            settings.chatScrollDistance = ui.slider('##chatScrollDistance', settings.chatScrollDistance, 1, 100, 'Chat Scroll Distance: ' .. '%.0f')
            lastItemHoveredTooltip('Distance to scroll the chat per mousewheel scroll')

            if ui.checkbox('Chat Inactivity Minimizes Phone', settings.appMove) then
                settings.appMove = not settings.appMove
                if settings.appMove then
                    movement.up = false
                    movement.timer = settings.appMoveTimer
                end
            end
            lastItemHoveredTooltip('If enabled, the app will move down to free screen space.')

            if settings.appMove then
                ui.text('\t')
                ui.sameLine()
                local chatInactive, chatInactiveChange = ui.slider('##appMoveTimer', settings.appMoveTimer, 1, 120, 'Inactivity: ' .. '%.0f seconds')
                settings.appMoveTimer = chatInactive
                if chatInactiveChange then movement.timer = settings.appMoveTimer end
                lastItemHoveredTooltip('Time before app moves down.')

                ui.text('\t')
                ui.sameLine()
                settings.appMoveSpeed = ui.slider('##appMoveSpeed', settings.appMoveSpeed, 1, 20, 'Speed: ' .. '%.0f')
                lastItemHoveredTooltip('How fast the app should move up/down.')
            end

            if ui.checkbox('Chat History Settings', settings.chatPurge) then settings.chatPurge = not settings.chatPurge end
            lastItemHoveredTooltip('If enabled, allows you to change the chat message history settings')
            if settings.chatPurge then
                ui.text('\t')
                ui.sameLine()
                settings.chatKeepSize = ui.slider('##ChatKeepSize', settings.chatKeepSize, 10, 500, 'Always keep %.0f Messages')

                ui.text('\t')
                ui.sameLine()
                settings.chatOlderThan = ui.slider('##ChatOlderThan', settings.chatOlderThan, 1, 60, 'Remove if older than %.0f min')
            end

            ui.drawSimpleLine(ui.getCursor(), vec2(ui.windowWidth(), ui.getCursorY()), ac.getUI().accentColor)
            ui.newLine(-10 * ac.getUI().uiScale)

            if ui.checkbox('Use Colored Usernames', settings.chatUsernameColor) then settings.chatUsernameColor = not settings.chatUsernameColor end
            lastItemHoveredTooltip('If enabled, uses colored usernames if possible.\nServers can overwrite CM tag colors.')

            if ui.checkbox('Show Timestamps', settings.chatShowTimestamps) then settings.chatShowTimestamps = not settings.chatShowTimestamps end
            lastItemHoveredTooltip('If enabled, shows message timestamps.')

            if ui.checkbox('Show Join/Leave Messages', settings.connectionEvents) then settings.connectionEvents = not settings.connectionEvents end
            lastItemHoveredTooltip('If enabled, shows server message when a player joins/leaves the server.')
            if settings.connectionEvents then
                ui.text('\t')
                ui.sameLine()
                if ui.checkbox('Friends Only', settings.connectionEventsFriendsOnly) then settings.connectionEventsFriendsOnly = not settings.connectionEventsFriendsOnly end
                lastItemHoveredTooltip('If enabled, only shows join/leave messages of friends.')
            end

            if ui.checkbox('Highlight Latest Message', settings.chatLatestBold) then settings.chatLatestBold = not settings.chatLatestBold end
            lastItemHoveredTooltip('If enabled, text of the latest message will always be bold.')

            if ui.checkbox('Hide Kick Ban Messages', settings.chatHideKickBan) then settings.chatHideKickBan = not settings.chatHideKickBan end
            lastItemHoveredTooltip('If enabled, hides kick and ban messages from other players.')

            if ui.checkbox('Hide Annoying Messages', settings.chatHideAnnoying) then settings.chatHideAnnoying = not settings.chatHideAnnoying end
            lastItemHoveredTooltip('If enabled, hides annoying messages from apps such as Pit Lane Penalty and Real Penalty.')

            if settings.chatHideAnnoying then
                ui.text('\t')
                ui.sameLine()
                if ui.checkbox('Include AssettoServer Race Challenge Messages', settings.chatHideRaceMsg) then settings.chatHideRaceMsg = not settings.chatHideRaceMsg end
                lastItemHoveredTooltip('If enabled, includes server messages from the AssettoServer RaceChallengePlugin in the "Hide Annoying Messages" setting.')
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
                    ui.text('\t')
                    ui.sameLine()
                    settings.volumeKeyboard = ui.slider('##keyboardVolume', settings.volumeKeyboard, 0.1, 10, 'Keystroke Volume: ' .. '%.1f')
                    ui.text('\t')
                    ui.sameLine()
                    if ui.button('Play Test Keystroke') then playTestAudio(audio.keyboard) end
                end

                if ui.checkbox('Enable Message Audio', settings.enableMessage) then settings.enableMessage = not settings.enableMessage end
                lastItemHoveredTooltip('Toggles message sounds.')
                if settings.enableMessage then
                    ui.text('\t')
                    ui.sameLine()
                    settings.volumeMessage = ui.slider('##messageVolume', settings.volumeMessage, 0.1, 10, 'Message Volume: ' .. '%.1f')
                    ui.text('\t')
                    ui.sameLine()
                    if ui.button('Play Test Message') then playTestAudio(audio.message) end
                    ui.text('\t')
                    ui.sameLine()
                    if ui.checkbox('Non-Friend Messages', settings.messagesNonFriends) then settings.messagesNonFriends = not settings.messagesNonFriends end
                    lastItemHoveredTooltip('Plays message recieved sound for messages from non-friends.')
                    ui.text('\t')
                    ui.sameLine()
                    if ui.checkbox('Server Messages', settings.messagesServer) then settings.messagesServer = not settings.messagesServer end
                    lastItemHoveredTooltip('Plays message recieved sound for messages from the server.')
                end

                if ui.checkbox('Enable Notification Audio', settings.enableNotification) then settings.enableNotification = not settings.enableNotification end
                lastItemHoveredTooltip('Toggles notification sounds.')
                if settings.enableNotification then
                    ui.text('\t')
                    ui.sameLine()
                    settings.volumeNotification = ui.slider('##notificationVolume', settings.volumeNotification, 0.1, 10, 'Notification Volume: ' .. '%.1f')
                    ui.text('\t')
                    ui.sameLine()
                    if ui.button('Play Test Notification') then playTestAudio(audio.notification) end
                    ui.text('\t')
                    ui.sameLine()
                    if ui.checkbox('@' .. player.driverName .. ' mentions', settings.notificationsMentions) then settings.notificationsMentions = not settings.notificationsMentions end
                    lastItemHoveredTooltip('Plays notification when you are mentioned in chat.')
                    ui.text('\t')
                    ui.sameLine()
                    if ui.checkbox('Friend Messages', settings.notificationsFriendMessages) then settings.notificationsFriendMessages = not settings.notificationsFriendMessages end
                    lastItemHoveredTooltip('Plays notification when friend sends a chat message.')
                    if settings.connectionEvents then
                        ui.text('\t')
                        ui.sameLine()
                        if ui.checkbox('Friend Join/Leave', settings.notificationsFriendConnections) then settings.notificationsFriendConnections = not settings.notificationsFriendConnections end
                        lastItemHoveredTooltip('Plays notification when friend joins/leaves the server.')
                    end
                end
            end
        end)

        ui.tabItem('Coloring', function()
            if ui.checkbox('Enable Custom Coloring', settings.customColor) then
                settings.customColor = not settings.customColor
                updateColors()
            end
            lastItemHoveredTooltip('If enabeld, allows you to recolor certain elements.')

            if settings.customColor then
                ui.columns(2, false)
                ui.text('Message Color Own')
                ui.setNextItemWidth(132 * ac.getUI().uiScale)
                local messageColorSelfChange = ui.colorPicker('Display Color Picker', settings.messageColorSelf, flags.colorpicker)
                if ui.button('Reset to default ') then
                    settings.messageColorSelf = colors.iMessageBlue:clone()
                    updateColors()
                end

                ui.nextColumn()

                ui.text('Message Color Friends')
                ui.setNextItemWidth(132 * ac.getUI().uiScale)
                local messageColorFriendChange = ui.colorPicker('Text Color Picker', settings.messageColorFriend, flags.colorpicker)
                if ui.button('Reset to default') then
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

    app.hovered = ui.windowHovered(ui.HoveredFlags.ChildWindows)
    player.car = ac.getCar(0)

    if app.images.phoneAtlasSize == vec2(0, 0) then app.images.phoneAtlasSize = ui.imageSize(app.images.phoneAtlasPath):scale(app.scale) end
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
