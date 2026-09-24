-- Decorations and animations

hl.config({
    decoration = {
        rounding = 0,
        --rounding_power = 4.0,
        
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,
        dim_modal = false,
        dim_inactive = false,
        --dim_strength = 0.5,
        --dim_special = 0.2,
        --dim_around = 0.4,

        --screen_shader = [[Empty]],
        --border_part_of_window = true,
        
        blur = {
            enabled = true,

            size = 8,
            passes = 1,
            ignore_opacity = true,
            new_optimizations = true,
            xray = true,
            noise = 0.01,
            contrast = 0.8,
            brightness = 0.8,
            vibrancy = 0.0,
            vibrancy_darkness = 0.0,

            special = false,
            popups = false,
            --popups_ignorealpha = 0.2,
            input_methods = false,
            --input_methods_ignorealpha = 0.2,
        },

        shadow = {
            enabled = false,

            --range = 4,
            --render_power = 3,
            --sharp = false,
            --color = "#ee1a1a1a",
            --color_inactive = unset,
            --offset = {0, 0},
            --scale = 1.0,
        },

        glow = {
            enabled = false,
            --range = 10,
            --render_power = 3,
            --color = "#ee1a1a1a",
            --color_inactive = unset,
        },

        motion_blur = {
            --enabled = false,
            --samples = 7,
        },
    },

    animations = {
        enabled = false,
        --workspace_wraparound = false,
    },
})

