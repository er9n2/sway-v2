Arch Linux/Arch Based Only


needed packages

sudo pacman -S sway foot rofi-wayland pipewire pipewire-pulse wireplumber libpulse brightnessctl swaybg i3status xorg-xwayland ttf-space-mono-nerd autotiling


mkdir -p ~/.local/share/applications && for app in avahi-discover bssh bvnc qv4l2 qvidcap foot foot-server footclient rofi rofi-theme-selector; do [ -f /usr/share/applications/"$app".desktop ] && cp /usr/share/applications/"$app".desktop ~/.local/share/applications/ && echo "NoDisplay=true" >> ~/.local/share/applications/"$app".desktop; done

to hide apps i dont use from rofi !
