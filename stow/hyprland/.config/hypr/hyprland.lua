-- ~/.config/hypr/hyprland.lua
-- Syntax/options last reviewed on 0.55.2

hl.config({
    general = {
        border_size = 1,
        gaps_in = 3,
        gaps_out = 5,
        --float_gaps = -1,
        gaps_workspaces = 0,

        col = {
            inactive_border = "#ff444444",
            active_border = "#ffffffff",
            nogroup_border = "#ffff00ff",
            --nogroup_border_active = "",
        },
        
        layout = "dwindle",

        no_focus_fallback = true,

        resize_on_border = true,
        extend_border_grab_area = 5,
        hover_icon_on_border = true,

        allow_tearing = false,

        resize_corner = 0,

        --modal_parent_blocking = true,
        --locale = [[Empty]],
        
        snap = {
            enabled = false,
            --window_gap = 10,
            --monitor_gap = 10,
            --border_overlap = false,
            --respect_gaps = false,
        },
    },

    group = {
        auto_group = true,
        insert_after_current = true,
        focus_removed_window = true,
        drag_into_group = 1,
        merge_groups_on_drag = true,
        merge_groups_on_groupbar = true,
        merge_floated_into_tiled_on_groupbar = false,
        group_on_movetoworkspace = false,

        col = {
            border_active = "#66ffff00",
            border_inactive = "#66777700",
            border_locked_active = "#66ff5500",
            border_locked_inactive = "#66775500",
        },

        groupbar = {
            enabled = true,

            --font_family = misc.font_family,
            --font_size = 8,
            --font_weight_active = "normal",
            --font_weight_inactive = "normal",

            gradients = true,
            --height = 14,
            --indicator_gap = 0,
            --indicator_height = 3,
            --stacked = false,
            --priority = 3,
            render_titles = false,
            --text_offset = 0,
            --text_padding = 0,

            scrolling = true,
            --rounding = 1,
            --rounding_power = 4.0, -- squircle
            --gradient_rounding = 2,
            --gradient_rounding_power = 4.0, -- squircle
            --round_only_edges = true,
            --gradient_round_only_edges = true,

            text_color = "#ffffffff",
            --text_color_inactive = unset,
            --text_color_locked_active = unset,
            --text_color_locked_inactive = unset,

            col = {
                active = "#66ffff00",
                inactive = "#66777700",
                locked_active = "#66ff5500",
                locked_inactive = "#66775500",
            },

            --gaps_in = 2,
            --gaps_out = 2,
            --keep_upper_gap = true,
            --middle_click_close = true,
            --blur = false,
        },
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        --disable_scale_notification = false,

        col = {
            splash = "#ffffffff",
        },
        font_family = "Letter",
        --spash_font_family = [[Empty]],
        --force_default_wallpaper = -1,

        vrr = 1, -- on
        mouse_move_enables_dpms = false,
        key_press_enables_dpms = true,
        --name_vk_after_proc = true,
        --always_follow_on_dnd = true,
        --layers_hog_keyboard_focus = true,
        --animate_manual_resizes = false,
        --animate_mouse_windowdragging = false,
        disable_autoreload = true,
        --enable_swallow = false,
        --swallow_regex = [[Empty]],
        --swallow_exception_regex = [[Empty]],
        focus_on_activate = true,
        mouse_move_focuses_monitor = true,

        --allow_session_lock_restore = false,
        --session_lock_xray = false,

        background_color = "#018281",
        --close_special_on_empty = true,
        --on_focus_under_fullscreen = 2, -- unfullscreen/unmaximize
        --exit_window_retains_fullscreen = false,
        --initial_workspace_tracking = 1, -- single-shot
        middle_click_paste = false,
        render_unfocused_fps = 12,
        --disable_xdg_env_checks = false,
        --disable_hyprland_qutils_check = false,
        --lockdead_screen_delay = 1000,
        --enable_anr_dialog = true,
        --anr_missed_pings = 5,
        --size_limits_tiled = false,
        --disable_watchdog_warning = false,
    },

    layout = {
        --single_window_aspect_ratio = {0, 0},
        --single_window_aspect_ratio_tolerance = 0.1,
    },

    binds = {
        --pass_mouse_when_bound = false,
        --scroll_event_delay = 300,
        workspace_back_and_forth = false,
        --hide_special_on_workspace_change = false,
        --allow_workspace_cycles = false,
        workspace_center_on = 1, -- last active window for that workspace
        focus_preferred_method = 0,
        --ignore_group_lock = false,
        --movefocus_cycles_fullscreen = false,
        --movefocus_cycles_groupfirst = false,
        window_direction_monitor_fallback = true,
        disable_keybind_grabbing = false,
        --allow_pin_fullscreen = false,
        drag_threshold = 10,
    },

    xwayland = {
        enabled = true,
        --use_nearest_neighbor = true,
        --force_zero_scaling = false,
        --create_abstract_socket = false,
    },

    opengl = {
        nvidia_anti_flicker = false,
    },

    render = {
        --direct_scanout = 0, -- off
        --expand_undersized_textures, = true
        --xp_mode = false,
        --ctm_animation = 2, -- auto
        --cm_enabled = true,
        --send_content_type = true,
        --cm_auto_hdr = 1, -- cm, hdr
        --new_render_scheduling = false,
        --non_shader_cm = 2, -- DS and passthrough only
        --non_shader_cm_interop = 2, -- external ctm is disabled for fullscreen photo/video/game content types
        --cm_sdr_eotf = "default",
        --commit_timing_enabled = true,
        --use_fp16 = 2, -- enabled in hdr mode
        --keep_unmodified_copy = 2, -- auto
        --use_shader_blur_blend = false,
    },

    cursor = {
        --invisible = false,
        sync_gsettings_theme = true,
        --no_hardware_cursors = 2, -- auto
        --no_break_fs_vvr = 2, -- auto
        --min_refresh_rate = 24,
        --hotspot_padding = 1,
        inactive_timeout = 10,
        no_warps = false,
        persistent_warps = false,
        warp_on_change_workspace = 1, -- enabled
        warp_on_toggle_special = 1, -- enabled
        --default_monitor = [[Empty]],
        --zoom_factor = 1.0,
        --zoom_rigid = false,
        --zoom_detached_camera = true,
        --enable_hyprcursor = true,
        hide_on_key_press = true,
        hide_on_touch = true,
        hide_on_tablet = true,
        --use_cpu_buffer = 2,
        --warp_back_after_non_mouse_input = false,
        --zoom_disable_aa = false,
    },

    ecosystem = {
        --no_update_news = false,
        --no_donation_nag = false,
        --enforce_permission = false,
    },

    --quirks.prefer_hdr = 0, -- off
})

hl.on("hyprland.start", function()
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
    hl.exec_cmd("dunst --verbosity crit")
    hl.exec_cmd("waycorner")
    hl.exec_cmd("waybar")

    -- TODO Replace with something else?
    hl.exec_cmd("wlsunset -t 2500 -l 50.51 -L 4.21")

    hl.exec_cmd("nextcloud --background")

    -- Turn volume off at boot
    hl.exec_cmd("for i in $(seq 1 10); do pactl set-sink-mute @DEFAULT_SINK@ 1 && break; sleep 1; done")
end)

-- STYLING
hl.on("hyprland.start", function()
    hl.exec_cmd("swaybg -i \"${HOME}/.local/state/sisyphus/bg\" --mode=fill")
end)
hl.env("XCURSOR_SIZE", "24")

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/#nvidia-specific
hl.env("GBM_BACKEND", "nivida-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("LIBVA_DRIVER_NAME", "nvidia") -- Hardware acceleration on NVIDIA GPUs

require("decoration_animations")
require("input-output")
require("keybinds")
require("modes")

pcall(require, "hy3-plugin") -- Sway tiling plugin
require("hy3") -- hy3 config. Since hy3.lua uses timers, it should NOT be required in "hyprland.start"!

