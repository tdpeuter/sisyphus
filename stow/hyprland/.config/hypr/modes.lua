local v = require("variables")

local mode_reset = "reset"

-- Resizing
local mode_resize = "Resize"
local mode_resize_toggle = "SUPER + R"
hl.bind(mode_resize_toggle, hl.dsp.submap(mode_resize))
hl.define_submap(mode_resize, function ()
    hl.bind("F", hl.dsp.window.float({ action = "toggle" }))

    local directions = { "Up", "Right", "Down", "Left", v.up, v.right, v.down, v.left }
    local dx = { 0, 1, 0, -1, 0, 1, 0, -1 }
    local dy = { -1, 0, 1, 0, -1, 0, 1, 0 }
    for i, direction in ipairs(directions) do
        -- Resize windows with arrow keys or vim keys
        hl.bind(direction,               hl.dsp.window.resize({ x = dx[i] * 10, y = dy[i] * 10 }), { repeating = true })
        hl.bind("SHIFT + " .. direction, hl.dsp.window.resize({ x = dx[i] * 50, y = dy[i] * 50 }), { repeating = true })

        hl.bind("CONTROL + " .. direction,         hl.dsp.window.resize({ x = dx[i] * 10, y = dy[i] * 10, relative = true }), { repeating = true })
        hl.bind("CONTROL + SHIFT + " .. direction, hl.dsp.window.resize({ x = dx[i] * 50, y = dy[i] * 50, relative = true }), { repeating = true })

        -- Move windows with arrow keys or vim keys
        hl.bind("SUPER + " .. direction,         hl.dsp.window.move({ x = dx[i] * 10, y = dy[i] * 10 }), { repeating = true })
        hl.bind("SUPER + SHIFT + " .. direction, hl.dsp.window.move({ x = dx[i] * 50, y = dy[i] * 50 }), { repeating = true })
    end
    
    hl.gesture({ fingers = 2, direction = "swipe", action = "move" })
    hl.gesture({ fingers = 3, direction = "swipe", action = "resize" })
    
    -- hl.bind(mode_resize_toggle, hl.dsp.submap(mode_reset))
    hl.bind("Escape",           hl.dsp.submap(mode_reset))
    hl.bind("Return",           hl.dsp.submap(mode_reset))
end)

-- System actions
local mode_system = "System (l)ock, (s)leep, (h)ibernate, (r)eboot, (Shift+s)hutdown"
local mode_system_toggle = "CONTROL + ALT + Delete"
hl.bind(mode_system_toggle, hl.dsp.submap(mode_system))
hl.define_submap(mode_system, function ()

    hl.bind("L", function ()
        hl.dispatch(hl.dsp.submap(mode_reset))
        hl.dispatch(hl.dsp.exec_cmd(v.lock))
    end)
    hl.bind("S", function ()
        hl.dispatch(hl.dsp.submap(mode_reset))
        hl.dispatch(hl.dsp.exec_cmd(v.lock))
        hl.dispatch(hl.dsp.exec_cmd("systemctl suspend"))
    end)
    hl.bind("H", function ()
        hl.dispatch(hl.dsp.submap(mode_reset))
        hl.dispatch(hl.dsp.exec_cmd(v.lock))
        hl.dispatch(hl.dsp.exec_cmd("systemctl hibernate"))
    end)
    hl.bind("R", function ()
        hl.dispatch(hl.dsp.submap(mode_reset))
        hl.dispatch(hl.dsp.exec_cmd("systemctl reboot"))
    end)
    hl.bind("SHIFT + S", function ()
        hl.dispatch(hl.dsp.submap(mode_reset))
        hl.dispatch(hl.dsp.exec_cmd("systemctl poweroff -i"))
    end)

    -- hl.bind(mode_system_toggle, hl.dsp.submap(mode_reset))
    hl.bind("Escape",           hl.dsp.submap(mode_reset))
    hl.bind("Return",           hl.dsp.submap(mode_reset))
end)

-- Launcher
local mode_launcher = "Launch (f)irefox, (n)otes or (t)hunderbird"
local mode_launcher_toggle = "SUPER + O"
hl.bind(mode_launcher_toggle, hl.dsp.submap(mode_launcher))
hl.define_submap(mode_launcher, mode_reset, function ()
    hl.bind("F", hl.dsp.exec_cmd("firefox"))
    hl.bind("N", hl.dsp.exec_cmd("logseq"))
    hl.bind("T", hl.dsp.exec_cmd("thunderbird"))

    --hl.bind(mode_launcher_toggle, hl.dsp.submap(mode_reset))
    hl.bind("Escape",             hl.dsp.submap(mode_reset))
    hl.bind("Return",             hl.dsp.submap(mode_reset))
end)

-- Preferences
local mode_preferences = "Toggle (d)ark mode, (n)otifications, (s)unset/nightlight"
local mode_preferences_toggle = "ALT + End"
hl.bind(mode_preferences_toggle, hl.dsp.submap(mode_preferences))
hl.bind("ALT + KP_End", hl.dsp.submap(mode_preferences))
hl.define_submap(mode_preferences, mode_reset, function ()
    hl.bind("D", hl.dsp.exec_cmd("${SCRIPT_DIR}/toggle-light-dark.sh"))
    hl.bind("N", hl.dsp.exec_cmd("${SCRIPT_DIR}/toggle-notifications.sh"))
    hl.bind("S", hl.dsp.exec_cmd("${SCRIPT_DIR}/toggle-nightlight.sh"))

    hl.bind("Escape",             hl.dsp.submap(mode_reset))
    hl.bind("Return",             hl.dsp.submap(mode_reset))
end)

-- Ignore (all) keybinds. Useful when working with Virtual Machines.
local mode_ignore = "Ignoring keybinds - Press Ctrl+Alt+Shift+Insert to escape."
local mode_ignore_toggle = "CONTROL + ALT + Insert"
hl.bind(mode_ignore_toggle, hl.dsp.submap(mode_ignore))
hl.define_submap(mode_ignore, function ()
    hl.bind("CONTROL + ALT + SHIFT + Insert", hl.dsp.submap(mode_reset))
end)

-- Screenshots
local mode_screenshot = "Screenshot of (a)rea, current (w)indow, (s)creen - Shift to save"
local mode_screenshot_toggle = "Print"
local screenshot_format = "~/Nextcloud/Afbeeldingen/Screenshots/$(date +%F-%H-%M-%S).png"
hl.bind(mode_screenshot_toggle, hl.dsp.submap(mode_screenshot))
hl.define_submap(mode_screenshot, mode_reset, function ()
    local function take_screenshot(target, action, interactive)
        local date_str = os.date("%F-%H-%M-%S")
        local save_dir = os.getenv("HOME") .. "/Nextcloud/Afbeeldingen/Screenshots/"
        local save_path
        if action == "save" then
            save_path = save_dir .. "/" .. date_str .. ".png"
        else
            save_path = "/tmp/screenshot_" .. date_str .. ".png"
        end

        local cmd = ""
        if target == "area" then
            cmd = cmd .. string.format('grim -g "$( slurp )" "%s"', save_path)
        
        elseif target == "window" then
            local window_geometry
            if interactive then
                --window_geometry = [[$(workspace_id="$(hyprctl activeworkspace -j | jq '.id')"; hyprctl clients -j | jq -r --argjson ws "${workspace_id}" '.[] | select(.workspace.id == $ws) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | slurp -d)]]
                window_geometry = [[$(ws="$(hyprctl activeworkspace -j | jq '.id')"; hyprctl clients -j | jq -r --argjson ws "$ws" '.[] | select(.workspace.id == $ws) | (.at[0]|tostring) + "," + (.at[1]|tostring) + " " + (.size[0]|tostring) + "x" + (.size[1]|tostring)' | slurp -d)]]
            else
                -- window_geometry = [[$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')]]
                window_geometry = [[$(hyprctl activewindow -j | jq -r '(.at[0]|tostring) + "," + (.at[1]|tostring) + " " + (.size[0]|tostring) + "x" + (.size[1]|tostring)')]]
            end
            cmd = cmd .. string.format('grim -g "%s" "%s"', window_geometry, save_path)
        
        elseif target == "screen" then
            local monitor_geometry
            if interactive then
                -- monitor_geometry = [[$(hyprctl monitors -j | jq -r '.[] | "\(.x),\(.y) \(.width)x\(.height)"' | slurp -d)]]
                monitor_geometry = [[$(hyprctl monitors -j | jq -r '.[] | (.x|tostring) + "," + (.y|tostring) + " " + (.width|tostring) + "x" + (.height|tostring)' | slurp -d)]]
                cmd = cmd .. string.format('grim -g "%s" "%s"', monitor_geometry, save_path)
            else
                -- monitor_geometry = [[$(workspace_id="$(hyprctl activeworkspace -j | jq '.id')"; hyprctl monitors -j | jq -r --argjson ws "${workspace_id}" '.[] | select(.activeWorkspace.id == $ws) | .name')]]
                monitor_geometry = [[$(ws="$(hyprctl activeworkspace -j | jq '.id')"; hyprctl monitors -j | jq -r --argjson ws "$ws" '.[] | select(.activeWorkspace.id == $ws) | .name')]]
                cmd = cmd .. string.format('grim -o "%s" "%s"', monitor_geometry, save_path)
            end

        elseif target == "all" then
            cmd = cmd .. string.format('grim "%s"', save_path)

        else
            --hl.error("Invalid screenshot target: " .. target)
            return
        end

        if action == "copy" then
            cmd = cmd .. string.format(' && wl-copy < "%s"', save_path)
        end

        local destination = (action == "copy") and "Copied to clipboard" or ("Saved to " .. save_path)
        cmd = cmd .. string.format(' && notify-send -a "Grim" -i "%s" "Screenshot Captured" "%s"', save_path, destination)

        hl.exec_cmd("sh -c '" .. cmd .. "'")
    end

    hl.bind("A", function() take_screenshot("area",   "copy", false) end)
    hl.bind("W", function() take_screenshot("window", "copy", false) end)
    hl.bind("S", function() take_screenshot("screen", "copy", false) end)
    hl.bind("A", function() take_screenshot("area",   "copy", true) end, { longpress = true })

    hl.bind("SHIFT + A", function() take_screenshot("area",   "save", false) end)
    hl.bind("SHIFT + W", function() take_screenshot("window", "save", false) end)
    hl.bind("SHIFT + S", function() take_screenshot("screen", "save", false) end)
    hl.bind("SHIFT + A", function() take_screenshot("area",   "save", true) end, { longpress = true })

    hl.bind("CONTROL + W", function() take_screenshot("window", "copy", true) end)
    hl.bind("CONTROL + S", function() take_screenshot("screen", "copy", true) end)

    hl.bind("CONTROL + SHIFT + W", function() take_screenshot("window", "save", true) end)
    hl.bind("CONTROL + SHIFT + S", function() take_screenshot("screen", "save", true) end)

    hl.bind("Escape",             hl.dsp.submap(mode_reset))
    hl.bind("Return",             hl.dsp.submap(mode_reset))
end)

