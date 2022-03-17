buttons = {}

local function draw(options, display)
    display.setBackgroundColor(options["BG"])
    display.setTextColor(options["FG"])

    local unformatTxt = {}
    local subStrStart = 1
    for i = 1,options["dy"],1 do
        unformatTxt[i] = string.sub(options["txt"],subStrStart,i*options["dx"])
        subStrStart = i*options["dx"]+1
    end
    local vFormatTxt = {}
    if options["allignV"] == "bottom" then
        local maxOffset = options["dy"]-table.maxn(unformatTxt)
        for i in pairs(unformatTxt) do
            vFormatTxt[i+maxOffset] = unformatTxt[i]
        end
    else
        vFormatTxt = unformatTxt
    end
    local hFormatTxt = {}
    if options["allignH"] == "right" then
        for i in pairs(vFormatTxt) do
            hFormatTxt[i] = string.rep(" ",options["dx"]-string.len(vFormatTxt[i]))
        end
    elseif options["allignH"] == "center" then
        btnMid = math.floor(options["dx"]/2)
        for i in pairs(vFormatTxt) do
            strMid = math.floor(string.len(vFormatTxt[i])/2)
            offset = bntMid - strMid
            hFormatTxt[i] = string.rep(" ",offset)..vFormatTxt[i]..string.rep(" ",options["dx"]-(string.len(vFormatTxt[i])+offset))
        end
    else
        for i in pairs(vFormatTxt) do
            hFormatTxt[i] = vFormatTxt[i]..string.rep(" ",options["dx"]-string.len(vFormatTxt[i]))
        end
    end
    for i in pairs(hFormatTxt) do
        display.setCursorPos(options["x"],options["y"]+i-1)
        display.write(hFormatTxt[i])
    end
end

local function checkPress(btn,x,y,fn)
    local pressed = x >= btn["x"] and x <= btn["x"]+btn["dx"] and y >= btn["y"] and y <= btn["y"]+btn["dy"]
    if pressed then
        if fn then btn["onPress"](btn["ID"]) end
        return true
    else
        return false
    end
end
buttons["draw"] = draw
buttons["checkPress"] = checkPress