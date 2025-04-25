local version = "0.1.0"

command.define {
    name = "Daily Quote: Version",
    run = function()
        editor.flashNotification "Version: " .. version
    end
}