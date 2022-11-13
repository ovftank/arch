#!/bin/bash

drive="nvme0n1"

timedatectl set-ntp true
timedatectl set-timezone Asia/Ho_Chi_Minh

lsblk

parted -s /dev/"$drive" mklabel gpt mkpart primary fat32 1MiB 512MiB set 1 esp on
parted -s /dev/"$drive" mkpart primary linux-swap 512MiB 3GiB
parted -s /dev/"$drive" mkpart primary ext4 3GiB 100%

mkfs.fat -F32 -n EFI_BOOT /dev/"${drive}"p1
mkswap -L arch_swap /dev/"${drive}"p2
mkfs.ext4 -q -L arch_root /dev/"${drive}"p3

swapon /dev/"${drive}"p2
mount -o noatime /dev/"${drive}"p3 /mnt
mkdir /mnt/boot
mount /dev/"${drive}"p1 /mnt/boot

reflector --age 12 --sort rate --save /etc/pacman.d/mirrorlist
pacstrap -K /mnt linux linux-firmware base base-devel vim wget openssh
genfstab -U /mnt >> /mnt/etc/fstab

curl -o /mnt/root/arch-install.sh https://raw.githubusercontent.com/ovftank/arch/main/arch-install.sh
chmod +x /mnt/root/arch-install.sh

arch-chroot /mnt /root/arch-install.sh
