#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

DIR="constitution"
START="AMENDMENT_ORIGINAL_26011950.zip"

function start {
    rm -rf "$DIR"
    mkdir $DIR
    cd $DIR
    git init
    cd ..
}

function create {
    # This leaves .git
    rm -f "$DIR/*"
    unzip -o -u $1 -d "$DIR/"
    cd "$DIR"
    git add .
    # We ignore the pipefail
    git commit -m `basename "$1" ".zip"` || true
    cd ..
}

# init the git repo
start

for i in *.zip;do
    if [ "$i" != "$START" ]
    then
        create "$i"
    fi
done;
