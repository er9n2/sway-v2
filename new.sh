#!/usr/bin/env bash

sudo pacman -S sway foot rofi-wayland pipewire pipewire-pulse wireplumber libpulse brightnessctl swaybg i3status xorg-xwayland ttf-space-mono-nerd autotiling
sudo pacman -S --needed base-devel git && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
mkdir -p ~/.local/share/applications && for app in avahi-discover bssh bvnc qv4l2 qvidcap foot foot-server footclient rofi rofi-theme-selector; do [ -f /usr/share/applications/"$app".desktop ] && cp /usr/share/applications/"$app".desktop ~/.local/share/applications/ && echo "NoDisplay=true" >> ~/.local/share/applications/"$app".desktop; done

# 1. Create the destination directory if it doesn't exist
mkdir -p "$HOME/.config/rofi"

# 2. Write the config directly into config.rasi (overwrites if it already exists)
cat << 'ROFI_CONFIG' > "$HOME/.config/rofi/config.rasi"
configuration {
    modi: "drun,run,window";
    icon-theme: "Papirus";
    show-icons: true;
    terminal: "alacritty";
    drun-display-format: "{name}";
    disable-history: false;
    hide-scrollbar: true;
    display-drun: "   Apps ";
    display-run: "   Run ";
    display-window: " 󰕰  Window";
    sidebar-mode: true;

    /* --- Navigation --- */
    kb-mode-next: "Control+N";
    kb-mode-previous: "Control+B";
    kb-move-char-back: "Left";
    kb-move-char-forward: "Right";
}

@theme "/dev/null"

* {
    /* Translucent dark background matching macOS Launchpad blur */
    bg-col:          #000000CC;
    selected-col:    #ffffff22;
    accent-white:    #ffffff;
    fg-col:          #eeeeee;
    grey:            #a0a0a0;

    font: "JetBrainsMono Nerd Font 11";
}

window {
    fullscreen: true;
    transparency: "real";
    background-color: @bg-col;
    padding: 60px 100px;
}

mainbox {
    background-color: transparent;
    children: [ inputbar, listview, mode-switcher ];
    spacing: 30px;
}

/* --- Centered Launchpad Search Bar --- */
inputbar {
    background-color: #ffffff1a;
    border-radius: 10px;
    padding: 8px 16px;
    margin: 0px 30%;
    children: [ prompt, entry ];
}

prompt {
    background-color: transparent;
    padding: 4px;
    text-color: @accent-white;
}

entry {
    padding: 4px;
    text-color: @fg-col;
    background-color: transparent;
    placeholder: "Search...";
    placeholder-color: @grey;
}

/* --- Launchpad Grid Layout --- */
listview {
    background-color: transparent;
    columns: 6;
    lines: 4;
    spacing: 30px;
    cycle: true;
    dynamic: true;
    fixed-columns: true;
    flow: horizontal; /* Lays items out left-to-right across rows */
}

element {
    background-color: transparent;
    text-color: @fg-col;
    border-radius: 18px;
    padding: 16px 8px;
    orientation: vertical;
}

element-icon {
    size: 72px;
    horizontal-align: 0.5;
    background-color: transparent;
}

element-text {
    horizontal-align: 0.5;
    vertical-align: 0.5;
    background-color: transparent;
    text-color: inherit;
    margin: 8px 0px 0px 0px;
}

element selected {
    background-color: @selected-col;
    text-color: @accent-white;
}

/* --- Bottom Mode Switcher --- */
mode-switcher {
    background-color: transparent;
    margin: 0px 35%;
    spacing: 10px;
}

button {
    padding: 8px 16px;
    background-color: transparent;
    text-color: @grey;
    border-radius: 8px;
}

button selected {
    background-color: #ffffff20;
    text-color: @accent-white;
}
ROFI_CONFIG

echo "Rofi configuration created successfully at $HOME/.config/rofi/config.rasi"

echo Step 2 Writing Sway Configuration

#!/usr/bin/env bash

# 1. Create the destination directory if it doesn't exist
mkdir -p "$HOME/.config/rofi"

# 2. Write the config directly into config.rasi (overwrites if it already exists)
cat << 'ROFI_CONFIG' > "$HOME/.config/rofi/config.rasi"
configuration {
    modi: "drun,run,window";
    icon-theme: "Papirus";
    show-icons: true;
    terminal: "alacritty";
    drun-display-format: "{name}";
    disable-history: false;
    hide-scrollbar: true;
    display-drun: "   Apps ";
    display-run: "   Run ";
    display-window: " 󰕰  Window";
    sidebar-mode: true;

    /* --- Navigation --- */
    kb-mode-next: "Control+N";
    kb-mode-previous: "Control+B";
    kb-move-char-back: "Left";
    kb-move-char-forward: "Right";
}

@theme "/dev/null"

* {
    /* Translucent dark background matching macOS Launchpad blur */
    bg-col:          #000000CC;
    selected-col:    #ffffff22;
    accent-white:    #ffffff;
    fg-col:          #eeeeee;
    grey:            #a0a0a0;

    font: "JetBrainsMono Nerd Font 11";
}

window {
    fullscreen: true;
    transparency: "real";
    background-color: @bg-col;
    padding: 60px 100px;
}

mainbox {
    background-color: transparent;
    children: [ inputbar, listview, mode-switcher ];
    spacing: 30px;
}

/* --- Centered Launchpad Search Bar --- */
inputbar {
    background-color: #ffffff1a;
    border-radius: 10px;
    padding: 8px 16px;
    margin: 0px 30%;
    children: [ prompt, entry ];
}

prompt {
    background-color: transparent;
    padding: 4px;
    text-color: @accent-white;
}

entry {
    padding: 4px;
    text-color: @fg-col;
    background-color: transparent;
    placeholder: "Search...";
    placeholder-color: @grey;
}

/* --- Launchpad Grid Layout --- */
listview {
    background-color: transparent;
    columns: 6;
    lines: 4;
    spacing: 30px;
    cycle: true;
    dynamic: true;
    fixed-columns: true;
    flow: horizontal; /* Lays items out left-to-right across rows */
}

element {
    background-color: transparent;
    text-color: @fg-col;
    border-radius: 18px;
    padding: 16px 8px;
    orientation: vertical;
}

element-icon {
    size: 72px;
    horizontal-align: 0.5;
    background-color: transparent;
}

element-text {
    horizontal-align: 0.5;
    vertical-align: 0.5;
    background-color: transparent;
    text-color: inherit;
    margin: 8px 0px 0px 0px;
}

element selected {
    background-color: @selected-col;
    text-color: @accent-white;
}

/* --- Bottom Mode Switcher --- */
mode-switcher {
    background-color: transparent;
    margin: 0px 35%;
    spacing: 10px;
}

button {
    padding: 8px 16px;
    background-color: transparent;
    text-color: @grey;
    border-radius: 8px;
}

button selected {
    background-color: #ffffff20;
    text-color: @accent-white;
}
ROFI_CONFIG

echo "Rofi configuration created successfully at $HOME/.config/rofi/config.rasi"

# Step 2: Writing Sway Configuration
mkdir -p "$HOME/.config/sway"

cat << 'SWAY_CONFIG' > "$HOME/.config/sway/config"
# ---------------------------------------------------------
# Variables
# ---------------------------------------------------------

# 1. Identify and place your laptop screen at the starting point (0, 0)
output eDP-1 position 0 0

# 2. Place your 144Hz main monitor to the right of your laptop screen
output HDMI-A-1 mode 1920x1080@144Hz position 1920 0

xwayland enable

set $mod Mod4

# Set your preferred terminal
set $term foot

# Set application launcher
set $menu rofi -show drun

# ---------------------------------------------------------
# Appearance & Gaps
# ---------------------------------------------------------
gaps inner 8
gaps outer 4

default_border pixel 2
default_floating_border pixel 2

client.focused          #ffffff #ffffff #000000 #ffffff   #ffffff
client.focused_inactive #000000 #000000 #888888 #000000   #000000
client.unfocused        #000000 #000000 #888888 #000000   #000000

# ---------------------------------------------------------
# Key Bindings
# ---------------------------------------------------------
bindsym $mod+Return exec $term
bindsym $mod+d exec $menu
bindsym $mod+q kill
bindsym $mod+Shift+c reload
bindsym $mod+Shift+e exec swaynag -t warning -m 'Quit Sway?' -B 'Yes' 'swaymsg exit'

bindsym $mod+f fullscreen toggle
bindsym $mod+space floating toggle

# Directional Window Focus (Arrow Keys)
bindsym $mod+Up focus up
bindsym $mod+Down focus down
bindsym $mod+Left focus left
bindsym $mod+Right focus right

floating_modifier $mod

# ---------------------------------------------------------
# Hardware & Media Controls
# ---------------------------------------------------------
bindsym XF86AudioRaiseVolume exec pactl set-sink-volume @DEFAULT_SINK@ +5%
bindsym XF86AudioLowerVolume exec pactl set-sink-volume @DEFAULT_SINK@ -5%
bindsym XF86AudioMute        exec pactl set-sink-mute @DEFAULT_SINK@ toggle

exec pipewire
exec pipewire-pulse
exec wireplumber

bindsym XF86MonBrightnessUp   exec brightnessctl set +5%
bindsym XF86MonBrightnessDown exec brightnessctl set 5%-

# ---------------------------------------------------------
# Autostart
# ---------------------------------------------------------
exec_always swaybg -i $HOME/Downloads/wallhaven-vpyekp.jpg  
exec_always autotiling
exec_always bash ./cleanup.sh

bar {
    position bottom
    status_command i3status ~/.config/i3status/config
    font pango:SpaceMono Nerd Font 8
    colors {
        statusline #ffffff
        background #00000000
        separator  #000000
        
        focused_workspace  #00000000 #00000000 #ffffff
        active_workspace   #00000000 #00000000 #ffffff
        inactive_workspace #00000000 #00000000 #ffffff
        urgent_workspace   #00000000 #00000000 #ffffff
    }
}

input type:touchpad {
    tap enabled
}
SWAY_CONFIG

echo "Sway configuration created successfully at $HOME/.config/sway/config"

echo "i3status config now"
# Create the directory if it doesn't exist
mkdir -p "$HOME/.config/i3status"

# Write the i3status config
cat << 'I3STATUS_CONFIG' > "$HOME/.config/i3status/config"
general {
    colors = true
    interval = 2
    color_good = "#ffffff"
    color_degraded = "#ffffff"
    color_bad = "#ffffff"
}

# The order of modules matches your i3status-rs block layout from top to bottom
order += "cpu_usage"
order += "memory"
order += "battery 0"
order += "time"

cpu_usage {
    format = "CPU: %usage"
}

memory {
    format = " %used "
    threshold_degraded = "10%"
    format_degraded = "MEMORY: %free"
}

battery 0 {
    format = " %status %percentage %remaining "
    format_down = "No battery"
    status_chr = "⚡ CHR"
    status_bat = "🔋 BAT"
    status_unk = "? UNK"
    status_full = "☻ FULL"
    path = "/sys/class/power_supply/BAT%d/uevent"
    low_threshold = 10
}

time {
    format = "%a %d/%m %H:%M"
}
I3STATUS_CONFIG

echo "i3status configuration created successfully at $HOME/.config/i3status/config"

# Create the directory if it doesn't exist
mkdir -p "$HOME/.config/foot"

# Write the foot configuration
cat << 'FOOT_CONFIG' > "$HOME/.config/foot/foot.ini"
[main]
term=xterm-256color
# Clean margins so text doesn't hit screen edges
pad=16x16                            
initial-window-size-chars=90x24

[cursor]
style=block
blink=yes
# Separate parameters prevent the parser error
#color=000000 

[csd]
# Added black borders from second config to keep corners clean
border-width=1
border-color=ff000000

[colors-dark]
background=000000                     # Pure pitch black
foreground=ffffff                     # Bright clean white text

# Keep server-side or client-side decorations (like title bars) black
flash=000000

## Normal ANSI colors (Brightened to pop perfectly on pure black)
regular0=1a1a1a  # Black
regular1=ff5555  # Red
regular2=50fa7b  # Green
regular3=f1fa8c  # Yellow
regular4=bd93f9  # Blue
regular5=ff79c6  # Magenta
regular6=8be9fd  # Cyan
regular7=f8f8f2  # White

## Bright ANSI colors
bright0=6272a4   # Bright Black (Gray)
bright1=ff6e6e   # Bright Red
bright2=69ff94   # Bright Green
bright3=ffffa5   # Bright Yellow
bright4=d6acff   # Bright Blue
bright5=ff92df   # Bright Magenta
bright6=a4ffff   # Bright Cyan
bright7=ffffff   # Bright White

[mouse]
hide-when-typing=yes
FOOT_CONFIG

echo "Foot terminal configuration created successfully at $HOME/.config/foot/foot.ini"
