#!/usr/bin/env bash

set -o pipefail
set -o nounset
set -o errexit

echo "partitioning disk $DISK_DEVICE"
sgdisk \
  --clear \
  --new=1::+256MiB \
  --typecode=1:0xEF00 \
  --change-name=1:EFI \
  --largest-new=2 \
  --change-name=2:crypto-root \
      $DISK_DEVICE

echo "formatting efi partition"
partprobe $DISK_DEVICE
mkfs.fat -F 32 ${DISK_DEVICE}1

echo "creating luks container"
machine_key_file=/tmp/luks-machine-key
dd if=/dev/urandom of=$machine_key_file bs=512 count=8 status=none
cryptsetup --batch-mode luksFormat --type=luks --key-file=$machine_key_file ${DISK_DEVICE}2
echo -n $DISK_PASSWORD | cryptsetup luksAddKey --key-file=$machine_key_file ${DISK_DEVICE}2 -

echo "formatting luks device"
cryptsetup open --type=luks --key-file=$machine_key_file ${DISK_DEVICE}2 root
mkfs.btrfs --quiet --label=root /dev/mapper/root

mount /dev/mapper/root /mnt

echo "mounting efi partition"
mkdir --parents /mnt/boot/efi
mount ${DISK_DEVICE}1 /mnt/boot/efi

echo "generating fstab"
mkdir  --parents /mnt/etc
cat <<EOI > /mnt/etc/fstab
LABEL=root  /         	btrfs     	rw,noatime,ssd,space_cache,subvolid=5,subvol=/,compress=zstd	  0 0
PARTLABEL=EFI /boot/efi 	vfat      	rw,noatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro	  0 2
EOI
