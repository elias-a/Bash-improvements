#!/bin/bash

orig=$1
new=$2
file=$(basename $new)
path=$(dirname $new)

if [ -f "$new" ]; then
    if [ ! -d "$path/.trash" ]; then
        mkdir "$path/.trash"
    fi

    /bin/mv "$new" "$path/.trash/$file"
fi

/bin/cp "$orig" "$new"
