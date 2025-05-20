ui.setAsynchronousImagesLoading(true)
local WINDOWFLAGS = bit.bor(ui.WindowFlags.NoDecoration, ui.WindowFlags.NoBackground, ui.WindowFlags.NoNav, ui.WindowFlags.NoInputs, ui.WindowFlags.NoScrollbar)
local WINDOWFLAGSINPUT = bit.bor(ui.WindowFlags.NoDecoration, ui.WindowFlags.NoBackground, ui.WindowFlags.NoNav, ui.WindowFlags.NoScrollbar)


--#region APP PERSISTENT SETTINGS

local settings = ac.storage {
    appScale = 1,
    songInfo = false,
    forceBottom = true,
    darkMode = false,
    appMove = false,
    appMoveTimer = 10,
    appMoveSpeed = 7,
    badTime = false,
    spaces = 5,
    scrollSpeed = 2,
    scrollDirection = 0,
    chatKeepSize = 100,
    chatOlderThan = 15,
    chatScrollDistance = 20,
    connectionEvents = true,
    connectionEventsFriendsOnly = true,
    chatPurge = false,
    chatFontSize = 13,
    chatHideKickBan = false,
    chatHideAnnoying = true,
    chatLatestBold = false,
    hideCamera = false,
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
    final = {
        display = rgb(),
        header = rgbm(),
        headerLine = rgbm(),
        elements = rgb(),
        message = rgb(),
        input = rgbm(),
    },
}

local app = {
    scale = 1,
    hovered = false,
    images = {
        phoneAtlasPath = './src/img/app/phone.png',
        phoneAtlasSize = vec2(),
        phoneCamera = './src/img/app/cam.png',
        pingAtlasPath = './src/img/app/connection.png',
        contactDefault = './src/img/app/default.png',
        communities = {
            srpLogo = './src/img/communities/srp-logo-socials.png',
        },
    },
    font = {
        regular = ui.DWriteFont('Inter Variable Text', './src/ttf'):weight(ui.DWriteFont.Weight.Medium),
        bold = ui.DWriteFont('Inter Variable Text', './src/ttf'):weight(ui.DWriteFont.Weight.Bold),
    }
}

local player = {
    car = ac.getCar(0),
    cspVersion = ac.getPatchVersionCode(),
    isOnline = ac.getSim().isOnlineRace,
    serverIP = ac.getServerIP(),
    serverCommunity = nil,
}

local communityList = {
    srp = {
        '5.161.43.117',
        '65.108.176.35',
        '15.235.162.98'
    },
}

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
    messageHovered = {},
    sendCd = false,
    scrollBool = false,
    mentioned = '',
    input = {
        active = false,
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
    }
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
    if hour >= 12 then
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
    if not player.serverIP then return nil end

    for community, ipTable in pairs(communityList) do
        for _, ip in ipairs(ipTable) do
            if ip == player.serverIP then
                return community
            end
        end
    end

    return nil
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

            if utf8len(songInfo.scroll) < 20 then
                songInfo.static = true
                songInfo.align = ui.Alignment.Center
            else
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

---@param isPlayer boolean @Indicates if the message originates from a player or the server.
---@param message string @The string content of the incoming chat message.
---@return boolean @Returns true if the message matches one of the hide patterns.
---Determines whether a chat message should be hidden based on the pattern strings.
local function matchMessage(isPlayer, message)
    local lowerMessage = message:lower()
    local lowerPlayerName = ac.getDriverName(0):lower()

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
                    --notification.allow = true
                else
                    if lowerMessage:find('^you') or lowerMessage:find('^it is currently night') then
                        --notification.allow = true
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
    local inputHovered = ui.windowHovered(ui.HoveredFlags.AllowWhenOverlapped)
    local inputMaxLen = math.floor(490 * (13 / settings.chatFontSize) ^ 2)

    if (ui.keyPressed(ui.Key.Backspace, true) or ui.keyPressed(ui.Key.Delete)) and msgLen then
        if chat.input.selected then
            chat.input.text = ''
            chat.input.selected = nil
        end
        chat.input.text = utf8sub(chat.input.text, 1, utf8len(chat.input.text) - 1)
    elseif ui.keyPressed(ui.Key.Enter) and msgLen and not chat.sendCd then
        ac.sendChatMessage(chat.input.text)
        chat.sendCd = true

        if inputHovered then
            chat.input.text = ''
        else
            chat.input.active = false
        end

        chat.input.historyIndex = 0
        chat.scrollBool = true
        setTimeout(function() chat.scrollBool = false end, 0.1)
        setTimeout(function() chat.sendCd = false end, 1)
    elseif ui.keyboardButtonDown(ui.KeyIndex.Control) and ui.keyboardButtonPressed(ui.KeyIndex.V, true) then
        if utf8len(chat.input.text .. ui.getClipboardText()) >= inputMaxLen then return end
        typed = typed .. ui.getClipboardText()
    elseif ui.keyboardButtonDown(ui.KeyIndex.Control) and ui.keyboardButtonPressed(ui.KeyIndex.A) and msgLen then
        if chat.input.selected then chat.input.selected = nil end
        chat.input.selected = chat.input.text
    elseif ui.keyboardButtonDown(ui.KeyIndex.Control) and ui.keyboardButtonPressed(ui.KeyIndex.C) and chat.input.selected then
        ac.setClipboardText(chat.input.selected)
    elseif ui.keyboardButtonDown(ui.KeyIndex.Control) and ui.keyboardButtonPressed(ui.KeyIndex.X) and chat.input.selected then
        ac.setClipboardText(chat.input.selected)
        chat.input.text = ''
        chat.input.selected = nil
    elseif ui.keyPressed(ui.Key.Up) and chat.input.active then
        if chat.input.historyIndex < #chat.input.history then
            chat.input.historyIndex = chat.input.historyIndex + 1
            chat.input.text = chat.input.history[#chat.input.history - chat.input.historyIndex + 1][3]
        end
    elseif ui.keyPressed(ui.Key.Down) and chat.input.active then
        if chat.input.historyIndex > 1 then
            chat.input.historyIndex = chat.input.historyIndex - 1
            chat.input.text = chat.input.history[#chat.input.history - chat.input.historyIndex + 1][3]
        elseif chat.input.historyIndex == 1 then
            chat.input.historyIndex = 0
            chat.input.text = ''
        end
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
    ping = player.cspVersion < 3044 and 999 or player.car.ping

    if ping > -1 then
        local pingAtlasSize = ui.imageSize(app.images.pingAtlasPath):scale(app.scale)
        local pingSize = vec2(20, 20):scale(app.scale)
        local pingPosition = vec2(scale(238), pingSize.y + movement.smooth)

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
end

local function drawDynamicIsland()
    ui.drawRectFilled(vec2((ui.windowWidth() / 2 - scale(songInfo.dynamicIslandSize.x)), scale(songInfo.dynamicIslandSize.y) + movement.smooth), vec2((ui.windowWidth() / 2 + scale(songInfo.dynamicIslandSize.x)), scale(songInfo.dynamicIslandSize.y * 2) + movement.smooth), rgb.colors.black, scale(10))
    if not settings.hideCamera then
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

    local contactSize = vec2(36, 36):scale(app.scale)
    local contactPosition = vec2(129, 47):scale(app.scale) + vec2(0, movement.smooth)
    local contactRounding = scale(20)

    if player.serverCommunity == nil then
        ui.drawImage(app.images.contactDefault, contactPosition, contactPosition + contactSize)
    elseif player.serverCommunity == 'srp' then
        ui.drawImageRounded(app.images.communities.srpLogo, contactPosition, contactPosition + contactSize, contactRounding)
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
        ui.pushDWriteFont(app.font.bold)
        local songTextSize = vec2(133, 15):scale(app.scale)
        ui.setCursor(vec2(math.round(ui.windowWidth() / 2 - songTextSize.x / 2.3), songPosition.y + movement.smooth))
        ui.dwriteTextAligned(songInfo.final, songFontSize, songInfo.align, ui.Alignment.End, songTextSize, false, rgb.colors.white)
        ui.popDWriteFont()
    end
end

local function drawMessages()
    ui.pushClipRect(vec2(0, 0), vec2(ui.windowWidth(), (scale(497) - chat.input.offset) + movement.smooth))
    ui.setCursor(vec2(13, 100):scale(app.scale) + vec2(0, movement.smooth))
    ui.childWindow('Messages', vec2(266, 400 - chat.input.offset):scale(app.scale), false, WINDOWFLAGS, function()
        local messageFontSize = scale(settings.chatFontSize)
        local usernameFontSize = scale(settings.chatFontSize - 2)
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
                local messageTextcontent = chat.messages[i][3]
                local fontWeight = app.font.regular

                if (i == #chat.messages and settings.chatLatestBold) or messageTextcontent:lower():find('%f[%a_]' .. ac.getDriverName(0):lower() .. '%f[%A_]') then
                    fontWeight = app.font.bold
                else
                    fontWeight = app.font.regular
                end

                if messageUserIndex == 0 then
                    ui.pushDWriteFont(app.font.bold)
                    local userNameTextSize = ui.measureDWriteText(messageUsername, usernameFontSize)

                    if not messageUserIndexLast then
                        ui.setCursor(vec2(usernameOffset.x, msgDist))
                        ui.dwriteTextAligned(messageUsername, usernameFontSize, ui.Alignment.End, ui.Alignment.Start, vec2(messageMaxWidth, userNameTextSize.y), false, rgb.colors.gray)
                        msgDist = math.ceil(msgDist + usernameOffset.y)
                    else
                        if messageUserIndexLast ~= messageUserIndex then
                            if messageUserIndexLast ~= -1 then msgDist = math.ceil(msgDist - usernameOffset.y / 2) end
                            ui.setCursor(vec2(usernameOffset.x, msgDist))
                            ui.dwriteTextAligned(messageUsername, usernameFontSize, ui.Alignment.End, ui.Alignment.Start, vec2(messageMaxWidth, userNameTextSize.y), false, rgb.colors.gray)
                            msgDist = math.ceil(msgDist + usernameOffset.y)
                        end
                    end
                    ui.popDWriteFont()
                    ui.pushDWriteFont(fontWeight)
                    local messageTextSize = ui.measureDWriteText(messageTextcontent, messageFontSize, scale(190))
                    msgDist = math.ceil(msgDist + messageTextSize.y)
                    ui.setCursor(vec2(ui.windowSize().x - scale(5), msgDist))
                    ui.drawRectFilled(ui.getCursor() - vec2(math.ceil(messageTextSize.x + messagePadding.x), math.ceil(messageTextSize.y + messagePadding.y)), ui.getCursor(), colors.iMessageBlue, messageRounding)
                    ui.setCursor(ui.getCursor() - vec2(math.ceil(messageTextSize.x + messagePadding.x / 2), math.ceil(messageTextSize.y + messagePadding.y / 2)))
                    ui.dwriteTextAligned(messageTextcontent, messageFontSize, ui.Alignment.Start, ui.Alignment.Start, vec2(messageTextSize.x, messageTextSize.y + messageRounding), true, rgb.colors.white)
                    ui.popDWriteFont()
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
                        ui.dwriteTextAligned(messageUsername, usernameFontSize, ui.Alignment.Start, ui.Alignment.Start, vec2(messageMaxWidth, userNameTextSize.y), false, rgb.colors.gray)
                        msgDist = math.ceil(msgDist + usernameOffset.y)
                    else
                        if messageUserIndexLast ~= messageUserIndex then
                            if messageUserIndexLast ~= -1 then msgDist = math.ceil(msgDist - usernameOffset.y / 2) end
                            ui.setCursor(vec2(usernameOffset.x / 2, msgDist))
                            ui.dwriteTextAligned(messageUsername, usernameFontSize, ui.Alignment.Start, ui.Alignment.Start, vec2(messageMaxWidth, userNameTextSize.y), false, rgb.colors.gray)
                            msgDist = math.ceil(msgDist + usernameOffset.y)
                        end
                    end
                    ui.popDWriteFont()
                    ui.pushDWriteFont(fontWeight)
                    local messageTextSize = ui.measureDWriteText(messageTextcontent, messageFontSize, scale(190))
                    msgDist = math.ceil(msgDist + messageTextSize.y)
                    ui.setCursor(vec2(math.ceil(messageTextSize.x + messagePadding.x + scale(5)), msgDist))
                    ui.drawRectFilled(ui.getCursor() - vec2(math.ceil(messageTextSize.x + messagePadding.x), math.ceil(messageTextSize.y + messagePadding.y)), ui.getCursor(), bubbleColor, messageRounding)
                    chat.messageHovered[i] = ui.rectHovered(ui.getCursor() - vec2(math.ceil(messageTextSize.x + messagePadding.x), math.ceil(messageTextSize.y + messagePadding.y + userNameTextSize.y)), ui.getCursor(), true)
                    ui.setCursor(ui.getCursor() - vec2(math.ceil(messageTextSize.x + messagePadding.x / 2), math.ceil(messageTextSize.y + messagePadding.y / 2)))
                    ui.dwriteTextAligned(messageTextcontent, messageFontSize, ui.Alignment.Start, ui.Alignment.Start, vec2(messageTextSize.x, messageTextSize.y + messageRounding), true, messageTextColor)
                    ui.popDWriteFont()

                    if chat.messageHovered[i] and ui.mouseClicked(ui.MouseButton.Right) then
                        chat.mentioned = '@' .. messageUsername .. ' '
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

                if (not app.hovered or chat.scrollBool) or (chat.input.active and app.hovered) and ui.getScrollY() ~= ui.getScrollMaxY() then ui.setScrollHereY(-1) end
            end
        end

        if app.hovered and ui.mouseWheel() ~= 0 then
            local mouseWheel = (ui.mouseWheel() * -1) * (scale(settings.chatScrollDistance))
            ui.setScrollY(mouseWheel, true, true)
        end
    end)
    ui.popClipRect()
end

local function drawInputCustom()
    local inputSize = vec2(235, 32):scale(app.scale) + vec2(0, chat.input.offset)
    local inputBoxSize = inputSize - vec2(5, 5):scale(app.scale)
    local inputFontSize = scale(settings.chatFontSize)
    local inputWrap = scale(190)
    ui.setCursor(vec2(scale(42), (ui.windowHeight() - scale(32) - chat.input.offset) + movement.smooth))
    ui.childWindow('ChatInput', inputSize, false, WINDOWFLAGSINPUT, function()
        ui.beginOutline()
        ui.drawRectFilled(vec2(2, 2), inputBoxSize, colors.final.display, scale(10))
        ui.endOutline(settings.darkMode and colors.transparent.white10 or colors.transparent.black10, math.max(1, math.round(1 * app.scale, 1)))
        local displayText = ''
        ui.pushDWriteFont(app.font.regular)
        local lineHeight = ui.measureDWriteText('Line Height', inputFontSize, inputWrap).y

        if player.isOnline then
            local inputHovered = ui.windowHovered(ui.HoveredFlags.RectOnly)
            local inputClicked = inputHovered and ui.mouseClicked(ui.MouseButton.Left)

            if inputHovered then
                ui.setMouseCursor(ui.MouseCursor.TextInput)
            end

            if inputClicked or chat.mentioned ~= '' then
                if not chat.input.active then chat.input.text = '' end
                chat.input.active = true
                chat.input.text = chat.mentioned
            elseif ui.mouseClicked(ui.MouseButton.Left) then
                chat.input.active = false
                chat.input.text = chat.input.placeholder
                chat.input.selected = nil
                chat.input.historyIndex = 0
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

        local inputTextSize = ui.measureDWriteText(displayText, inputFontSize, inputWrap)
        ui.setCursor(vec2(10, 6):scale(app.scale))
        ui.pushClipRect(ui.getCursor(), ui.getCursor() + inputBoxSize - vec2(0, 9):scale(app.scale) + movement.smooth)
        ui.dwriteTextAligned(displayText, inputFontSize, ui.Alignment.Start, ui.Alignment.Center, inputTextSize, true, colors.final.input)
        ui.popDWriteFont()
        ui.popClipRect()

        if player.isOnline and (chat.input.text ~= chat.input.placeholder and chat.input.text ~= '') then
            local circleRad = scale(10)
            local circlePadding = circleRad + scale(2)
            local arrowRad = vec2(7, 7):scale(app.scale)
            local buttonColor = rgb():set(colors.iMessageBlue)

            ui.setCursor(vec2(inputBoxSize.x - circlePadding, inputBoxSize.y - circlePadding))
            local sendHovered = ui.rectHovered(ui.getCursor() - vec2(circleRad, circleRad), ui.getCursor() + vec2(circleRad, circleRad))

            if sendHovered then
                ui.setMouseCursor(ui.MouseCursor.Hand)
                buttonColor:mul(rgb(0.6, 0.6, 0.8))

                if ui.mouseClicked(ui.MouseButton.Left) then
                    ac.sendChatMessage(chat.input.text)
                    chat.input.active = false
                    chat.sendCd = true
                    chat.input.historyIndex = 0
                    chat.scrollBool = true
                    setTimeout(function() chat.scrollBool = false end, 0.1)
                    setTimeout(function() chat.sendCd = false end, 1)
                end
            end

            ui.drawCircleFilled(ui.getCursor(), circleRad, buttonColor, 25)
            ui.drawIcon(ui.Icons.ArrowUp, ui.getCursor() - arrowRad, ui.getCursor() + arrowRad, rgb.colors.white)
        end

        chat.input.offset = math.min(math.floor(inputTextSize.y - scale(15)), scale(390))
    end)
end

--#endregion

--#region APP EVENTS

ac.onChatMessage(function(message, senderCarIndex)
    local escapedMessage = message:gsub('([%(%)%.%%%+%-%*%?%[%]%^%$])', '%%%1')
    local isPlayer = senderCarIndex > -1
    local isFriend = isPlayer and checkIfFriend(senderCarIndex)
    local hideMessage = false

    if isPlayer then
        hideMessage = matchMessage(isPlayer, escapedMessage) and settings.chatHideAnnoying
    else
        hideMessage = matchMessage(isPlayer, escapedMessage) and settings.chatHideKickBan
    end

    if not hideMessage and message:len() > 0 then
        deleteOldestMessages()

        table.insert(chat.messages, { senderCarIndex, isPlayer and ac.getDriverName(senderCarIndex) or 'Server', message, os.time() })

        if senderCarIndex == 0 then
            table.insert(chat.input.history, { senderCarIndex, isPlayer and ac.getDriverName(senderCarIndex) or 'Server', message, os.time() })
            if #chat.input.history > 15 then table.remove(chat.input.history, 1) end
        end

        moveAppUp()
    end
end)

if settings.connectionEvents then
    ---@param connectedCarIndex number @Car index of the car that joined/left
    ---@param action string @joined/left string
    ---adds system messages for join/leave events.
    local function connectionHandler(connectedCarIndex, action)
        if not settings.connectionEventsFriendsOnly or checkIfFriend(connectedCarIndex) then
            deleteOldestMessages()
            table.insert(chat.messages, { -1, 'Server', ac.getDriverName(connectedCarIndex) .. action .. ' the Server', os.time() })
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
        ui.tabItem('App', function()
            ui.text('\t')
            ui.sameLine()
            settings.appScale = ui.slider('##AppScale', settings.appScale, 0.5, 2, 'App Scale: ' .. '%.01f%')
            if app.scale ~= math.round(settings.appScale, 1) then
                moveAppUp()
                app.scale = math.round(settings.appScale, 1)
                app.images.phoneAtlasSize = ui.imageSize(app.images.phoneAtlasPath):scale(app.scale)
            end

            if player.cspVersion >= 3044 then
                if ui.checkbox('Force App to Bottom', settings.forceBottom) then settings.forceBottom = not settings.forceBottom end
            end

            if ui.checkbox('Dark Mode', settings.darkMode) then
                settings.darkMode = not settings.darkMode
                updateColors()
            end

            if ui.checkbox('Use 12h Clock', settings.badTime) then settings.badTime = not settings.badTime end

            if ui.checkbox('Hide Selfie Camera', settings.hideCamera) then settings.hideCamera = not settings.hideCamera end

            if ui.checkbox('Show Music Information', settings.songInfo) then
                settings.songInfo = not settings.songInfo
                if settings.songInfo then
                    startSongInfo()
                else
                    stopSongInfo()
                end
            end

            if settings.songInfo then
                ui.text('\t')
                ui.sameLine()
                local spacesChanged
                settings.spaces, spacesChanged = ui.slider('##Spaces', settings.spaces, 0, 25, 'Spaces: %.0f', true)
                if spacesChanged then
                    updateSpacing()
                end

                ui.text('\t')
                ui.sameLine()
                local speedChanged
                settings.scrollSpeed, speedChanged = ui.slider('##ScrollSpeed', settings.scrollSpeed, 0.1, 15, 'Scroll Speed: %.1f')
                if speedChanged then
                    updateScrollInterval()
                end

                ui.text('\t')
                ui.sameLine()
                local scrollDirStr = (settings.scrollDirection == 0) and 'Left' or 'Right'
                settings.scrollDirection = ui.slider('##ScrollDirection', settings.scrollDirection, 0, 1, 'Scroll Direction: ' .. scrollDirStr, true)
            end
        end)
        ui.tabItem('Chat', function()
            settings.chatFontSize = ui.slider('##ChatFontSize', settings.chatFontSize, 6, 36, 'Chat Fontsize: ' .. '%.0f')

            settings.chatScrollDistance = ui.slider('##chatScrollDistance', settings.chatScrollDistance, 1, 100, 'Chat Scroll Distance: ' .. '%.0f')

            if ui.checkbox('Chat Inactivity Minimizes Phone', settings.appMove) then
                settings.appMove = not settings.appMove
                if settings.appMove then
                    movement.up = false
                    movement.timer = settings.appMoveTimer
                end
            end

            if settings.appMove then
                ui.text('\t')
                ui.sameLine()
                settings.appMoveTimer, chatinactiveChange = ui.slider('##appMoveTimer', settings.appMoveTimer, 1, 120, 'Inactivity: ' .. '%.0f seconds')
                if chatinactiveChange then movement.timer = settings.appMoveTimer end

                ui.text('\t')
                ui.sameLine()
                settings.appMoveSpeed = ui.slider('##appMoveSpeed', settings.appMoveSpeed, 1, 20, 'Speed: ' .. '%.0f')
            end

            ui.drawSimpleLine(ui.getCursor(), vec2(ui.windowWidth(), ui.getCursorY()), ac.getUI().accentColor)
            ui.newLine(-9)

            if ui.checkbox('Show Join/Leave Messages', settings.connectionEvents) then settings.connectionEvents = not settings.connectionEvents end
            if settings.connectionEvents then
                ui.text('\t')
                ui.sameLine()
                if ui.checkbox('Friends Only', settings.connectionEventsFriendsOnly) then settings.connectionEventsFriendsOnly = not settings.connectionEventsFriendsOnly end
            end

            if ui.checkbox('Highlight Latest Message', settings.chatLatestBold) then settings.chatLatestBold = not settings.chatLatestBold end

            if ui.checkbox('Hide Kick and Ban Messages', settings.chatHideKickBan) then settings.chatHideKickBan = not settings.chatHideKickBan end

            if ui.checkbox('Hide Annoying App Messages', settings.chatHideAnnoying) then settings.chatHideAnnoying = not settings.chatHideAnnoying end

            if ui.checkbox('Chat History Settings', settings.chatPurge) then settings.chatPurge = not settings.chatPurge end
            if settings.chatPurge then
                ui.text('\t')
                ui.sameLine()
                settings.chatKeepSize = ui.slider('##ChatKeepSize', settings.chatKeepSize, 10, 500, 'Always keep %.0f Messages')

                ui.text('\t')
                ui.sameLine()
                settings.chatOlderThan = ui.slider('##ChatOlderThan', settings.chatOlderThan, 1, 60, 'Remove if older than %.0f min')
            end
        end)

        ui.tabItem('Audio', function()
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
    if app.hovered then moveAppUp() end
    if player.cspVersion >= 3044 and settings.forceBottom then forceAppToBottom() end

    ui.childWindow('Phone', vec2(app.images.phoneAtlasSize.x / 2, app.images.phoneAtlasSize.y), false, WINDOWFLAGS, function()
        drawDisplay()

        drawHeader()
        drawTime()
        drawPing()
        drawDynamicIsland()
        drawSongInfo()

        drawMessages()
        drawInputCustom()

        drawiPhone()
    end)
end

--#endregion
