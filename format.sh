#!/bin/bash

TEMPFILE=`mktemp`
fold -w 80 $1 > "$TEMPFILE"
mv "$TEMPFILE" $1
