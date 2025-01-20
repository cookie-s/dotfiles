#!/bin/sh

text="$(curl -A curl -s "https://wttr.in/?m&format=1" | tr -d ' ')"
tooltip="$(curl -A curl -s "https://wttr.in/?m0QT")"

jq --unbuffered -cn \
    --arg text "$text" \
    --arg tooltip "$tooltip" \
    '{"text": $text, "tooltip": ("<tt>" + $tooltip + "</tt>")}'
