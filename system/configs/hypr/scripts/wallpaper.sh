#!/bin/bash
if ! pgrep -x "swww" >/dev/null; then
    swww init
fi

pickup_directory="/home/iggut/.config/hypr/bg"
no_of_img=$(ls $pickup_directory | wc -l)
array=($(ls /home/iggut/.config/hypr/bg))

select="$pickup_directory/${array[$((RANDOM%$no_of_img))]}"
swww img $select --transition-type any --transition-step 0  --transition-fps 165 --transition-bezier 0.0,0.0,1.0,1.0 --transition-duration .8

echo "done"


