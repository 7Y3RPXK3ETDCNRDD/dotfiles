#!/usr/bin/bash
if [ "$(pidof cmus)" ]; then
    ARTIST=$( cmus-remote -Q 2>/dev/null | grep 'tag artist' | cut -d " " -f 3- )
    TITLE=$( cmus-remote -Q 2>/dev/null | grep 'tag title' | cut -d " " -f 3- )
    NOTHING=$( cmus-remote -Q 2>/dev/null | grep 'file' | cut -d "/" -f 5- )

    if [ "$(cmus-remote -Q | grep 'status playing')" ]; then
        if [ -z "$ARTIST" ]; then
                echo "   $NOTHING"
        else
                echo "   $ARTIST - $TITLE"
        fi
    elif [ "$(cmus-remote -Q | grep 'status paused')" ]; then
        if [ -z "$ARTIST" ]; then
                echo "   $NOTHING"
        else
                echo "   $ARTIST - $TITLE"
        fi
    fi
fi
