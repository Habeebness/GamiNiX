#!/usr/bin/env bash

BG_PATH="$HOME/.config/hypr/bg"

background_choice=""
if [[ $# -eq 0 ]]; then
    background_choice="default"
else
    background_choice="$1"
fi

dna () {
    mpvpaper -o "--loop --brightness=6 --contrast=9 --saturation=-16 --hue=-24" '*' "$BG_PATH/dna.mp4" & disown
}

record () {
    mpvpaper -o "--loop --brightness=-3 --contrast=10 --saturation=-42 --hue=69" '*' "$BG_PATH/record.mp4" & disown
}

blackhole () {
    mpvpaper -o "--loop --brightness=3  --contrast=6  --saturation=-50  --hue=-8 --gamma=-20" '*' "$BG_PATH/blackhole.webm" & disown
}


case "$background_choice" in
    "default" )
        ps -ef | rg "record.mp4|blackhole.mp4" | rg -v rg | awk '{print $2}' | xargs kill
        exit 0
    ;;
    "code")
        dna & disown
        sleep 2
        ps -ef | rg "mpvpaper" | rg -v rg | awk '{print $2}' | head -n -1 | xargs kill
    ;;
    "music")
        record & disown
        ps -ef | rg "blackhole.mp4" | rg -v rg | awk '{print $2}' | xargs kill
    ;;
    "lock")
        blackhole & disown
        ps -ef | rg "record.mp4" | rg -v rg | awk '{print $2}' | xargs kill
    ;;
    *)
        echo "invalid choice; choices: code | music | lock"
        exit 1
    ;;
esac

exit 0
