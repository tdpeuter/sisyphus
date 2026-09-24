-- i3/sway tiling layout plugin
-- https://github.com/outfoxxed/hy3

local v = require("variables")

local function configure_hy3()
    hl.config({
        general = {
            layout = "hy3",
        },

        plugin = {
            hy3 = {
                -- policy controlling what happens when a node is removed from a group,
                -- leaving only a group
                -- 0 = remove the nested group
                -- 1 = keep the nested group
                -- 2 = keep the nested group only if its parent is a tab group
                --node_collapse_policy = 2,

                -- offset from group split direction when only one window is in a group
                --group_inset = 10,

                -- if a tab group will automatically be created for the first window spawned in a workspace
                tab_first_window = false,

                -- tab group settings
                tabs = {
                    -- height of the tab bar
                    height = 10,

                    -- padding between the tab bar and its focused node
                    padding = 0,

                    -- the tab bar should animate in/out from the top instead of below the window
                    --from_top = false,

                    -- radius of tab bar corners
                    radius = 0,

                    -- tab bar border width
                    --border_width = 2,

                    -- render the window title on the bar
                    render_text = false,

                    -- center the window title
                    --text_center : true,

                    -- font to render the window title with
                    --text_font = Sans,

                    -- height of the window title
                    --text_height = 8,

                    -- left padding of the window title
                    --text_padding = 3,

                    colors = {
                        -- active tab bar segment colors
                        --active =        "rgba(33ccff40)",
                        --active_border = "rgba(33ccffee)",
                        --active_text =   "rgba(ffffffff)",

                        -- active tab bar segment colors for bars on an unfocused monitor
                        --active_alt_monitor =        "rgba(60606040)",
                        --active_alt_monitor_border = "rgba(808080ee)",
                        --active_alt_monitor_text =   "rgba(ffffffff)",

                        -- focused tab bar segment colors (focused node in unfocused container)
                        --focused =        "rgba(60606040)",
                        --focused_border = "rgba(808080ee)",
                        --focused_text =   "rgba(ffffffff)",

                        -- inactive tab bar segment colors
                        inactive =        "rgba(a6a6a620)", -- default: "rgba(30303020)"
                        inactive_border = "rgba(a6a6a620)", -- default: "rgba(606060aa)"
                        --inactive_text = "rgba(ffffffff)",

                        -- urgent tab bar segment colors
                        --urgent =        "rgba(ff223340)",
                        --urgent_border = "rgba(ff2233ee)",
                        --urgent_text =   "rgba(ffffffff)",

                        -- locked tab bar segment colors
                        --locked =        "rgba(90903340)",
                        --locked_border = "rgba(909033ee)",
                        --locked_text =   "rgba(ffffffff)",
                    },

                    -- if tab backgrounds should be blurred
                    -- Blur is only visible when the above colors are not opaque.
                    --blur = true,

                    -- opacity multiplier for tabs
                    -- Applies to blur as well as the given colors.
                    --opacity = 1.0,
                },

                -- autotiling settings
                autotile = {
                    -- enable autotile
                    enable = false,

                    -- make autotile-created groups ephemeral
                    --ephemeral_groups = true,

                    -- if a window would be squished smaller than this width, a vertical split will be created
                    -- -1 = never automatically split vertically
                    -- 0 = always automatically split vertically
                    -- <number> = pixel width to split at
                    --trigger_width = 0,

                    -- if a window would be squished smaller than this height, a horizontal split will be created
                    -- -1 = never automatically split horizontally
                    -- 0 = always automatically split horizontally
                    -- <number> = pixel height to split at
                    --trigger_height = 0,

                    -- a space or comma separated list of workspace ids where autotile should be enabled
                    -- it's possible to create an exception rule by prefixing the definition with "not:"
                    --workspaces = "1,2", -- autotiling will only be enabled on workspaces 1 and 2
                    --workspaces = "not:1,2", -- autotiling will be enabled on all workspaces except 1 and 2
                    --workspaces = "all", -- default
                },
            },
        },
    })
end

local function unbind_defaults()
    -- Navigation

    -- Focus
    for _, direction in ipairs({ "Up", "Right", "Down", "Left", v.up, v.right, v.down, v.left }) do
        -- Focus
        pcall(hl.unbind, "SUPER + " .. direction)
        -- Move windows
        pcall(hl.unbind, "SUPER + SHIFT + " .. direction)
    end

    -- Layouts

    -- Workspaces

    for i = 1, #v.ws.ids do
        -- Move window to a specific workspace
        pcall(hl.unbind, "SUPER + SHIFT + " .. v.ws.keys[i])
    end
end

local function bind_hy3(hy3)
    -- Navigation

    -- Focus
    hl.bind("SUPER + Up",          hy3.move_focus("up"))
    hl.bind("SUPER + Right",       hy3.move_focus("right"))
    hl.bind("SUPER + Down",        hy3.move_focus("down"))
    hl.bind("SUPER + Left",        hy3.move_focus("left"))

    hl.bind("SUPER + " .. v.up,    hy3.move_focus("up"))
    hl.bind("SUPER + " .. v.right, hy3.move_focus("right"))
    hl.bind("SUPER + " .. v.down,  hy3.move_focus("down"))
    hl.bind("SUPER + " .. v.left,  hy3.move_focus("left"))

    -- Move windows
    hl.bind("SUPER + SHIFT + Up",          hy3.move_window("up"))
    hl.bind("SUPER + SHIFT + Right",       hy3.move_window("right"))
    hl.bind("SUPER + SHIFT + Down",        hy3.move_window("down"))
    hl.bind("SUPER + SHIFT + Left",        hy3.move_window("left"))

    hl.bind("SUPER + SHIFT + " .. v.up,    hy3.move_window("up"))
    hl.bind("SUPER + SHIFT + " .. v.right, hy3.move_window("right"))
    hl.bind("SUPER + SHIFT + " .. v.down,  hy3.move_window("down"))
    hl.bind("SUPER + SHIFT + " .. v.left,  hy3.move_window("left"))

    -- Layout

    hl.bind("SUPER + Z", hy3.equalize(), { long_press = true })
    hl.bind("SUPER + Z", hy3.change_group("opposite"))
    hl.bind("SUPER + X", hy3.change_group("tab"))
    hl.bind("SUPER + C", hy3.change_group("h"))
    hl.bind("SUPER + V", hy3.change_group("v"))

    hl.bind("SUPER + P",         hy3.change_focus("raise"))
    hl.bind("SUPER + SHIFT + P", hy3.change_focus("lower"))
    hl.bind("SUPER + Space",     hy3.toggle_focus_layer())

    -- Workspaces

    for i = 1, #v.ws.ids do
        hl.bind("SUPER + SHIFT + " .. v.ws.keys[i], hy3.move_to_workspace(v.ws.ids[i], { follow = true }))
    end

    -- Shortcuts

    hl.bind("SUPER + CONTROL + Q", hy3.kill_active())
end

local attempt = 0
local max_attempts = 5000

local check_hy3_status
check_hy3_status = hl.timer(function ()
    attempt = attempt + 1

    if hl.plugin and hl.plugin.hy3 then
        local success, err = pcall(function()
            unbind_defaults()
            configure_hy3()
            bind_hy3(hl.plugin.hy3)
        end)
 
        if success then
            check_hy3_status:set_enabled(false)
        end
    end

    if attempt >= max_attempts then
        hl.notification.create({ text = "[hy3] Plugin failed to load after " .. max_attempts .. " attempts", duration = 5000 })
        check_hy3_status:set_enabled(false)
    end
end, { timeout = 5000, type = "repeat" })

check_hy3_status:set_enabled(true)

