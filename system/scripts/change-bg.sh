#!/usr/bin/env bash

BG_PATH="$HOME/.config/hypr/bg"

background_choice=""
if [[ $# -eq 0 ]]; then
    array=("code" "music" "lock")
    index=$((RANDOM%3))
    background_choice=${array[$index]}
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

ps -ef | rg "mpvpaper" | rg -v rg | awk '{print $2}' | xargs kill

case "$background_choice" in
    "default" )
        exit 0
    ;;
    "code")
        dna & disown
    ;;
    "music")
        record & disown
    ;;
    "lock")
        blackhole & disown
    ;;
    *)
        echo "invalid choice; choices: code | music | lock"
        exit 1
    ;;
esac

exit 0