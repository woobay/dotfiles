hl.workspace_rule({
    workspace = 1,
    monitor = "DP-1",
    default = true,
})

hl.workspace_rule({
    workspace = 2,
    monitor = "DP-1",
})

hl.workspace_rule({
    workspace = 3,
    monitor = "DP-1",
})

hl.workspace_rule({
    workspace = 4,
    monitor = "DP-1",
})

hl.workspace_rule({
    workspace = 5,
    monitor = "DP-1",
})

hl.workspace_rule({
    workspace = 6,
    monitor = "DP-2",
    default = true,
})

hl.workspace_rule({
    workspace = 7,
    monitor = "DP-2",
})

hl.workspace_rule({
    workspace = 8,
    monitor = "DP-2",
})

hl.workspace_rule({
    workspace = 9,
    monitor = "DP-2",
})

hl.workspace_rule({
    workspace = 10,
    monitor = "DP-2",
})


hl.window_rule({
    name  = "windowrule-1",
    match = {
        class = "^(gamescope)$",
    },
    tag = "+games",
})

hl.window_rule({
    name  = "windowrule-2",
    match = {
        class = "^(steam_proton)$",
    },
    tag = "+games",
})

hl.window_rule({
    name  = "windowrule-3",
    match = {
        title = "^(Minecraft.*)$",
    },
    tag = "+games",
})

hl.window_rule({
    name  = "windowrule-4",
    match = {
        class = "^(steam_app_\\d+)$",
    },
    tag = "+games",
})

hl.window_rule({
    name  = "windowrule-5",
    match = {
        tag = "games*",
    },
    workspace = 5,
    no_blur = true,
    fullscreen = true,
})



hl.window_rule({
    name  = "zen-noblur",
    match = {
        class = "^(zen)$",
    },
    no_blur = true,
    pin = true,
})

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})
