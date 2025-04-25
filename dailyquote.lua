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

command.define {
    name = "Daily Quote: Import",
    run = function()
        importQuotes()
    end
}

function importQuotes()
    if not space.fileExists("quotes.json") then
        editor.flashNotification("Importing quotes...")
        local quotes = http.request("https://raw.githubusercontent.com/iamdangry/silverbullet-dailyquote/refs/heads/main/quotes.json")
        if quotes then
            json = space.writeFile("_plugs/quotes.json", quotes)
            if json then
                dailyQuote.quotes = json
                editor.flashNotification("Quotes imported successfully!")
            else
                editor.flashNotification("Failed to parse quotes.")
            end
        else
            editor.flashNotification("Failed to fetch quotes.")
        end
    end
end

event.listen {
    name = "system:ready",
    run = function()
        importQuotes()
    end
}