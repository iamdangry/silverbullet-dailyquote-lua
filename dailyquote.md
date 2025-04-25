# meta

Description: Daily Quote plugin for SilverBullet
Author: iamdangry
Version: 0.1.0
License: MIT
Repo: https://github.com/iamdangry/silverbullet-dailyquote-lua

```space-lua
local version = "0.1.0"

dailyQuote = {}
dailyQuote.config = config.get("dailyquote", {})
dailyQuote.includeTags = dailyQuote.includeTags or {}
dailyQuote.excludeTags = dailyQuote.excludeTags or {}
dailyQuote.includeAuthors = dailyQuote.includeAuthors or {}
dailyQuote.excludeAuthors = dailyQuote.excludeAuthors or {}

command.define {
    name = "Daily Quote: Version",
    run = function()
        editor.flashNotification "Version: " .. version
    end
}

function dailyQuote.importQuotes()
    local url = "https://raw.githubusercontent.com/iamdangry/silverbullet-dailyquote/refs/heads/main/quotes.json"
    local targetPath = "_plugs/quotes.json"

    local response, err = http.request(url, "GET")
    if not response or response.status ~= 200 then
        editor.flashNotification "Failed to download quotes.json: " .. (err or response.status), "error"
        return
    end

    local ok, err = space.writeFile(targetPath, response.body)
    if not ok then
        editor.flashNotification "Failed to save quotes.json: " .. err, "error"
        return
    end

    editor.flashNotification "quotes.json downloaded to " .. targetPath
end

command.define {
    name = "Daily Quote: Load Database",
    run = function()
        local jsonPath = config.get("dailyquote.jsonPath", "dailyquote.json")
        local jsonFile = io.open(jsonPath, "r")
        if not jsonFile then
            editor.flashNotification "JSON file not found: " .. jsonPath
            return
        end
    
        local content = jsonFile:read("*a")
        jsonFile:close()
    
        local success, parsed = pcall(json.decode, content)
        if not success then
            editor.flashNotification "Failed to parse JSON file: " .. jsonPath, "error"
            return
        end
    
        dailyQuote.database = parsed
        editor.flashNotification "Quotes loaded from JSON."
    end
```