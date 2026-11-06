-- Hyprland Configuration
--
-- Converted from hyprland.conf (hyprlang) to the Lua config format.
-- Docs: https://wiki.hypr.land/configuring/core/

-- ==================
-- MONITOR CONFIG
-- ==================

require("dms.outputs")

local workspace_monitors = {
    ["HDMI-A-1"] = { 1, 2, 3 },
    ["DP-1"]     = { 4, 5, 6, 7 },
    ["HDMI-A-2"] = { 8, 9, 10 },
}

for monitor, workspaces in pairs(workspace_monitors) do
    for _, ws in ipairs(workspaces) do
        hl.workspace_rule({ workspace = tostring(ws), monitor = monitor })
    end
end

-- ==================
-- ENVIRONMENT VARS
-- ==================
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")
hl.env("QT_QPA_PLATFORMTHEME_QT6", "gtk3")

-- ==================
-- NVIDIA CONFIG
-- ==================
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("__GL_VRR_ALLOWED", "1")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("WLR_DRM_NO_ATOMIC", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("NVD_BACKEND", "direct")

-- ==================
-- STARTUP APPS
-- ==================
hl.on("hyprland.start", function()
    hl.exec_cmd("wl-paste --watch cliphist store &")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("udiskie --no-automount --smart-tray")
end)

-- ==================
-- INPUT CONFIG
-- ==================
hl.config({
    input = {
        kb_layout          = "us",
        numlock_by_default = true,
        accel_profile      = "flat",
    },
})

-- ==================
-- GENERAL LAYOUT
-- ==================
hl.config({
    general = {
        gaps_in     = 5,
        gaps_out    = 5,
        border_size = 0, -- off in niri

        col = {
            active_border   = "rgba(707070ff)",
            inactive_border = "rgba(d0d0d0ff)",
        },

        layout = "dwindle",
    },
})

-- ==================
-- DECORATION
-- ==================
hl.config({
    decoration = {
        rounding = 12,

        active_opacity   = 0.95,
        inactive_opacity = 0.90,

        shadow = {
            enabled      = true,
            range        = 30,
            render_power = 4,
            offset       = { 0, 5 },
            color        = "rgba(00000070)",
        },
    },
})

-- ==================
-- ANIMATIONS
-- ==================
hl.config({ animations = { enabled = true } })

hl.animation({ leaf = "windowsIn",   enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "border",      enabled = true, speed = 3, bezier = "default" })

-- ==================
-- LAYOUTS
-- ==================
hl.config({
    dwindle = {
        preserve_split = true,
    },

    master = {
        mfact = 0.5,
    },
})

-- ==================
-- MISC
-- ==================
hl.config({
    misc = {
        disable_hyprland_logo   = true,
        disable_splash_rendering = true,
        vrr                     = 1,
    },
})

-- ==================
-- WINDOW RULES
-- ==================

-- === Opacity ===
hl.window_rule({ match = { class = "^(Cursor|cursor)$" }, opacity = "0.92 0.90" })
hl.window_rule({ match = { class = "^(code)$" },          opacity = "0.92 0.90" })
hl.window_rule({ match = { class = "^(Spotify)$" },       opacity = "0.90 0.85" })
hl.window_rule({ match = { class = "^(kitty)$" },         opacity = "0.90 0.85" })

-- === Float Or Tiled Windows ===
local function float_centered(class, w, h)
    hl.window_rule({
        match  = { class = class },
        float  = true,
        size   = { w, h },
        center = true,
    })
end

float_centered([[^(org\.pulseaudio\.pavucontrol)$]],            1200, 600)
float_centered([[^(gnome-calculator)$]],                         350, 550)
float_centered([[^(blueman-manager)$]],                          500, 600)
float_centered([[^(xdg-desktop-portal|xdg-desktop-portal-gtk)$]], 1200, 600)
float_centered([[^(org\.gnome\.Nautilus)$]],                     850, 500)
float_centered([[^(org\.quickshell)$]],                          950, 900)

hl.layer_rule({ match = { namespace = "^(quickshell)$" }, no_anim = true })

require("dms.cursor")
require("dms.layout")
require("dms.binds")
require("dms.binds-user")