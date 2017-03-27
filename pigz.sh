#!/bin/sh
PATH="/usr/local/bin:/usr/bin:/bin:$HOME/.local/bin:$HOME/bin"
export PATH

if [ "$*" ]; then
    find "$@" \( -name \*.js   \
              -o -name \*.css  \
              -o -name \*.html \
              -o -name \*.txt  \
              -o -name \*.svg  \
              -o -name \*.ico  \
              -o -name \*.atom \
              -o -name \*.xml  \
              -o -name \*.xsl  \
              -o -name LICENSE\* \
              -o -name COPYING\* \
        \) -size +500c -exec pigz -9k '{}' +
else
    echo "Usage: $0 filenames..."
    echo 'Recursively pigz static pages over 500 bytes.'
fi
