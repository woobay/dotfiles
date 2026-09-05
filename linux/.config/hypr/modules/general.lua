hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 8,
        border_size = 1,
        -- https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,
        -- Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false,
        layout = "dwindle",
        col = {
            active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
    },
})

hl.config({
    decoration = {
        rounding = 1,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
        },
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})


hl.config({
    misc = {
        force_default_wallpaper = -1,
        -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = false,
        -- If true disables the random hyprland logo / anime girl background. :(
    },
})
