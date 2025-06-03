#!/bin/bash

set -eu
set -o pipefail
set -o noclobber

cd "$(dirname "$0")"

stow -t ~/.config .
stow -t ~ ./.xorg/home
sudo stow -t /etc ./.xorg/etc
