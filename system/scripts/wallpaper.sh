#!/bin/bash

if ! pgrep -x "swww" >/dev/null; then
    swww init
fi


# Set the directory where the images are stored
pickup_directory="$HOME/.config/hypr/bg"

# Pick a random image from the directory using shuf
selected_image=$(find "$pickup_directory" -type f -print0 | shuf -n 1 -z | tr -d '\0')

# Change the wallpaper using swww
swww img $selected_image --transition-type any --transition-fps 165 --transition-bezier 0.0,0.0,1.0,1.0 --transition-duration .8

echo "Wallpaper changed"

exit 0



