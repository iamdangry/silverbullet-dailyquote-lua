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
        editor.flashNotification("Version: " .. version)
    end
}
