#!/bin/sh
PATH="/usr/local/bin:/usr/bin:/bin:$HOME/.local/bin:$HOME/bin"
export PATH

if [ "$*" ]; then
    find "$@" \( -name \*.js   \
              -o -name \*.css  \
              -o -name \*.html \
              -o -name \*.txt  \
              -o -name \*.svg  \
        \) -size +1000c -exec pigz -9k '{}' +
else
    echo "Usage: $0 filenames..."
    echo 'Recursively pigz static pages over 1000 bytes.'
fi
