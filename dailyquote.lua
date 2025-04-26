local version = "0.1.0"

command.define {
    name = "Daily Quote: Version",
    run = function()
        editor.flashNotification("Version: " .. version)
    end
}

local function fetchQuotes()
    local response = http.request("https://iamdangry.github.io/silverbullet-dailyquote-lua/quotes.json", {
      headers = {
        Accept = "application/json"
      }
    })
    if not response or not response.body then
        print("No response or no body")
        return {}
    end
    local quotes = response.body
    return quotes
end

-- Pick a random quote from parsed quotes
function random_quote()
    local quotes = fetchQuotes()
    if #quotes == 0 then
        return nil
    end
    local quote = quotes[math.random(1, #quotes)]
        local template = [[
> **quote** Quote
> ]] .. quote.content .. [[

> — ]] .. quote.author .. [[
]]
    print(quote)
    return template
end