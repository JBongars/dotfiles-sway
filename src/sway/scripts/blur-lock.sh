#!/bin/sh

PICTURE=/tmp/swaylock.png

grim $PICTURE
convert $PICTURE -blur 5x4 $PICTURE
swaylock -i $PICTURE
rm $PICTURE
