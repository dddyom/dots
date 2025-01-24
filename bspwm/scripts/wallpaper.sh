#! /bin/sh

RANDOM_WALLPAPER=$(find "$HOME/.config/wallpapers/" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)
nitrogen --set-scaled $RANDOM_WALLPAPER
