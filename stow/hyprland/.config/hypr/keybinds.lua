local v = require("variables")

local notify = "${SCRIPT_DIR}/notify.sh"

-- Navigation

-- Focus
hl.bind("SUPER + " .. v.up,            hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + " .. v.right,         hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + " .. v.down,          hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + " .. v.left,          hl.dsp.focus({ direction = "l" }))

hl.bind("SUPER + Up",                  hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + Right",               hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + Down",                hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + Left",                hl.dsp.focus({ direction = "l" }))

-- Move windows
hl.bind("SUPER + SHIFT + " .. v.up,    hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + " .. v.right, hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + SHIFT + " .. v.down,  hl.dsp.window.move({ direction = "d" }))
hl.bind("SUPER + SHIFT + " .. v.left,  hl.dsp.window.move({ direction = "l" }))

hl.bind("SUPER + SHIFT + Up",          hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + Right",       hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + SHIFT + Down",        hl.dsp.window.move({ direction = "d" }))
hl.bind("SUPER + SHIFT + Left",        hl.dsp.window.move({ direction = "l" }))

-- Minimizing
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Uncommon-tips-and-tricks/#minimize-windows-using-special-workspaces

local scratchpad = "scratchpad"

hl.bind("SUPER + End",    hl.dsp.window.move({ workspace = "special:" .. scratchpad, follow = false }))
hl.bind("SUPER + KP_End", hl.dsp.window.move({ workspace = "special:" .. scratchpad, follow = false }))

hl.bind("SUPER + SHIFT + End",    hl.dsp.window.move({ workspace = "+0", follow = true }))
hl.bind("SUPER + SHIFT + KP_End", hl.dsp.window.move({ workspace = "+0", follow = true }))

hl.bind("SUPER + Home",    hl.dsp.workspace.toggle_special(scratchpad))
hl.bind("SUPER + KP_Home", hl.dsp.workspace.toggle_special(scratchpad))

-- Layouts

hl.bind("SUPER + F",           hl.dsp.window.float({ "toggle" }))
hl.bind("SUPER + SHIFT + F",   hl.dsp.window.float({ "enable" }))

hl.bind("SUPER + S",           function()
    hl.dsp.window.pin({ "enable" })
    hl.dsp.window.float({ "enable" })
end)
hl.bind("SUPER + SHIFT + S",   function()
    hl.dsp.window.pin({ "disable" })
    hl.dsp.window.float({ "disable" })
end)

hl.bind("SUPER + F11",         hl.dsp.window.fullscreen({ "maximized",  "toggle" }))
hl.bind("SUPER + SHIFT + F11", hl.dsp.window.fullscreen({ "fullscreen", "toggle" }))

hl.bind("SUPER + " .. v.LMB,         hl.dsp.window.float(),  { mouse = true, click = true })
hl.bind("SUPER + " .. v.LMB,         hl.dsp.window.drag(),   { mouse = true, drag = true  })
hl.bind("SUPER + " .. v.RMB,         hl.dsp.window.resize(), { mouse = true, drag = true  })

hl.gesture({ fingers = 4, direction = "swipe", action = "resize", mod = "SUPER" })

-- Switch between layouts
hl.bind("SUPER + b", function ()
    local layouts     = { "scrolling", "dwindle", "master", "monocle" }
    local workspace   = hl.get_active_workspace()
    local next_layout = "dwindle"

    if not workspace then
        return
    end

    for i = 1, #layouts do
        if layouts[i] == workspace.tiled_layout then
            local next_layout_idx = (i % #layouts) + 1
            next_layout = layouts[next_layout_idx]
            break
        end
    end

    hl.workspace_rule({
        workspace = workspace.name,
        layout    = next_layout
    })
end)

-- Workspaces

for i = 1, #v.ws.ids do
    -- Focus a specific workspace
    hl.bind("SUPER + " .. v.ws.keys[i], hl.dsp.focus({ workspace = v.ws.ids[i] }))
    -- Move window to a specific workspace
    hl.bind("SUPER + SHIFT + " .. v.ws.keys[i], hl.dsp.window.move({ workspace = v.ws.ids[i], switch = true }))
end

-- Go through workspaces in order
hl.bind("SUPER + CONTROL + " .. v.left,  hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + CONTROL + " .. v.right, hl.dsp.focus({ workspace = "e+1" }))

hl.bind("SUPER + CONTROL + Left",        hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + CONTROL + Right",       hl.dsp.focus({ workspace = "e+1" }))

hl.bind("SUPER + CONTROL + SHIFT + " .. v.left,  hl.dsp.window.move({ workspace = "e-1", switch = true }))
hl.bind("SUPER + CONTROL + SHIFT + " .. v.right, hl.dsp.window.move({ workspace = "e+1", switch = true }))

hl.bind("SUPER + CONTROL + SHIFT + Left",        hl.dsp.window.move({ workspace = "e-1", switch = true }))
hl.bind("SUPER + CONTROL + SHIFT + Right",       hl.dsp.window.move({ workspace = "e+1", switch = true }))

-- Move workspace to the next monitor
hl.bind("SUPER + CONTROL + SHIFT + " .. v.up,    hl.dsp.workspace.move({ workspace="+0", monitor = "-1" }))
hl.bind("SUPER + CONTROL + SHIFT + " .. v.down,  hl.dsp.workspace.move({ workspace="+0", monitor = "+1" }))

hl.bind("SUPER + CONTROL + SHIFT + Up",          hl.dsp.workspace.move({ monitor = "-1" }))
hl.bind("SUPER + CONTROL + SHIFT + Down",        hl.dsp.workspace.move({ monitor = "+1" }))

-- GNOME-like keybinds
hl.bind("SUPER + ALT + " .. v.left,   hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + ALT + " .. v.right,  hl.dsp.focus({ workspace = "e+1" }))

hl.bind("SUPER + ALT + Left",         hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + ALT + Right",        hl.dsp.focus({ workspace = "e+1" }))

hl.bind("SUPER + ALT + SHIFT + " .. v.left,   hl.dsp.window.move({ workspace = "e-1", switch = true }))
hl.bind("SUPER + ALT + SHIFT + " .. v.right,  hl.dsp.window.move({ workspace = "e+1", switch = true }))

hl.bind("SUPER + ALT + SHIFT + Left",         hl.dsp.window.move({ workspace = "e-1", switch = true }))
hl.bind("SUPER + ALT + SHIFT + Right",        hl.dsp.window.move({ workspace = "e+1", switch = true }))

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- System

-- Brightness
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e s 5%- && " .. notify .. " -b"),
    { locked = true, repeating = true, submap_universal = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e s +5% && " .. notify .. " -b"),
    { locked = true, repeating = true, submap_universal = true })

-- Audio
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+ && " .. notify .. " -v"),
    { locked = true, repeating = true, submap_universal = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%- && " .. notify .. " -v"),
    { locked = true, repeating = true, submap_universal = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && " .. notify .. " -v"),
    { locked = true, submap_universal = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && " .. notify .. " -v"),
    { submap_universal = true })

-- Media
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, submap_universal = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"),   { locked = true, submap_universal = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),       { locked = true, submap_universal = true })

hl.bind("SHIFT + XF86AudioMute", hl.dsp.exec_cmd("playerctl play-pause"),      { locked = true, submap_universal = true })
hl.bind("SHIFT + XF86AudioLowerVolume", hl.dsp.exec_cmd("playerctl previous"), { locked = true, submap_universal = true })
hl.bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("playerctl next"),     { locked = true, submap_universal = true })

-- Other special keys
hl.bind("XF86Calculator", hl.dsp.exec_cmd("qalculate-gtk"))

-- Shortcuts

-- Reload
hl.bind("ALT + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
-- TODO hl.bind("Ctrl + Alt + Shift + R", forcerendererreload)
hl.bind("ALT + SHIFT + E", hl.dsp.exit())

-- Kill a window
hl.bind("SUPER + Q",         hl.dsp.window.close())
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.kill())

-- Start a terminal
hl.bind("SUPER + Return",    hl.dsp.exec_cmd(v.term))
hl.bind("CONTROL + ALT + T", hl.dsp.exec_cmd(v.term))

hl.bind("SUPER + SHIFT + Return",    hl.dsp.exec_cmd(v.term .. " -e -- zellij a main"))
hl.bind("CONTROL + ALT + SHIFT + T", hl.dsp.exec_cmd(v.term .. " -e -- zellij a main"))
-- Application menu
hl.bind("ALT + Space", hl.dsp.exec_cmd(v.menu))
-- TODO hl.bind("Alt + Tab", focuscurrentorlast)
-- TODO hl.bind("SUPER + Tab", hl.dsp.exec_cmd(v.windowmenu))

hl.gesture({ fingers = 3, direction = "up", action = function () hl.exec_cmd("pkill " .. v.menu .. " || " .. v.menu) end })
hl.gesture({ fingers = 3, direction = "down", action = function () hl.exec_cmd("pkill " .. v.menu) end })

hl.bind("SUPER + E", hl.dsp.exec_cmd(v.term .. " -e vifm"))
hl.bind("CONTROL + SHIFT + Escape", hl.dsp.exec_cmd(v.term .. " -e zenith"))

hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + mouse_up",   hl.dsp.focus({ workspace = "e+1" }))

hl.bind("SUPER + Delete", hl.dsp.exec_cmd(v.lock))

-- Glass magnifier zoom

local MAX_ZOOM = 3
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR

--@param offset number
--@return nil
local function zoom(offset)
    local current = hl.get_config("cursor.zoom_factor")
    if offset ~= nil then
        current = current + offset
    elseif current ~= MIN_ZOOM then
        current = MIN_ZOOM
    else
        current = ZOOM_TOGGLE_FACTOR
    end
    current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
    hl.config({
        cursor = {
            zoom_factor = current
        }
    })
end

hl.bind("SUPER + SHIFT + Z", zoom)
hl.bind("SUPER + SHIFT + Z + KP_Add", function()
    zoom(0.5)
end)
hl.bind("SUPER + SHIFT + Z + minus", function()
    zoom(-0.5)
end)

