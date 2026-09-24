hl.config({
    input = {
        --kb_model = [[Empty]],
        kb_layout = "us,be,us",
        kb_variant = "altgr-intl,iso-alternate,dvorak",
        --kb_options = [[Empty]],
        --kb_rules = [[Empty]],
        --kb_file = [[Empty]],

        numlock_by_default = true,
        resolve_binds_by_sym = false,

        repeat_rate = 25,
        repeat_delay = 600,

        sensitivity = 0.0,
        accel_profile = "flat",
        force_no_accel = false,

        --rotation = 0,
        left_handed = false,
        --scroll_points = [[Empty]],
        scroll_method = "2fg",
        scroll_button = 0, -- 0 means default
        scroll_button_lock = true,
        scroll_factor = 1.0,
        natural_scroll = false,

        follow_mouse = 2,
        --follow_mouse_shrink = 0,
        --follow_mouse_threshold = 0.0,
        focus_on_close = 0,
        mouse_refocus = true,
        float_switch_override_focus = 1,
        special_fallthrough = false,
        off_window_axis_events = 1,
        emulate_discrete_scroll = 1,

        touchpad = {
            disable_while_typing = true,
            natural_scroll = true,
            scroll_factor = 0.8,
            middle_button_emulation = false,
            tap_button_map = "lrm",
            clickfinger_behavior = false,
            tap_to_click = true,
            drag_lock = 0, -- false
            tap_and_drag = true,

            --flip_x = false,
            --flip_y = false,
            --drag_3fg = 0,
        },

        touchdevice = {
            --transform = -1,
            --output = [[Auto]],
            --enabled = true,
        },

        virtualkeyboard = {
            --share_states = 2,
            --release_pressed_on_close = false,
        },

        tablet = {
            --transform = -1,
            --output = [[Empty]],
            --region_position = {0, 0},
            --absolute_region_position = false,
            --region_size = {0, 0},
            --relative_input = false,
            --left_handed = false,
            --active_area_size = {0, 0},
            --active_area_position = {0, 0},
        },

        tablettool = {
            --eraser_button_mode = 0,
            --eraser_button_override = 0,
            --pressure_range_min = -1.0,
            --pressure_range_max = 1.0,
        },
    },

    gestures = {
        workspace_swipe_distance = 300,
        workspace_swipe_touch = false,
        workspace_swipe_invert = true,
        workspace_swipe_touch_invert = false,
        workspace_swipe_min_speed_to_force = 30,
        workspace_swipe_cancel_ratio = 0.2,
        workspace_swipe_create_new = false,
        workspace_swipe_direction_lock = true,
        workspace_swipe_direction_lock_threshold = 10,
        workspace_swipe_forever = true,
        workspace_swipe_use_r = false,
        
        --close_max_timeout = 1000,
    },
})

-- Disable numlock by default on laptop keyboard
hl.device({ name = "at-translated-set-2-keyboard", numlock_by_default = false })

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
hl.monitor({ output = "desc:BOE 0x08CF", mode = "preferred", position = "640x1440", scale = 1 })
hl.monitor({ output = "desc:Hewlett Packard HP ZR2740w CNT319Y008", mode = "preferred", position = "auto-up", scale = 1 })
hl.monitor({ output = "desc:Dell Inc. DELL P2214H 29C2937M4YTL", mode = "preferred", position = "auto-right", scale = 1, transform = 1 })
hl.monitor({ output = "desc:Samsung Electric Company S22C650", mode = "preferred", position = "auto-right", scale = 1, transform = 1 })
hl.monitor({ output = "desc:Samsung Electric Company SAMSUNG", disabled = true })

hl.bind("switch:on:Lid Switch", function()
    hl.notification.create({ text = "Lid closed — disabling eDP-1", timeout = 2500 })
    hl.monitor({ output = "eDP-1", disabled = true })
end, { locked = true })

hl.bind("switch:off:Lid Switch", function()
    hl.notification.create({ text = "Lid opened — enabling eDP-1", timeout = 2500 })
    hl.monitor({ output = "eDP-1", disabled = false })
end, { locked = true })

