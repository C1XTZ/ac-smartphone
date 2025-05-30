--made by C1XTZ
--if you're reading any of this let me preface this by saying: If you're going 'what the fuck is this idiot doing??' it's likely that I said the same thing while writing it.
ui.setAsynchronousImagesLoading(true)
local WINDOWFLAGS = bit.bor(ui.WindowFlags.NoDecoration, ui.WindowFlags.NoBackground, ui.WindowFlags.NoNav, ui.WindowFlags.NoInputs, ui.WindowFlags.NoScrollbar)
local WINDOWFLAGSINPUT = bit.bor(ui.WindowFlags.NoDecoration, ui.WindowFlags.NoBackground, ui.WindowFlags.NoNav, ui.WindowFlags.NoScrollbar)

--#region APP PERSISTENT SETTINGS

local settings = ac.storage {
    appScale = 1,

    darkMode = false,

    forceBottom = true,

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
    spaces = 5,
    scrollSpeed = 2,
    scrollDirection = 0,
    scrollAlways = false,
    hideCamera = false,

    chatKeepSize = 100,
    chatOlderThan = 15,
    chatScrollDistance = 20,
    chatShowTimestamps = false,
    chatPurge = false,
    chatFontSize = 13,
    chatHideKickBan = false,
    chatHideAnnoying = true,
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
    displayColorLight = rgb.colors.white,
    displayColorDark = rgb.colors.black,
    headerColorLight = rgbm(0, 0, 0, 0.033),
    headerColorDark = rgbm(1, 1, 1, 0.075),
    headerLineColorLight = rgbm(0, 0, 0, 0.15),
    headerLineColorDark = rgbm(1, 1, 1, 0.075),
    iMessageBlue = rgb(0, 0.49, 1),
    iMessageLightGray = rgb(0.85, 0.85, 0.85),
    iMessageDarkGray = rgb(0.15, 0.15, 0.15),
    iMessageGreen = rgb(0.2, 0.75, 0.3),
    iMessageSelected = rgbm(0, 0.49, 1, 0.33),
    emojiPickerButtonLight = rgbm(0, 0, 0, 0.33),
    emojiPickerButtonDark = rgbm(1, 1, 1, 0.33),
    emojiPickerButtonBGLight = rgbm(0, 0, 0, 0.1),
    emojiPickerButtonBGDark = rgbm(1, 1, 1, 0.15),
    final = {
        display = rgb(),
        header = rgbm(),
        headerLine = rgbm(),
        elements = rgb(),
        message = rgb(),
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
}

local communityData = io.load('.\\apps\\lua\\smartphone\\src\\communities\\data\\list.lua')
local communities = stringify.parse(communityData)

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
    scroll = '',
    final = '',
    length = 0,
    isPaused = false,
    static = false,
    align = ui.Alignment.Center,
    spaces = '',
    scrollInterval = nil,
    updateInterval = nil,
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

--#endregion

--#region UTF8 HANDLING

---@param s string @Input string
---@return number @Character count (counts multibyte characters as 1)
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
---@param j number @End character index
---@return string @Substring of s from i to j
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
local function scale(value)
    return math.floor(app.scale * value)
end

---@param title string @combined 'artist - title' string
---@return string @artist name string
---@return string @song title string
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

---@param timeString string @Input os.date string in 24-hour format (e.g., '14:30')
---@return string @Time string in 12-hour format (e.g., '02:30')
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
    if not ac.getCar(carIndex) then return false end
    return ac.DriverTags(ac.getDriverName(carIndex)).friend
end

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

local function updateCommunityData()
    if (not settings.dataCheckFailed and os.time() - settings.dataCheckLast > 43200) or (settings.dataCheckFailed and os.time() - settings.dataCheckLast > 3600) then
        web.get('https://raw.githubusercontent.com/C1XTZ/ac-smartphone/refs/heads/main/smartphone/src/communities/data/list.lua', function(err, response)
            if err or response.status ~= 200 then
                settings.dataCheckLast = os.time()
                settings.dataCheckFailed = true
                return error('Couldn\'t get community data from github.')
            end

            local data = stringify.parse(response.body)
            if communities.version[1] == data.version[1] then
                settings.dataCheckLast = os.time()
                return ac.log('Already using latest data.')
            else
                local file = io.open(ac.getFolder(ac.FolderID.ACAppsLua) .. '\\smartphone\\src\\communities\\data\\list.lua', 'w+')
                if file then
                    file:write(stringify(data))
                    file:close()
                end

                for name, community in pairs(data) do
                    if name ~= 'default' and community.image then
                        local filename = community.image:match('([^\\]+)$')
                        local remoteImageUrl = 'https://raw.githubusercontent.com/C1XTZ/ac-smartphone/refs/heads/main/smartphone/src/communities/img/' .. filename
                        web.get(remoteImageUrl, function(err, response)
                            if err or response.status ~= 200 then
                                settings.dataCheckLast = os.time()
                                settings.dataCheckFailed = true

                                return error('Couldn\'t get community data from github.')
                            end
                            io.save(community.image, response.body)
                        end)
                    end
                end
                settings.dataCheckLast = os.time()
                settings.dataCheckFailed = false
                return ac.log('Updated to latest data.')
            end
        end)
    end
end

--#endregion

--#region GENERAL LOGIC FUNCTIONS

local function updateColors()
    colors.final.display:set(settings.darkMode and colors.displayColorDark or colors.displayColorLight)
    colors.final.header:set(settings.darkMode and colors.headerColorDark or colors.headerColorLight)
    colors.final.elements:set(settings.darkMode and colors.displayColorLight or colors.displayColorDark)
    colors.final.headerLine:set(settings.darkMode and colors.headerLineColorDark or colors.headerLineColorLight)
    colors.final.input:set(settings.darkMode and colors.transparent.white50 or colors.transparent.black50)
    colors.final.message:set(settings.darkMode and colors.iMessageDarkGray or colors.iMessageLightGray)
    colors.final.emojiPicker:set(settings.darkMode and colors.emojiPickerButtonDark or colors.emojiPickerButtonLight)
    colors.final.emojiPickerBG:set(settings.darkMode and colors.emojiPickerButtonBGDark or colors.emojiPickerButtonBGLight)
end

local appWindow, windowHeight, appBottom = ac.accessAppWindow('IMGUI_LUA_Smartphone_main')
local function forceAppToBottom()
    if not appWindow:valid() then return end

    windowHeight = ac.getSim().windowHeight
    appBottom = windowHeight - appWindow:size().y

    if appWindow:position().y ~= appBottom and not ui.isMouseDragging(ui.MouseButton.Left, 0) then
        appWindow:move(vec2(appWindow:position().x, appBottom))
    end
end

---@param dt number @Delta time in seconds since last update.
---Updates movement state (distance, smoothness, direction, timer).
local function updateAppMovement(dt)
    if settings.appMove then
        local scaledMaxDistance = scale(movement.maxDistance)

        if movement.timer > 0 and movement.distance == 0 then
            movement.timer = movement.timer - dt
            movement.down = true
        end

        if movement.timer <= 0 and movement.down then
            movement.down = true
            movement.distance = math.floor(movement.distance + dt * 100 * settings.appMoveSpeed)
            movement.smooth = math.floor(math.smootherstep(math.lerpInvSat(movement.distance, 0, scaledMaxDistance)) * scaledMaxDistance)
        elseif movement.timer > 0 and movement.up then
            movement.distance = math.floor(movement.distance - dt * 100 * settings.appMoveSpeed)
            movement.smooth = math.floor(math.smootherstep(math.lerpInvSat(movement.distance, 0, scaledMaxDistance)) * scaledMaxDistance)
        end

        if movement.distance > scaledMaxDistance then
            movement.distance = scaledMaxDistance
            movement.down = false
        elseif movement.distance < 0 then
            movement.distance = 0
            movement.up = false
            movement.timer = settings.appMoveTimer
        end
    elseif not settings.appMove and movement.distance ~= 0 then
        movement.distance = 0
        movement.smooth = 0
    end
end

local function moveAppUp()
    if settings.appMove then
        movement.timer = settings.appMoveTimer
        movement.up = true
    end
end

---@param event table @audio event table (audio.category.event)
local function playAudio(event)
    if not settings.enableAudio then return end

    for category, events in pairs(audio) do
        for _, eventData in pairs(events) do
            if event == eventData then
                local enableSetting = 'enable' .. category:sub(1, 1):upper() .. category:sub(2)
                if settings[enableSetting] then
                    local volumeSetting = 'volume' .. category:sub(1, 1):upper() .. category:sub(2)
                    local audioToPlay = ac.AudioEvent.fromFile({ filename = event.file, use3D = false, loop = false }, false)
                    audioToPlay.cameraInteriorMultiplier = 1
                    audioToPlay.cameraExteriorMultiplier = 1
                    audioToPlay.volume = settings[volumeSetting]
                    audioToPlay:start()
                    setTimeout(function() audioToPlay:dispose() end, audioToPlay:getDuration(), 'audioToPlay')
                end
                return
            end
        end
    end
end

local audioIndexes = {}
---@param tbl table @audio table (audio.category)
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

--#endregion

--#region SONG INFO FUNCTIONS

---@param enable boolean @sets the width of the island
---@return vec2 @updated size of the island
local function setDynamicIslandSize(enable)
    local width = enable and 80 or 40
    return songInfo.dynamicIslandSize:set(width, 20)
end

---@param forced boolean @Whether to force updating the song information even if the artist and title have not changed.
---Updates the global songInfo table with the currently playing track’s artist and title, handles cases of unknown artists or paused playback, and formats the scrolling text display.
local function updateSongInfo(forced)
    local current = ac.currentlyPlaying()
    local artist = current.artist
    local title = current.title
    local maxLength = 17

    if (current.artist:lower() == 'unknown artist' or current.artist == '') and current.title ~= '' then
        artist, title = splitTitle(current.title)
    end

    if artist == '' and title == '' and not current.isPlaying then
        songInfo.final = ''
        if songInfo.dynamicIslandSize.x == 80 then setDynamicIslandSize(false) end
        songInfo.isPaused = true
    else
        if artist ~= songInfo.artist or title ~= songInfo.title or forced then
            songInfo.artist = artist
            songInfo.title = title
            songInfo.scroll = (songInfo.artist ~= '' and songInfo.artist:lower() ~= 'unknown artist') and (songInfo.artist .. ' - ' .. songInfo.title) or (songInfo.title)

            if utf8len(songInfo.scroll) < maxLength and not settings.scrollAlways then
                songInfo.static = true
                songInfo.align = ui.Alignment.Center
            else
                if utf8len(songInfo.scroll) < maxLength then
                    string.rep(' ', maxLength - utf8len(songInfo.scroll))
                end
                songInfo.static = false
                songInfo.align = ui.Alignment.Start
                songInfo.scroll = songInfo.scroll .. songInfo.spaces
            end

            songInfo.length = utf8len(songInfo.scroll)
            songInfo.final = songInfo.scroll
        end
        if songInfo.dynamicIslandSize.x == 40 then setDynamicIslandSize(true) end
        songInfo.isPaused = false
    end
end

local function scrollText()
    if songInfo.isPaused or songInfo.static then return end

    local firstLetter, restString

    if settings.scrollDirection == 0 then
        firstLetter = utf8sub(songInfo.scroll, 1, 1)
        restString = utf8sub(songInfo.scroll, 2)
        songInfo.scroll = restString .. firstLetter
    else
        firstLetter = utf8sub(songInfo.scroll, songInfo.length, songInfo.length)
        restString = utf8sub(songInfo.scroll, 1, songInfo.length - 1)
        songInfo.scroll = firstLetter .. restString
    end

    songInfo.final = songInfo.scroll
end

local function updateSpacing()
    songInfo.spaces = string.rep(' ', settings.spaces)
    updateSongInfo(true)
end

local function updateScrollInterval()
    if songInfo.scrollInterval then
        clearInterval(songInfo.scrollInterval)
        songInfo.scrollInterval = nil
    end

    songInfo.scrollInterval = setInterval(scrollText, 1 / settings.scrollSpeed, 'scrollText')
end

local function startSongInfo()
    updateSpacing()
    updateSongInfo()

    if songInfo.updateInterval then
        clearInterval(songInfo.updateInterval)
        songInfo.updateInterval = nil
    end

    if songInfo.scrollInterval then
        clearInterval(songInfo.scrollInterval)
        songInfo.scrollInterval = nil
    end

    songInfo.updateInterval = setInterval(updateSongInfo, 2, 'updateNP')
    songInfo.scrollInterval = setInterval(scrollText, 1 / settings.scrollSpeed, 'scrollText')
end

local function stopSongInfo()
    if songInfo.updateInterval then
        clearInterval(songInfo.updateInterval)
        songInfo.updateInterval = nil
    end

    if songInfo.scrollInterval then
        clearInterval(songInfo.scrollInterval)
        songInfo.scrollInterval = nil
    end

    songInfo.final = ''
    songInfo.artist = ''
    songInfo.title = ''
    songInfo.isPaused = false

    setDynamicIslandSize(false)
end

--#endregion

--#region CHAT LOGIC FUNCTIONS

---@param message string? @Optional, message to be sent instead of input field text.
local function sendChatMessage(message)
    if not chat.sendCd then
        message = message and ac.sendChatMessage(message) or ac.sendChatMessage(chat.input.text)

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
    end

    return false
end

local function deleteOldestMessages()
    local currentTime = os.time()
    local index = 1
    while index <= #chat.messages do
        if #chat.messages > settings.chatKeepSize and
            currentTime - chat.messages[index][4] > (settings.chatOlderThan * 10) then
            table.remove(chat.messages, index)
        else
            index = index + 1
        end
    end
end

---Custom keybard handling for input field, may god have mercy on my soul.
local function handleKeyboardInput()
    local keyboardInput = ui.captureKeyboard(false, true, false)
    local msgLen = utf8len(chat.input.text) > 0
    local typed = keyboardInput:queue()
    local inputMaxLen = math.floor(490 * (13 / settings.chatFontSize) ^ 2)

    if (ui.keyPressed(ui.Key.Backspace, true) or ui.keyPressed(ui.Key.Delete)) then
        playAudio(audio.keyboard.delete)
    elseif ui.keyboardButtonPressed(ui.getKeyIndex(ui.Key.Enter), false) or ui.keyboardButtonPressed(ui.getKeyIndex(ui.Key.Space), true) then
        playAudio(audio.keyboard.enter)
    elseif typed:gsub('[%c]', '') ~= '' and typed ~= ' ' then
        playAudio(audio.keyboard.keystroke)
    end

    if (ui.keyPressed(ui.Key.Backspace, true) or ui.keyPressed(ui.Key.Delete)) and msgLen then
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
        typed = typed .. ui.getClipboardText()
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
    return
end

--#endregion

--#region DRAWING FUNCTIONS

local function drawDisplay()
    ui.drawRectFilled(vec2(scale(5), 0 + movement.smooth), ui.windowSize() - vec2(5, 0):scale(app.scale), colors.final.display, scale(50), ui.CornerFlags.Top)
end

local function drawiPhone()
    ui.setCursor(vec2(0, 0))
    ui.childWindow('OnTopImages', vec2(app.images.phoneAtlasSize.x / 2, app.images.phoneAtlasSize.y), false, WINDOWFLAGS, function()
        ui.drawImage(app.images.phoneAtlasPath, vec2(0, movement.smooth), vec2(app.images.phoneAtlasSize.x / 2, app.images.phoneAtlasSize.y + movement.smooth), rgb.colors.white, vec2(0 / 2, 0), vec2(1 / 2, 1))
        if not settings.darkMode then
            local padding = scale(2)
            ui.drawImage(app.images.phoneAtlasPath, vec2(padding, movement.smooth), vec2(math.ceil(app.images.phoneAtlasSize.x / 2 - padding), app.images.phoneAtlasSize.y + movement.smooth), colors.glowColor, vec2(1 / 2, 0), vec2(2 / 2, 1))
        end
    end)
end

local function drawPing()
    ping = player.car.ping

    if ping > -1 then
        local pingAtlasSize = ui.imageSize(app.images.pingAtlasPath):scale(app.scale)
        local pingSize = vec2(20, 20):scale(app.scale)
        local pingPosition = vec2(scale(238), pingSize.y + movement.smooth)

        if ui.rectHovered(pingPosition, pingPosition + pingSize, true) then
            ui.tooltip(app.tooltipPadding:scale(app.scale), function() ui.text('Current Ping: ' .. ping .. ' ms\nClick to send to chat') end)
            if not ui.isMouseDragging(ui.MouseButton.Left, 0) then ui.setMouseCursor(ui.MouseCursor.Hand) end
            if ui.mouseReleased(ui.MouseButton.Left) then sendChatMessage('I currently have a ping of ' .. ping .. ' ms.') end
        end

        if ping < 100 then
            ui.drawImage(app.images.pingAtlasPath, pingPosition, pingPosition + pingSize, colors.final.elements, vec2(0 / 4, 0), vec2(1 / 4, 1))
        elseif ping >= 100 and ping < 200 then
            ui.drawImage(app.images.pingAtlasPath, pingPosition, pingPosition + pingSize, colors.final.elements, vec2(1 / 4, 0), vec2(2 / 4, 1))
        elseif ping >= 200 and ping < 300 then
            ui.drawImage(app.images.pingAtlasPath, pingPosition, pingPosition + pingSize, colors.final.elements, vec2(2 / 4, 0), vec2(3 / 4, 1))
        elseif ping >= 300 then
            ui.drawImage(app.images.pingAtlasPath, pingPosition, pingPosition + pingSize, colors.final.elements, vec2(3 / 4, 0), vec2(4 / 4, 1))
        end
    end
end

local function drawTime()
    local time = os.date('%H:%M')
    local timeText = settings.badTime and to12hTime(time) or time
    local timeSize = scale(13)
    local timePosition = vec2(23, 22):scale(app.scale) + vec2(0, movement.smooth)
    ui.setCursor(timePosition)
    ui.pushDWriteFont(app.font.bold)
    local timeTextSize = ui.measureDWriteText(timeText, timeSize)
    ui.dwriteTextAligned(timeText, timeSize, ui.Alignment.Start, ui.Alignment.Center, timeTextSize, false, colors.final.elements)
    ui.popDWriteFont()

    if app.hovered then
        if ui.itemHovered() then
            ui.setMouseCursor(ui.MouseCursor.Hand)
            ui.tooltip(app.tooltipPadding:scale(app.scale), function() ui.text('Current Time: ' .. timeText .. '\nClick to send to chat') end)
        end
        if ui.itemClicked(ui.MouseButton.Left) then
            timeText = settings.badTime and timeText .. ' ' .. player.timePeriod or timeText
            sendChatMessage('It\'s currently ' .. timeText .. ' my local time.')
        end
    end
end

local function drawDynamicIsland()
    ui.drawRectFilled(vec2((ui.windowWidth() / 2 - scale(songInfo.dynamicIslandSize.x)), scale(songInfo.dynamicIslandSize.y) + movement.smooth), vec2((ui.windowWidth() / 2 + scale(songInfo.dynamicIslandSize.x)), scale(songInfo.dynamicIslandSize.y * 2) + movement.smooth), rgb.colors.black, scale(10))
    if not settings.hideCamera or not settings.songInfo or songInfo.isPaused then
        local camSize = scale(songInfo.dynamicIslandSize.y - 2)
        local camPos = math.ceil(ui.windowWidth() / 2 + scale(30))
        ui.drawImage(app.images.phoneCamera, vec2(camPos - camSize / 2, scale(songInfo.dynamicIslandSize.y * 1.5) - (camSize / 2) + movement.smooth), vec2(camPos + camSize / 2, scale(songInfo.dynamicIslandSize.y * 1.5) + (camSize / 2) + movement.smooth))
    end
end

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

    if ui.isImageReady(communities[player.serverCommunity].image) then
        ui.drawImageRounded(communities[player.serverCommunity].image, headerImagePosition, headerImagePosition + headerImageSize, headerImageRounding)
    else
        ui.drawImageRounded(communities['default'].image, headerImagePosition, headerImagePosition + headerImageSize, headerImageRounding)
    end

    if ui.rectHovered(headerImagePosition, headerImagePosition + headerImageSize) then
        ui.tooltip(app.tooltipPadding:scale(app.scale), function() ui.text(communities[player.serverCommunity].text .. '\nClick to open in Browser.') end)
        if not ui.isMouseDragging(ui.MouseButton.Left, 0) then ui.setMouseCursor(ui.MouseCursor.Hand) end
        if ui.mouseReleased(ui.MouseButton.Left) then os.openURL(communities[player.serverCommunity].url, false) end
    end
end

local function drawSongInfo()
    if settings.songInfo then
        if ui.isImageReady(ac.currentlyPlaying()) and songInfo.isPaused == false then
            ui.setCursor(vec2(20, 100):scale(app.scale))
            ui.drawImageRounded(ac.currentlyPlaying(), vec2((ui.windowWidth() / 2) - scale(74), scale(23) + movement.smooth), vec2((ui.windowWidth() / 2) - scale(60), scale(37) + movement.smooth), scale(3), ui.CornerFlags.All)
        end
        local songFontSize = scale(12)
        local songPosition = vec2(ui.windowWidth() / 2, scale(22))
        local songTextSize = vec2(133, 15):scale(app.scale)
        ui.pushDWriteFont(app.font.bold)
        ui.setCursor(vec2(math.round(ui.windowWidth() / 2 - songTextSize.x / 2.3), songPosition.y + movement.smooth))
        ui.dwriteTextAligned(songInfo.final, songFontSize, songInfo.align, ui.Alignment.End, songTextSize, false, rgb.colors.white)
        ui.popDWriteFont()

        if app.hovered and songInfo.final ~= '' then
            if ui.itemHovered() then
                ui.setMouseCursor(ui.MouseCursor.Hand)
                ui.tooltip(app.tooltipPadding:scale(app.scale), function() ui.text('Current Song: ' .. songInfo.artist .. ' - ' .. songInfo.title .. '\nClick to send to chat') end)
            end
            if ui.itemClicked(ui.MouseButton.Left) then
                sendChatMessage('I\'m currently listening to: ' .. songInfo.artist .. ' - ' .. songInfo.title)
            end
        end
    end
end

local function drawMessages()
    ui.pushClipRect(vec2(0, 0), vec2(ui.windowWidth(), (scale(500) - chat.input.offset) + movement.smooth))
    ui.setCursor(vec2(13, 100):scale(app.scale) + vec2(0, movement.smooth))
    ui.childWindow('Messages', vec2(266, 400 - chat.input.offset):scale(app.scale), false, WINDOWFLAGS, function()
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
                local messageUsernameColor = chat.messages[i][5]
                local messageTextcontent = chat.messages[i][3]
                local messageTimestamp = settings.badTime and to12hTime(os.date('%H:%M', chat.messages[i][4])) .. ' ' .. player.timePeriod or os.date('%H:%M', chat.messages[i][4])
                local fontWeight = app.font.regular

                if (i == #chat.messages and settings.chatLatestBold) or (messageTextcontent:lower():find('%f[%a_]' .. player.driverName:lower() .. '%f[%A_]') and messageUserIndex > 0) then
                    fontWeight = app.font.bold
                else
                    fontWeight = app.font.regular
                end

                if messageUserIndex == 0 then
                    ui.pushDWriteFont(app.font.bold)
                    local userNameTextSize = ui.measureDWriteText(messageUsername, usernameFontSize)

                    if not messageUserIndexLast then
                        ui.setCursor(vec2(usernameOffset.x, msgDist))
                        ui.dwriteTextAligned(messageUsername, usernameFontSize, ui.Alignment.End, ui.Alignment.Start, vec2(messageMaxWidth, userNameTextSize.y), false, messageUsernameColor)
                        msgDist = math.ceil(msgDist + usernameOffset.y)
                    else
                        if messageUserIndexLast ~= messageUserIndex then
                            if messageUserIndexLast ~= -1 then msgDist = math.ceil(msgDist - usernameOffset.y / 2) end
                            ui.setCursor(vec2(usernameOffset.x, msgDist))
                            ui.dwriteTextAligned(messageUsername, usernameFontSize, ui.Alignment.End, ui.Alignment.Start, vec2(messageMaxWidth, userNameTextSize.y), false, messageUsernameColor)
                            msgDist = math.ceil(msgDist + usernameOffset.y)
                        end
                    end
                    ui.popDWriteFont()
                    ui.pushDWriteFont(fontWeight)
                    local messageTextSize = ui.measureDWriteText(messageTextcontent, messageFontSize, scale(190))
                    msgDist = math.ceil(msgDist + messageTextSize.y)
                    ui.setCursor(vec2(ui.windowWidth() - scale(5), msgDist))
                    ui.drawRectFilled(ui.getCursor() - vec2(math.ceil(messageTextSize.x + messagePadding.x), math.ceil(messageTextSize.y + messagePadding.y)), ui.getCursor(), colors.iMessageBlue, messageRounding)
                    ui.setCursor(ui.getCursor() - vec2(math.ceil(messageTextSize.x + messagePadding.x / 2), math.ceil(messageTextSize.y + messagePadding.y / 2)))
                    ui.dwriteTextAligned(messageTextcontent, messageFontSize, ui.Alignment.Start, ui.Alignment.Start, vec2(messageTextSize.x, messageTextSize.y + messageRounding), true, rgb.colors.white)
                    ui.popDWriteFont()

                    if settings.chatShowTimestamps then
                        ui.pushDWriteFont(app.font.bold)
                        local timestampSize = ui.measureDWriteText(messageTimestamp, timestampFontSize)
                        ui.setCursor(vec2(math.ceil(ui.windowWidth() - timestampSize.x - scale(6)), msgDist))
                        ui.dwriteTextAligned(messageTimestamp, timestampFontSize, ui.Alignment.Start, ui.Alignment.Start, timestampSize, true, rgb.colors.gray)
                        ui.popDWriteFont()
                        msgDist = math.ceil(msgDist + timestampSize.y)
                    end

                    msgDist = math.ceil(msgDist + messagePadding.y + messagePadding.y / 2)
                elseif messageUserIndex > 0 then
                    local bubbleColor, messageTextColor = colors.final.message, settings.darkMode and rgb.colors.white or rgb.colors.black
                    local isFriend = checkIfFriend(messageUserIndex)

                    if isFriend then
                        bubbleColor = colors.iMessageGreen
                        messageTextColor = rgb.colors.white
                    end

                    ui.pushDWriteFont(app.font.bold)
                    local userNameTextSize = ui.measureDWriteText(messageUsername, usernameFontSize)

                    if not messageUserIndexLast then
                        ui.setCursor(vec2(usernameOffset.x / 2, msgDist))
                        ui.dwriteTextAligned(messageUsername, usernameFontSize, ui.Alignment.Start, ui.Alignment.Start, vec2(math.min(userNameTextSize.x, messageMaxWidth), userNameTextSize.y), false, messageUsernameColor)
                        msgDist = math.ceil(msgDist + usernameOffset.y)
                    else
                        if messageUserIndexLast ~= messageUserIndex then
                            if messageUserIndexLast ~= -1 then msgDist = math.ceil(msgDist - usernameOffset.y / 2) end
                            ui.setCursor(vec2(usernameOffset.x / 2, msgDist))
                            ui.dwriteTextAligned(messageUsername, usernameFontSize, ui.Alignment.Start, ui.Alignment.Start, vec2(math.min(userNameTextSize.x, messageMaxWidth), userNameTextSize.y), false, messageUsernameColor)
                            msgDist = math.ceil(msgDist + usernameOffset.y)
                        end
                    end

                    if ui.itemHovered() and not ui.isMouseDragging(ui.MouseButton.Right, 0) then
                        ui.setMouseCursor(ui.MouseCursor.Hand)
                    end
                    if ui.itemClicked(ui.MouseButton.Right) then
                        if chat.input.text == chat.input.placeholder then chat.input.text = '' end
                        chat.input.active = true
                        chat.input.text = chat.input.text .. '@' .. messageUsername
                    end

                    ui.popDWriteFont()
                    ui.pushDWriteFont(fontWeight)
                    local messageTextSize = ui.measureDWriteText(messageTextcontent, messageFontSize, scale(190))
                    msgDist = math.ceil(msgDist + messageTextSize.y)
                    ui.setCursor(vec2(math.ceil(messageTextSize.x + messagePadding.x + scale(5)), msgDist))
                    ui.drawRectFilled(ui.getCursor() - vec2(math.ceil(messageTextSize.x + messagePadding.x), math.ceil(messageTextSize.y + messagePadding.y)), ui.getCursor(), bubbleColor, messageRounding)
                    ui.setCursor(ui.getCursor() - vec2(math.ceil(messageTextSize.x + messagePadding.x / 2), math.ceil(messageTextSize.y + messagePadding.y / 2)))
                    ui.dwriteTextAligned(messageTextcontent, messageFontSize, ui.Alignment.Start, ui.Alignment.Start, vec2(messageTextSize.x, messageTextSize.y + messageRounding), true, messageTextColor)
                    ui.popDWriteFont()

                    if settings.chatShowTimestamps then
                        ui.pushDWriteFont(app.font.bold)
                        local timestampSize = ui.measureDWriteText(messageTimestamp, timestampFontSize)
                        ui.setCursor(vec2(scale(5), msgDist))
                        ui.dwriteTextAligned(messageTimestamp, timestampFontSize, ui.Alignment.Start, ui.Alignment.Start, timestampSize, true, rgb.colors.gray)
                        ui.popDWriteFont()
                        msgDist = math.ceil(msgDist + timestampSize.y)
                    end

                    msgDist = math.ceil(msgDist + messagePadding.y + messagePadding.y / 2)
                elseif messageUserIndex == -1 then
                    ui.pushDWriteFont(app.font.bold)
                    local messageTextSize = ui.measureDWriteText(messageTextcontent, messageFontSize, scale(220))

                    if i < 2 then
                        msgDist = math.ceil(msgDist - messageTextSize.y / 2)
                        ui.setCursor(vec2(math.ceil(ui.windowWidth() / 2 - messageTextSize.x / 2), math.ceil(msgDist)))
                        ui.dwriteTextAligned(messageTextcontent, messageFontSize, ui.Alignment.Center, ui.Alignment.Start, vec2(messageTextSize.x, messageTextSize.y + messageRounding), true, rgb.colors.gray)
                        ui.popDWriteFont()
                        msgDist = math.ceil(msgDist + messageTextSize.y + messagePadding.y / 2)
                    else
                        if chat.messages[i - 1][1] == messageUserIndex then
                            ui.setCursor(vec2(math.ceil(ui.windowWidth() / 2 - messageTextSize.x / 2), math.ceil(msgDist)))
                            ui.dwriteTextAligned(messageTextcontent, messageFontSize, ui.Alignment.Center, ui.Alignment.Start, vec2(messageTextSize.x, messageTextSize.y + messageRounding), true, rgb.colors.gray)
                            ui.popDWriteFont()
                            msgDist = math.ceil(msgDist + messageTextSize.y + messagePadding.y / 2)
                        else
                            msgDist = math.ceil(msgDist - messagePadding.y)
                            ui.setCursor(vec2(math.ceil(ui.windowWidth() / 2 - messageTextSize.x / 2), math.ceil(msgDist)))
                            ui.dwriteTextAligned(messageTextcontent, messageFontSize, ui.Alignment.Center, ui.Alignment.Start, vec2(messageTextSize.x, messageTextSize.y + messageRounding), true, rgb.colors.gray)
                            ui.popDWriteFont()
                            msgDist = math.ceil(msgDist + messageTextSize.y + messagePadding.y / 2)
                        end
                    end
                end

                if (not app.hovered or chat.scrollBool) or (chat.input.active and chat.input.hovered) and ui.getScrollY() ~= ui.getScrollMaxY() then ui.setScrollHereY(-1) end
            end
        end

        if app.hovered and ui.mouseWheel() ~= 0 then
            local mouseWheel = (ui.mouseWheel() * -1) * (scale(settings.chatScrollDistance))
            ui.setScrollY(mouseWheel, true, true)
        end
    end)
    ui.popClipRect()
end

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
    chat.emojiPickerHovered = ui.rectHovered(ui.getCursor() - buttonSize / 2, ui.getCursor() + buttonSize / 2 + movement.smooth)

    if chat.emojiPickerHovered and ui.mouseReleased(ui.MouseButton.Left) then
        chat.emojiPicker = not chat.emojiPicker
        playAudio(audio.keyboard.enter)
    end

    if chat.emojiPickerHovered then
        if not ui.isMouseDragging(ui.MouseButton.Left, 0) then ui.setMouseCursor(ui.MouseCursor.Hand) end
        ui.drawEllipseFilled(vec2(buttonPos.x, ui.windowHeight() - buttonPos.y + movement.smooth), buttonBgRad, colors.final.emojiPickerBG, 100)
    end

    if chat.emojiPicker then
        local windowSize = vec2(185, 233):scale(app.scale)
        local windowPos = vec2(18, 270):scale(app.scale)
        local rounding = scale(10)
        local emojiStartPos = vec2(5, 3):scale(app.scale)
        local emojiOffset = vec2(0, 2):scale(app.scale)

        ui.setCursor(vec2(windowPos.x, ui.windowHeight() - windowPos.y - chat.input.offset))
        ui.childWindow('EmojiPicker', windowSize, false, WINDOWFLAGS, function()
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

local function drawInputCustom()
    local inputSize = vec2(235, 32):scale(app.scale) + vec2(0, chat.input.offset)
    local inputBoxSize = inputSize - vec2(5, 5):scale(app.scale)
    local inputFontSize = scale(settings.chatFontSize)
    local inputWrap = scale(190)
    ui.setCursor(vec2(scale(42), (ui.windowHeight() - scale(32) - chat.input.offset) + movement.smooth))
    ui.childWindow('ChatInput', inputSize, false, WINDOWFLAGSINPUT, function()
        ui.beginOutline()
        ui.drawRectFilled(vec2(2, 2):scale(app.scale), inputBoxSize, colors.final.display, scale(10))
        ui.endOutline(settings.darkMode and colors.transparent.white10 or colors.transparent.black10, math.max(1, math.round(1 * app.scale, 1)))
        local displayText = ''
        ui.pushDWriteFont(app.font.regular)
        local lineHeight = ui.measureDWriteText('Line Height', inputFontSize, inputWrap).y

        if player.isOnline then
            chat.input.hovered = ui.windowHovered(ui.HoveredFlags.RectOnly)
            inputClicked = chat.input.hovered and ui.mouseClicked(ui.MouseButton.Left)

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
                colors.final.input:set(settings.darkMode and rgbm.colors.white or rgbm.colors.black)
                if chat.mentioned ~= '' and chat.input.text ~= chat.mentioned then chat.mentioned = '' end
            else
                chat.input.text = chat.input.placeholder
                colors.final.input:set(settings.darkMode and colors.transparent.white50 or colors.transparent.black50)
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
            local buttonColor = rgb():set(colors.iMessageBlue)

            ui.setCursor(vec2(inputBoxSize.x - circlePadding, inputBoxSize.y - circlePadding))
            chat.input.sendHovered = ui.rectHovered(ui.getCursor() - vec2(circleRad, circleRad), ui.getCursor() + vec2(circleRad, circleRad))

            if chat.input.sendHovered then
                ui.setMouseCursor(ui.MouseCursor.Hand)
                buttonColor:mul(rgb(0.6, 0.6, 0.8))

                if ui.mouseClicked(ui.MouseButton.Left) then
                    playAudio(audio.keyboard.enter)
                    sendChatMessage()
                    chat.emojiPicker = false
                    chat.input.sendHovered = false
                end
            end

            ui.drawCircleFilled(ui.getCursor(), circleRad, buttonColor, 25)
            ui.drawIcon(ui.Icons.ArrowUp, ui.getCursor() - arrowRad, ui.getCursor() + arrowRad, rgb.colors.white)
        end

        chat.input.offset = math.min(math.floor(inputTextSize.y - scale(17)), scale(390))
    end)
end

--#endregion

--#region APP UPDATER
local updateStatus = {
    text  = {
        [0] = 'C1XTZ: You shouldnt be reading this',
        [1] = 'Updated: App successfully updated',
        [2] = 'No Change: Latest version was already installed',
        [3] = 'No Change: A newer version was already installed',
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

function updateCheckVersion(manual)
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

function updateApplyUpdate(downloadUrl)
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

--#endregion

--#region APP EVENTS

if player.isOnline then
    ac.onChatMessage(function(message, senderCarIndex)
        local escapedMessage = message:gsub('([%(%)%.%%%+%-%*%?%[%]%^%$])', '%%%1')
        local isPlayer = senderCarIndex > -1
        local isFriend = isPlayer and checkIfFriend(senderCarIndex)
        local isMentioned = message:lower():find('%f[%a_]' .. player.driverName:lower() .. '%f[%A_]')
        local hideMessage = false
        local userTagColor

        if settings.chatUsernameColor and isPlayer then
            userTagColor = ac.DriverTags(ac.getDriverName(senderCarIndex)).color
            if (senderCarIndex == 0 and userTagColor == rgbm.colors.yellow) or (senderCarIndex ~= 0 and userTagColor == rgbm.colors.white) then userTagColor = rgb.colors.gray end
        else
            userTagColor = rgb.colors.gray
        end

        if isPlayer then
            hideMessage = matchMessage(isPlayer, escapedMessage) and settings.chatHideAnnoying
        else
            hideMessage = matchMessage(isPlayer, escapedMessage) and settings.chatHideKickBan
        end

        if not hideMessage and message:len() > 0 then
            deleteOldestMessages()
            table.insert(chat.messages, { senderCarIndex, isPlayer and ac.getDriverName(senderCarIndex) or 'Server', message, os.time(), userTagColor })

            moveAppUp()

            if isPlayer then
                if senderCarIndex == 0 then
                    return playAudio(audio.message.send)
                else
                    if isFriend or settings.messagesNonFriends then
                        playAudio(audio.message.recieve)
                    end
                    if (isFriend and settings.notificationsFriendMessages) or (isMentioned and settings.notificationsMentions) then
                        setTimeout(function()
                            playAudio(audio.notification.regular)
                        end, 0.4)
                        return
                    end
                end
            else
                if settings.messagesServer then
                    return playAudio(audio.message.recieve)
                end
            end
        end
    end)
end

if player.isOnline and settings.connectionEvents then
    ---@param connectedCarIndex number @Car index of the car that joined/left
    ---@param action string @joined/left string
    ---adds system messages for join/leave events.
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

    if (settings.updateAutoCheck and doUpdate) or settings.updateAvailable then updateCheckVersion() end

    if settings.songInfo then startSongInfo() end

    if app.scale ~= math.round(settings.appScale, 1) then
        app.scale = math.round(settings.appScale, 1)
        app.images.phoneAtlasSize = ui.imageSize(app.images.phoneAtlasPath):scale(app.scale)
    end

    player.serverCommunity = getServerCommunity()
end

--#endregion

--#region APP SETTINGS WINDOW

function script.windowMainSettings(dt)
    ui.tabBar('TabBar', function()
        ui.tabItem('Update', function()
            ui.text('Currrently running version ' .. string.format("%.2f", appVersion))
            if ui.checkbox('Automatically Check for Updates', settings.updateAutoCheck) then
                settings.updateAutoCheck = not settings.updateAutoCheck
                if settings.updateAutoCheck then updateCheckVersion() end
            end
            if settings.updateAutoCheck then
                ui.text('\t')
                ui.sameLine()
                settings.updateInterval = ui.slider('##UpdateInterval', settings.updateInterval, 1, 60, 'Check for Update every ' .. '%.0f days')
            end

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
                updateColors()
            end
            if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('If enabled, app will use dark mode.') end) end

            if ui.checkbox('Force App to Bottom', settings.forceBottom) then settings.forceBottom = not settings.forceBottom end
            if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('If enabled, app will be forced to the bottom of the screen.') end) end

            if ui.checkbox('Use 12h Clock', settings.badTime) then settings.badTime = not settings.badTime end
            if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('If enabled, uses 12 hour time format.\nMessage timestamps will include AM/PM.') end) end

            if ui.checkbox('Show Music Information', settings.songInfo) then
                settings.songInfo = not settings.songInfo
                if settings.songInfo then startSongInfo() else stopSongInfo() end
            end
            if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('If enabled, shows current song information if detected.\nCheck your CSP Music settings if there are issues.') end) end

            if settings.songInfo then
                ui.text('\t')
                ui.sameLine()
                if ui.checkbox('Always Scroll Text', settings.scrollAlways) then
                    settings.scrollAlways = not settings.scrollAlways
                    updateSpacing()
                end
                if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('If enabled, will scroll text even if it could be displayed in full.') end) end

                ui.text('\t')
                ui.sameLine()
                if ui.checkbox('Hide Selfie Camera', settings.hideCamera) then settings.hideCamera = not settings.hideCamera end
                if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('If enabled, will hide the selfie camera below the song information.') end) end

                ui.text('\t')
                ui.sameLine()
                local spacesChanged
                settings.spaces, spacesChanged = ui.slider('##Spaces', settings.spaces, 0, 25, 'Spaces: %.0f', true)
                if spacesChanged then
                    updateSpacing()
                end
                if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('The amount of spaces between the end and start of the song when scrolling.') end) end

                ui.text('\t')
                ui.sameLine()
                local speedChanged
                settings.scrollSpeed, speedChanged = ui.slider('##ScrollSpeed', settings.scrollSpeed, 0.1, 15, 'Scroll Speed: %.1f')
                if speedChanged then
                    updateScrollInterval()
                end
                if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('Interval that the text is scrolled at.') end) end

                ui.text('\t')
                ui.sameLine()
                local scrollDirStr = (settings.scrollDirection == 0) and 'Left' or 'Right'
                settings.scrollDirection = ui.slider('##ScrollDirection', settings.scrollDirection, 0, 1, 'Scroll Direction: ' .. scrollDirStr, true)
            end
        end)

        ui.tabItem('Chat', function()
            ui.text('\t')
            ui.sameLine()
            settings.chatFontSize = ui.slider('##ChatFontSize', settings.chatFontSize, 6, 36, 'Chat Fontsize: ' .. '%.0f')

            ui.text('\t')
            ui.sameLine()
            settings.chatScrollDistance = ui.slider('##chatScrollDistance', settings.chatScrollDistance, 1, 100, 'Chat Scroll Distance: ' .. '%.0f')
            if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('Distance to scroll the chat per mousewheel scroll') end) end

            if ui.checkbox('Chat Inactivity Minimizes Phone', settings.appMove) then
                settings.appMove = not settings.appMove
                if settings.appMove then
                    movement.up = false
                    movement.timer = settings.appMoveTimer
                end
            end
            if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('If enabled, the app will move down to free screen space.') end) end

            if settings.appMove then
                ui.text('\t')
                ui.sameLine()
                settings.appMoveTimer, chatinactiveChange = ui.slider('##appMoveTimer', settings.appMoveTimer, 1, 120, 'Inactivity: ' .. '%.0f seconds')
                if chatinactiveChange then movement.timer = settings.appMoveTimer end
                if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('Time before app moves down.') end) end

                ui.text('\t')
                ui.sameLine()
                settings.appMoveSpeed = ui.slider('##appMoveSpeed', settings.appMoveSpeed, 1, 20, 'Speed: ' .. '%.0f')
                if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('How fast the app should move up/down.') end) end
            end

            if ui.checkbox('Chat History Settings', settings.chatPurge) then settings.chatPurge = not settings.chatPurge end
            if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('If enabled, allows you to change the chat message history settings') end) end
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
            if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('If enabled, uses colored usernames if possible.\nServers can overwrite CM tag colors.') end) end

            if ui.checkbox('Show Timestamps', settings.chatShowTimestamps) then settings.chatShowTimestamps = not settings.chatShowTimestamps end
            if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('If enabled, shows message timestamps.') end) end

            if ui.checkbox('Show Join/Leave Messages', settings.connectionEvents) then settings.connectionEvents = not settings.connectionEvents end
            if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('If enabled, shows server message when a player joins/leaves the server.') end) end
            if settings.connectionEvents then
                ui.text('\t')
                ui.sameLine()
                if ui.checkbox('Friends Only', settings.connectionEventsFriendsOnly) then settings.connectionEventsFriendsOnly = not settings.connectionEventsFriendsOnly end
                if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('If enabled, only shows join/leave messages of friends.') end) end
            end

            if ui.checkbox('Highlight Latest Message', settings.chatLatestBold) then settings.chatLatestBold = not settings.chatLatestBold end
            if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('If enabled, text of the latest message will always be bold.') end) end

            if ui.checkbox('Hide Kick Ban Messages', settings.chatHideKickBan) then settings.chatHideKickBan = not settings.chatHideKickBan end
            if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('If enabled, hides kick and ban messages from other players.') end) end

            if ui.checkbox('Hide Annoying Messages', settings.chatHideAnnoying) then settings.chatHideAnnoying = not settings.chatHideAnnoying end
            if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('If enabled, hides annoying messages from apps such as Pit Lane Penalty and Real Penalty.') end) end
        end)

        ui.tabItem('Audio', function()
            if ui.checkbox('Enable Audio', settings.enableAudio) then settings.enableAudio = not settings.enableAudio end
            if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('Toggles all app audio.') end) end

            ui.indent()
            if settings.enableAudio then
                if ui.checkbox('Enable Keystroke Audio', settings.enableKeyboard) then settings.enableKeyboard = not settings.enableKeyboard end
                if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('Toggles keystroke sounds when typing.') end) end
                if settings.enableKeyboard then
                    ui.text('\t')
                    ui.sameLine()
                    settings.volumeKeyboard = ui.slider('##keyboardVolume', settings.volumeKeyboard, 0.1, 10, 'Keystroke Volume: ' .. '%.1f')
                    ui.text('\t')
                    ui.sameLine()
                    if ui.button('Play Test Keystroke') then playTestAudio(audio.keyboard) end
                end

                if ui.checkbox('Enable Message Audio', settings.enableMessage) then settings.enableMessage = not settings.enableMessage end
                if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('Toggles message sounds.') end) end
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
                    if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('Plays message recieved sound for messages from non-friends.') end) end
                    ui.text('\t')
                    ui.sameLine()
                    if ui.checkbox('Server Messages', settings.messagesServer) then settings.messagesServer = not settings.messagesServer end
                    if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('Plays message recieved sound for messages from the server.') end) end
                end

                if ui.checkbox('Enable Notification Audio', settings.enableNotification) then settings.enableNotification = not settings.enableNotification end
                if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('Toggles notification sounds.') end) end
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
                    if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('Plays notification when you are mentioned in chat.') end) end
                    ui.text('\t')
                    ui.sameLine()
                    if ui.checkbox('Friend Messages', settings.notificationsFriendMessages) then settings.notificationsFriendMessages = not settings.notificationsFriendMessages end
                    if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('Plays notification when friend sends a chat message.') end) end
                    if settings.connectionEvents then
                        ui.text('\t')
                        ui.sameLine()
                        if ui.checkbox('Friend Join/Leave', settings.notificationsFriendConnections) then settings.notificationsFriendConnections = not settings.notificationsFriendConnections end
                        if ui.itemHovered() then ui.tooltip(app.tooltipPadding, function() ui.text('Plays notification when friend joins/leaves the server.') end) end
                    end
                end
            end
        end)
    end)
end

--#endregion

--#region APP MAIN WINDOW

function script.windowMain(dt)
    updateAppMovement(dt)

    app.hovered = ui.windowHovered(ui.HoveredFlags.ChildWindows)
    player.car = ac.getCar(0)

    if app.images.phoneAtlasSize == vec2(0, 0) then app.images.phoneAtlasSize = ui.imageSize(app.images.phoneAtlasPath):scale(app.scale) end
    if app.hovered or chat.input.active then moveAppUp() end
    if settings.forceBottom then forceAppToBottom() end

    ui.childWindow('Phone', vec2(app.images.phoneAtlasSize.x / 2, app.images.phoneAtlasSize.y), false, WINDOWFLAGS, function()
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
