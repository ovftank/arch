#!/bin/bash
set -e

clear
echo "Nhập tên hostname của bạn:"
read hostname
if [ -z "$hostname" ]; then
    echo "Không có hostname được nhập. Thoát."
    exit 1
fi
echo "Nhập tên của người dùng mới:"
read username

if [ -z "$username" ]; then
    echo "Không có tên người dùng được nhập. Thoát."
    exit 1
fi

echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen
cat > /etc/locale.conf << 'EOF'
LANG=en_US.UTF-8
LC_NUMERIC=vi_VN.UTF-8
LC_TIME=vi_VN.UTF-8
LC_MONETARY=vi_VN.UTF-8
LC_PAPER=vi_VN.UTF-8
LC_MEASUREMENT=vi_VN.UTF-8
EOF
ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
hwclock --systohc

echo "$hostname" > /etc/hostname
cat > /etc/hosts << EOF
127.0.0.1    localhost
::1          localhost
127.0.1.1    $hostname
EOF

useradd -m -G wheel "$username"
clear
echo "Người dùng $username đã được tạo và cấu hình."
echo "Nhập mật khẩu cho user root:"
passwd

echo "Nhập mật khẩu cho người dùng $username:"
passwd "$username"

echo "Người dùng $username đã được tạo và cấu hình."

pacman -S --needed --noconfirm networkmanager grub efibootmgr openssh
systemctl enable NetworkManager
systemctl enable sshd
grub-install --efi-directory=/boot --bootloader-id=arch
grub-mkconfig -o /boot/grub/grub.cfg
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
sed -i 's/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers
exit
