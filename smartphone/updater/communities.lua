---Community data updater for the Smartphone app by C1XTZ.
local Communities = {}

local scriptFolder = ac.getFolder(ac.FolderID.ScriptOrigin)
local dataFile = scriptFolder .. '\\src\\communities\\data\\list.lua'
local remoteBase = 'https://raw.githubusercontent.com/C1XTZ/ac-smartphone/master/smartphone/src/communities/'

Communities.state = ac.storage {
  dataCheckFailed = false,
}

---@param currentCommunities table @The communities table already loaded.
---Updates the community data from github.
function Communities.checkForUpdate(currentCommunities)
  web.get(remoteBase .. 'data/list.lua', function(err, response)
    if err or response.status ~= 200 then
      Communities.state.dataCheckFailed = true
      error("Couldn't get community data from github.")
      return
    end

    local remoteData = stringify.parse(response.body) ---@cast remoteData table
    if not remoteData or not currentCommunities then
      error('Web request or Communities table is nil.')
      return
    end

    if currentCommunities.version[1] == remoteData.version[1] then
      ac.log('Already using latest community data.')
      return
    end

    ac.pauseFilesWatching(true)

    local newImages = {}
    for name, community in pairs(remoteData) do
      if name ~= 'default' and name ~= 'version' and community.image then newImages[community.image] = true end
    end

    for name, community in pairs(currentCommunities) do
      if name ~= 'default' and name ~= 'version' and community.image and not newImages[community.image] then
        io.deleteFile(community.image)
        ac.log('Removed community image: ' .. community.image)
      end
    end

    local file = io.open(dataFile, 'w+')
    if file then
      file:write(stringify(remoteData))
      file:close()
    end

    for name, community in pairs(remoteData) do
      if name ~= 'default' and community.image then
        local filename = community.image:match('([^\\]+)$')
        web.get(remoteBase .. 'img/' .. filename, function(err2, response2)
          if err2 or response2.status ~= 200 then
            Communities.state.dataCheckFailed = true
            error("Couldn't get community data from github.")
            return
          end
          io.save(community.image, response2.body)
        end)
      end
    end

    Communities.state.dataCheckFailed = false

    ac.pauseFilesWatching(false)

    ac.log('Updated to latest community data.')
  end)
end

return Communities
