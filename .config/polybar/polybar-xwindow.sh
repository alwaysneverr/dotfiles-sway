#!/bin/bash

# Set your max window length before it starts scrolling
LIMIT=20

while true; do
    # Get the current window title cleanly
    TITLE=$(xtitle)
    [ -z "$TITLE" ] && TITLE="Desktop"
    
    # CASE 1: Title fits comfortably -> No scrolling, just output static text
    if [ ${#TITLE} -le $LIMIT ]; then
        echo "$TITLE"
        
        # Keep checking every 0.5s for a window switch without wasting CPU
        while [ "$(xtitle)" = "$TITLE" ] || { [ -z "$(xtitle)" ] && [ "$TITLE" = "Desktop" ]; }; do
            sleep 0.5
        done
        
    # CASE 2: Title is too long -> Trigger the marquee scroll loop
    else
        # Pad the text with spaces so it loops cleanly
        TEXT="$TITLE        $TITLE"
        
        for ((i=0; i<${#TITLE}+8; i++)); do
            # Break instantly if the user switches windows mid-scroll
            NEW_TITLE=$(xtitle)
            if [ "$NEW_TITLE" != "$TITLE" ] && [ ! -z "$NEW_TITLE" ]; then
                break
            fi
            
            # Output the exact chunk to Polybar
            echo "${TEXT:$i:$LIMIT}"
            sleep 0.3
        done
    fi
done
