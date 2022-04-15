#!/usr/bin/env bash

set -o pipefail
set -o nounset
set -o errexit

pacman -Sy --noconfirm git

cd /mnt

export GIT_DIR=/mnt/.git-base
git init .
git remote add -f origin https://github.com/cmertz/dotfiles.git
git config core.sparseCheckout true
cat <<EOI > $GIT_DIR/info/sparse-checkout
.gitignore
etc/
usr/
EOI
git --work-tree=/mnt --git-dir=/mnt/.git-base pull origin master

export GIT_DIR=/mnt/.git-home
git init .
git remote add -f origin https://github.com/cmertz/dotfiles.git
git config core.sparseCheckout true
cat <<EOI > $GIT_DIR/info/sparse-checkout
home/
EOI
git --work-tree=/mnt --git-dir=/mnt/.git-home pull origin master

pacstrap /mnt base linux linux-firmware intel-ucode

# TODO /etc/hostname
# TODO hwclock --systohc
arch-chroot /mnt bash -e -- <<EOI
locale-gen
useradd --no-create-home chris
chpasswd <<< chris:${USER_PASSWORD}
chown chris:chris -R /home/chris
chown chris:chris -R /.git-home
EOI
