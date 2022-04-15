#!/usr/bin/env bash

set -o pipefail
set -o nounset
set -o errexit

umount /mnt/boot/efi
umount /mnt
