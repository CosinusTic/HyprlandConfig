# Hyprland config

Simplified hyprland config, based on these files:
```
.
├── hypr/
│   ├── hyprland.lua
│   ├── hypridle.conf
│   └── hyprlock.conf
│
└── waybar/
    ├── config.jsonc
    └── style.css
```

## Requirements
```text
hyprland                                # Window manager
wayland                                 # Display backend
waybar                                  # status bar
hypridle                                # idle detection and locking
hyprlock                                # Screen locker
hyprpaper                               # ?
wl_clipboard                            # clipboard manager (used by screenshot tool)
grim                                    # Wayland screenshots
slurp                                   # Interactive screenshot selection (square selection)
wofi                                    # App menu (wayland CTRL+D)
wireplumber, pipewire, pipewire-pulse   # audio
pavucontrol                             # audio
brightnessctl                           # Adjust brightness
networkmanager, networkmanager-dmenu    # Network management 
```

Optional:
```text
firefox                 # Can change in config
alacritty               # TTY emulator, can change in config
JetBrainsMono Nerd Font # Font
```

Drop in command:
```bash
sudo pacman -S \
    hyprland \
    waybar \
    hypridle \
    hyprlock \
    hyprpaper \
    alacritty \
    firefox \
    wofi \
    brightnessctl \
    grim \
    slurp \
    wl-clipboard \
    pipewire \
    pipewire-pulse \
    wireplumber \
    pavucontrol \
    networkmanager

```

## Installation
#TODO: write install script (deps + file locs)
