#!/bin/bash
FIRST="$1"
SECOND="$2"

TEMP1=`mktemp -d`
TEMP2=`mktemp -d`

unzip "$FIRST" -d "$TEMP1/" >/dev/null
unzip "$SECOND" -d "$TEMP2/" >/dev/null

diff -wr "$TEMP1" "$TEMP2"

rm -rf "$TEMP1"
rm -rf "$TEMP2"
