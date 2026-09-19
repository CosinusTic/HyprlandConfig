-- ~/.config/hypr/hyprland.lua

------------------
---- MONITORS ----
------------------
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    --scale    = "auto",
    scale    = 1,
})

---------------------
---- MY PROGRAMS ----
---------------------
local terminal = "alacritty"
local browser  = "firefox"        -- change to chromium / brave / zen, etc.
local menu = "wofi --show drun"      -- pacman -S wofi

-------------------
---- AUTOSTART ----
-------------------
-- Runs once at session start, NOT on every config reload.
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hypridle")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in     = 4,
        gaps_out    = 8,
        border_size = 2,
--        col = {
--            active_border   = "rgba(33ccffee)",
--            inactive_border = "rgba(595959aa)",
--        },
        resize_on_border = true,

        -- THIS is what gives you the i3-ish "big window left, stack right" tiling
        layout = "master",
    },

    decoration = {
        rounding = 1,
        blur   = { enabled = false },
        shadow = { enabled = false },
    },

    animations = {
        enabled = false,
    },

    input = {
        kb_layout    = "us",   -- set "fr" if you are on an AZERTY keyboard
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = {
            natural_scroll = true,
        },
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})

--------------------------
---- MASTER LAYOUT    ----
--------------------------
-- Target geometry with 3 windows:
--   +-----------------------+
--   |            |   WIN 2  |
--   +   WIN 1    +----------+
--   |            |   WIN 3  |
--   +-----------------------+
--
-- new_status = "slave"  -> new windows are appended to the right-hand stack,
--                          the first window stays master on the left.
-- orientation = "left"  -> master column is on the left.
-- mfact                 -> share of the screen taken by the master column.
hl.config({
    master = {
        orientation           = "left",
        mfact                 = 0.20,
        new_status            = "slave",
        new_on_top            = false,
        smart_resizing        = true,
    },
})

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"

-- Launchers
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal), { description = "Terminal" })
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd(browser),  { description = "Browser" })
hl.bind(mainMod .. " + D",      hl.dsp.exec_cmd(menu),     { description = "App launcher" })

-- Window management (i3-ish)
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + Q",         hl.dsp.window.close())
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())

-- Screen lock
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- Screenshots
--hl.bind(
--    mainMod .. " + Print",
--    hl.dsp.exec_cmd("grim -g \"$(slurp)\" ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"),
--    { description = "Screenshot area" }
--)

hl.bind(
    mainMod .. " + Print",
    hl.dsp.exec_cmd(
        "file=\"$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png\"; " ..
        "grim -g \"$(slurp)\" \"$file\"; " ..
        "wl-copy < \"$file\""
    ),
    { description = "Screenshot area (save + clipboard)" }
)




-- Focus windows inside the current workspace with SUPER + arrows.
-- left/right jumps between the master column and the stack,
-- up/down moves inside the stack.
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left"  }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up"    }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down"  }))

-- Same, vim-style
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left"  }))
--hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up"    }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down"  }))

-- Cycle through windows of the workspace regardless of geometry
hl.bind(mainMod .. " + Tab",         hl.dsp.layout("cyclenext"))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.layout("cycleprev"))

-- Promote the focused window to master (like i3's "swap with the big one")
hl.bind(mainMod .. " + M", hl.dsp.layout("swapwithmaster master"))

-- Move windows around
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left"  }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up"    }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down"  }))

-- Resize the master column
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.layout("mfact -0.02"), { repeating = true })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.layout("mfact +0.02"), { repeating = true })

-- Workspaces: SUPER + [1-9] to switch, SUPER + SHIFT + [1-9] to send window
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i,           hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i,   hl.dsp.window.move({ workspace = i }))
end
-- Workspace 10 on the 0 key
hl.bind(mainMod .. " + 0",         hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Scratchpad
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

--------------------
---- WINDOWRULES ----
--------------------
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})
