-- Description: Daily Quote plugin for SilverBullet
-- Author: iamdangry
-- Version: 0.1.0
-- License: MIT
-- Repo: https://github.com/iamdangry/silverbullet-dailyquote-lua
local version = "0.1.0"

command.define {
    name = "Daily Quote: Version",
    run = function()
        editor.flashNotification "Version: " .. version
    end
}