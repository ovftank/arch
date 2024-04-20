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
pacman -S glibc-locales
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
echo 'LC_NUMERIC=vi_VN.UTF-8' >> /etc/locale.conf
echo 'LC_TIME=vi_VN.UTF-8' >> /etc/locale.conf
echo 'LC_MONETARY=vi_VN.UTF-8' >> /etc/locale.conf
echo 'LC_PAPER=vi_VN.UTF-8' >> /etc/locale.conf
echo 'LC_MEASUREMENT=vi_VN.UTF-8' >> /etc/locale.conf
ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
hwclock —-systohc

echo $hostname > /etc/hostname
echo "127.0.0.1    localhost.localdomain   localhost" > /etc/hosts
echo "::1          localhost.localdomain   localhost" >> /etc/hosts
echo "127.0.1.1    $hostname.localdomain    $hostname" >> /etc/hosts

useradd -m "$username"
usermod -aG wheel,audio,video,storage,optical,power "$username"
clear
echo "Người dùng $username đã được tạo và cấu hình."
echo "Nhập mật khẩu cho user root:"
passwd

echo "Nhập mật khẩu cho người dùng $username:"
passwd "$username"

echo "Người dùng $username đã được tạo và cấu hình."

pacman -S networkmanager grub efibootmgr openssh --noconfirm
systemctl enable NetworkManager
systemctl enable sshd
grub-install --efi-directory=/boot --bootloader-id=arch
grub-mkconfig -o /boot/grub/grub.cfg
EDITOR=vim visudo
exit
