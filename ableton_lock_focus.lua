-- Hammerspoon Script to "Lock Focus" on Ableton Live
local appName = "Live"
local forceFocusInterval = 0.1 -- Time in seconds to check focus

-- Function to ensure Ableton is always focused
local function lockFocusOnAbleton()
    local currentApp = hs.application.frontmostApplication()
    if currentApp:name() ~= appName then
        local abletonApp = hs.application.find(appName)
        if abletonApp then
            abletonApp:activate() -- Brings Ableton to the front
        end
    end
end

-- Timer to repeatedly check and refocus
local focusTimer = hs.timer.doEvery(forceFocusInterval, lockFocusOnAbleton)

-- Stop and start commands for flexibility
hs.hotkey.bind({"cmd", "ctrl"}, "F", function()
    if focusTimer:running() then
        focusTimer:stop()
        hs.alert.show("Focus Lock: Disabled")
    else
        focusTimer:start()
        hs.alert.show("Focus Lock: Enabled")
    end
end)
