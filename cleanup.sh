#!/bin/bash
# Deep Cleanup Script for Artix Linux

set -e

echo "=== 1. Removing orphan packages & unneeded dependencies ==="
ORPHANS=$(pacman -Qtdq || true)
if [ -n "$ORPHANS" ]; then
    sudo pacman -Rns $ORPHANS --noconfirm
else
    echo "No orphan packages found."
fi

echo "=== 2. Aggressively cleaning pacman cache ==="
# Remove ALL cached packages except the currently installed ones
sudo pacman -Sc --noconfirm
# Optional: Clear ALL cached packages completely (uncomment if low on space):
# sudo pacman -Scc --noconfirm

echo "=== 3. Cleaning AUR helper caches (yay / paru) ==="
if command -v yay &> /dev/null; then
    yay -Sc --noconfirm
    yay -Yc --noconfirm
elif command -v paru &> /dev/null; then
    paru -Sc --noconfirm
    paru -c --noconfirm
fi

echo "=== 4. Removing orphaned global configuration files (.pacsave / .pacnew) ==="
sudo find /etc -name "*.pacsave" -delete
sudo find /etc -name "*.pacnew" -delete

echo "=== 5. Cleaning user-level AUR build directories ==="
rm -rf ~/.cache/yay/*
rm -rf ~/.cache/paru/clone/*

echo "=== 6. Cleaning compiler & package manager dev caches ==="
# Python bytecode & cache
find ~/.local/ -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
rm -rf ~/.cache/pip

# Cargo / Rust cache (if installed)
if [ -d "$HOME/.cargo/registry" ]; then
    rm -rf ~/.cargo/registry/cache/*
fi

echo "=== 7. Wiping trash and user caches ==="
rm -rf ~/.local/share/Trash/*
rm -rf ~/.cache/thumbnails/*
rm -rf ~/.cache/fontconfig/*

echo "=== 8. Truncating system logs ==="
sudo find /var/log -type f -exec truncate -s 0 {} +

echo "=== Deep Cleanup Complete! ==="

if grep -q "Discharging" /sys/class/power_supply/BAT*/status 2>/dev/null; then
    echo "Status: On Battery"
    
    # --------------------------------------------------
    # PUT YOUR BATTERY COMMANDS BELOW
    # --------------------------------------------------
sudo tlp power-saver    
sudo powertop --auto-tune
sudo cpupower frequency-set -d 1.4GHz -u 1.6GHz    
echo 1400000 | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq
echo 1600000 | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq    

    # --------------------------------------------------

else
    echo "Status: On AC Power / Charged"
    
    # --------------------------------------------------
    # PUT YOUR PLUGGED-IN / CHARGED COMMANDS BELOW
    # --------------------------------------------------
sudo tlp performance
cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq    
    
    # --------------------------------------------------

fi
