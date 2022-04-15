#!/usr/bin/env bash

set -o pipefail
set -o nounset
set -o errexit

cat /mnt/etc/mkinitcpio.conf
ls /mnt/etc/mkinitcpio.d/
cat /mnt/etc/mkinitcpio.d/linux.preset

arch-chroot /mnt mkdir --parents /boot/efi/EFI/BOOT
arch-chroot /mnt mkinitcpio -p linux
