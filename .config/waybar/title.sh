#!/bin/bash
LIMIT=20
F=$(mktemp)
get() { swaymsg -t get_tree | jq -r '.. | select(.focused? == true) | .name // empty' | head -n1; }
get > "$F"
swaymsg -r -t subscribe -m '["window"]' | while read -r _; do get > "$F"; done &
SUB=$!
trap 'kill $SUB 2>/dev/null; rm -f "$F"' EXIT

last=""; i=0
while true; do
    T=$(<"$F"); [ -z "$T" ] && T="Desktop"
    if [ "$T" != "$last" ]; then
        last=$T; i=0
        [ ${#T} -le $LIMIT ] && echo "$T"
    fi
    if [ ${#T} -gt $LIMIT ]; then
        TEXT="$T        $T"
        echo "${TEXT:$i:$LIMIT}"
        i=$(( (i + 1) % (${#T} + 8) ))
        sleep 0.3
    else
        sleep 0.5
    fi
done
