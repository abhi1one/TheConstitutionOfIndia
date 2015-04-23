#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
shopt -s extglob

DIR="`pwd`/constitution"
START="AMENDMENT_ORIGINAL_26011950.zip"

function start {
    rm -rf "$DIR"
    mkdir $DIR
    cd $DIR
    git init
    mkdir .git/txt
    cd ..
}

function create {
    
    TEMPDIR=`mktemp -d`

    # This leaves .git
    rm -f "$DIR/*"

    unzip -o $1 -d "$TEMPDIR/" >/dev/null
    cd "$TEMPDIR"

    # Format the whitespace
    find . -type f -iname "*.txt" -exec $DIR/../format.sh {} \;

    # Move to root
    find . -type f -iname "*.txt" -exec mv {} "$DIR/" \;
    
    # Delete all directories
    cd "$DIR"

    # Lets commit
    git add .
    # We ignore the pipefail
    git commit -am `basename "$1" ".zip"` || true

    # And reset
    rm -rf "$TEMPDIR"
    cd ..
}

# init the git repo
start

# init with the first version
create "$START"

for i in *.zip;do
    if [ "$i" != "$START" ]
    then
        echo "Setting up $i"
        create "$i"
    fi
done;

cp COMPLETE.md "$DIR/README.md"
cd $DIR
git add README.md
git commit -am "Adds README"
git remote add origin git@github.com:captn3m0/constitution.git
git push origin master -f
cd ..
