--options
--  t=BUTTON
--      x
--      y
--      dx
--      dy
--      BG
--      FG
--      txt             text of button(wrapps,does not support /n, instead use string.rep(" ",options.dx))
--      onPress
--      ID              argument for onPress(mostly used so onPress knows which button was pressed)
--  t=TEXTBOX
--      x
--      y
--      dx
--      activeBG
--      activeFG
--      BG
--      FG
--      contextFG
--      context         the text to show when no text was entered (e.g. 'password:')
--      maxChar
--      input           the entered text(used internally)
--      active          whether textbox is selected(used internally)
--  t=DROPDOWN
--      x
--      y
--      dx
--      activeBG
--      activeFG
--      BG
--      FG
--      items
--      selected        the index of the selected item(used internally)
--      active          wether dropdown is shown(used internally)
ui = {}

local function draw(options, display, maxY)
    if options.t == "button" then
        --if BUTTON
        if options.BG then display.setBackgroundColor(options.BG) else display.setBackgroundColor(colors.black) end
        if options.FG then display.setTextColor(options.FG) else display.setTextColor(colors.white) end

        local wrappedTxt = {}
        local subStrStart = 1
        for i = 1,options.dy,1 do
            wrappedTxt[i] = string.sub(options.txt,subStrStart,i*options.txt)
            subStrStart = i*options.dx+1
        end
        for i in pairs(wrappedTxt) do
            display.setCursorPos(options.x,options.y+i-1)
            display.write(wrappedTxt[i])
        end
        --if TEXTBOX
    elseif options.t == "textBox" then
        if options.active == true then
            if options.activeBG then display.setBackgroundColor(options.activeBG) else display.setBackgroundColor(options.BG or colors.lightGray) end
            if options.activeFG then display.setBackgroundColor(options.activeFG) else display.setBackgroundColor(options.FG or colors.white) end
        else
            if options.BG then display.setBackgroundColor(options.BG) else display.setBackgroundColor(colors.grey) end
            if options.FG then display.setBackgroundColor(options.FG) else display.setBackgroundColor(colors.white) end
        end

        local text = ""
        if not options.input then
            if options.contextFG then display.setBackgroundColor(options.contextFG) else display.setBackgroundColor(colors.light_gray) end
            text = options.context..string.rep(" ",options.dx-string.len(options.context))
        elseif options.input == "" then
            if options.contextFG then display.setBackgroundColor(options.contextFG) else display.setBackgroundColor(colors.light_gray) end
            text = options.context..string.rep(" ",options.dx-string.len(options.context))
        else
            if options.input > options.dx then
                text = string.sub(options.input,options.input-options.dx,string.len(options.input))
            else
                text = options.input..string.rep(" ",options.dx-string.len(options.input))
            end
        end

        display.setCursorPos(options.x,options.y)
        display.write(text)
    elseif options.t == "dropDown" then
        if options.active == true then
            if options.activeBG then display.setBackgroundColor(options.activeBG) else display.setBackgroundColor(options.BG or colors.lightGray) end
            if options.activeFG then display.setBackgroundColor(options.activeFG) else display.setBackgroundColor(options.FG or colors.white) end
        else
            if options.BG then display.setBackgroundColor(options.BG) else display.setBackgroundColor(colors.grey) end
            if options.FG then display.setBackgroundColor(options.FG) else display.setBackgroundColor(colors.white) end
        end
        local text = {}
        local reverse = false
        if not options.active then text = options["items"][options.selected] .. string.rep(" ",options.dx-string.len(options["items"][options.selected])) else
            if maxY > options.y+table.len(options.items) then reverse = true end
            if not reverse then
                for i in pairs(options.items) do
                    text[i] = options["items"][i]
                end
            else
                for i in pairs(options.items) do
                    text[table.len(options.items)-i+1] = options["items"][i]
                end
            end
            for i in pairs(text) do
                display.setCursorPos(options.x,options.y+i-1)
                display.write(text[i])
            end
        end
    end
end

local function onEvent(event)
    
end
ui.draw = draw
ui.onEvent = onEvent