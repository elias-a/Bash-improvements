#!/bin/bash 

# TODO: Needs to accept OPTIONS
# TODO: Don't pass -r flag to 
#       /bin/cp by default (?)

# Separate SRC files from DEST file
SRC_ARR=()
DEST=""
index=1
for arg in "$@"
do 
    if (( $index == $# )); then
        DEST=$arg
        break
    fi

    SRC_ARR+=( $arg )
    let index++
done

# Prevent overwriting 
FILE_DEST=$(basename $DEST)
PATH_TO_DEST=$(dirname $DEST)
for SRC in ${SRC_ARR[@]}
do
    FILE=$(basename $SRC)
    DIR=$(dirname $SRC)

    # If DEST is a file that already exists,
    # do not overwrite it
    if [ -f "$DEST" ]; then

        # Create hidden trash directory in the 
        # DEST directory if it does not exist 
        if [ ! -d "$PATH_TO_DEST/.trash" ]; then
            mkdir "$PATH_TO_DEST/.trash"
        fi

        # Move DEST file to .trash instead of overwriting
        /bin/mv "$DEST" "$PATH_TO_DEST/.trash/$FILE_DEST"

    # If DEST is a directory
    elif [ -d "$DEST" ]; then

        mapfile -t DEST_FILES < <( ls "$DEST" )
        if [[ " ${DEST_FILES[@]} " =~ " $FILE " ]]; then

            # Create hidden trash directory in the 
            # DEST directory if it does not exist 
            if [ ! -d "$DEST/.trash" ]; then
                mkdir "$DEST/.trash"
            fi

            /bin/mv "$DEST/$FILE" "$DEST/.trash/$FILE"
        fi
    fi
done

# Copy the files
/bin/cp -r "${SRC_ARR[@]}" "$DEST"
