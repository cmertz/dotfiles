#!/usr/bin/env bash

set -o pipefail
set -o nounset
set -o errexit

pacman -Syu

pacman -S --noconfirm sway
pacman -S --noconfirm zsh
pacman -S --noconfirm nvim
