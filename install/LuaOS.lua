local function checkNetwork()
    if not http then
        term.setTextColor(colors.red)
        term.write("You must activate the http module in\nthe computercraft server config file to\ninstall LuaOS.\n")
        return true
    end
    if not http.checkURL("https://githubusercontent.com") then
        term.setTextColor(colors.red)
        term.write("Could not verify github.com(githubusercontent.com).\nMaybe the website was disabled by the server owner.\nGithub is required to install necessary Software.\n")
        return true
    end
    if not http.get("https://raw.githubusercontent.com/bnjmn21/LuaOS/main/README.md") then
        term.setTextColor(colors.red)
        term.write("Failed to connect to github. Check your internet connection.\n")
        return true
    end
end

local function getRepoFile(path)
    local res = http.get("https://raw.githubusercontent.com/bnjmn21/LuaOS/main/"+path)
    local str = res.readAll()
    res.close()
    return str
end

local function saveFile(str,path)
    local handle = fs.open(path,"w")
    handle.write(str)
    handle.close()

term.clear()
term.setCursorPos(1, 1)
term.write("\n\n\n")
term.write("===LUAOS-INSTALLER===\n")
term.write("This Software will install the LuaOS\nonto this PC. Additional Packages will be installed.")
term.write("===\n")
term.write("Continuing in 5 seconds...\n")
os.sleep(5)
term.clear()
term.setCursorPos(1, 1)
local canConnect = checkNetwork()
if canConnect then
    exit()
end
term.setTextColor(colors.lime)
term.write("Network check completed!\n")
term.setTextColor(colors.white)
term.write("Installation Phase 1:\n")
term.setTestColor(colors.lime)
