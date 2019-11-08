#! /usr/bin/env bash

USAGE="hello\
"
# The script has two mode to find file for compress:
#   1. Manually input `Docs` directory path and `Code` directory path.
#   2. Auto detach files.


# Print usage
echo $USAGE

#!/bin/bash
# A simple script to make fzf a fuzzy-file explorer

cur_folder=$(pwd)
while true
do
    folder=$( ( echo -e '.\n..'; fd -t d --color=always ) \
        | fzf --no-height --preview-window=right:50% \
            --preview 'tree -L 2 -C {}')
    test $? -ne 0 && break
    cur_folder="$cur_folder/$folder"
    cd "$cur_folder"
done

echo "$cur_folder"

# Choose a directory to compress

# Input SR number

# Input SR name

# Judge code package type

# Do compress
