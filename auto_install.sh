#!/bin/bash

drive=$(lsblk -o NAME,TYPE | grep 'disk$' | awk '{print $1}')

timedatectl set-ntp true
timedatectl set-timezone Asia/Ho_Chi_Minh

lsblk

parted /dev/"$drive" mklabel gpt mkpart primary fat32 1MiB 512MiB set 1 esp on
parted /dev/"$drive" mkpart primary linux-swap 512MiB 3GiB
parted /dev/"$drive" mkpart primary ext4 3GiB 100%

mkfs.fat -F32 /dev/"${drive}"1
mkswap /dev/"${drive}"2
mkfs.ext4 /dev/"${drive}"3

swapon /dev/"${drive}"2
mount /dev/"${drive}"3 /mnt
mkdir /mnt/boot
mount /dev/"${drive}"1 /mnt/boot

reflector --country VN --age 12 --sort rate --save /etc/pacman.d/mirrorlist
pacstrap /mnt linux linux-firmware base base-devel vim wget openssh
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
