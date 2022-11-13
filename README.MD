# Cài đặt Arch Linux

## Chuẩn bị

### Tạo USB Boot bằng Ventoy

**Tạo USB Boot:**

- Tải phiên bản mới nhất của Ventoy trên GitHub: [Ventoy GitHub](https://github.com/ventoy/Ventoy/releases/).
- Gắn USB vào máy tính của bạn.
- Mở Ventoy và chọn USB bạn muốn tạo.
- Chọn [GPT hoặc MBR](https://quantrimang.com/cong-nghe/gpt-va-mbr-khac-nhau-nhu-the-nao-khi-phan-vung-o-dia-122635) từ Option
- Nhấn nút "Install" để cài đặt Ventoy vào USB.
- Sao chép file [ISO của Arch Linux](https://mirror.bizflycloud.vn/archlinux/iso/latest/) (và bất kỳ hệ điều hành khác bạn muốn cài đặt) vào USB.

### Thiết lập BIOS để Boot từ USB

Lưu ý: Các bước này có thể thay đổi tùy thuộc vào phiên bản BIOS của bạn. Dưới đây là một hướng dẫn tổng quát:

1. **Khởi động lại máy tính và vào BIOS:**

   - Khởi động lại máy và nhấn phím để truy cập BIOS. Phím này thường là F2, F10, F12, Esc hoặc Delete. Bạn cần kiểm tra [hướng dẫn](https://www.thegioididong.com/hoi-dap/huong-dan-cach-vao-bios-win-10-va-cac-phim-tat-1532092) của máy tính để xác định phím đúng.

2. **Thiết lập Boot Order:**

   - Trong BIOS/UEFI, tìm mục "Boot" hoặc "Boot Order"...
   - Chọn thiết bị USB làm thiết bị khởi đầu chính (Primary Boot Device). Bạn có thể di chuyển USB lên đầu danh sách hoặc chọn USB và sử dụng các phím +/- để sắp xếp lại thứ tự.

3. **Lưu và thoát:**

   - Lưu các thay đổi bạn vừa thực hiện và thoát BIOS.

4. **Khởi động từ USB:**

   - Khởi động lại máy và chờ đợi cho quá trình khởi động từ USB. Nếu bạn đã làm đúng, bạn sẽ thấy menu của Ventoy hiển thị các file ISO bạn đã sao chép vào USB.

5. **Chọn image Arch Linux và bắt đầu cài đặt:**

   - Chọn file [ISO của Arch Linux](https://mirror.bizflycloud.vn/archlinux/iso/latest/) từ menu Ventoy và bắt đầu quá trình cài đặt.

## Cài đặt

### 1. Cài đặt tự động với script

- 1.1. Cài đặt hệ thống trong ArchISO

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ovftank/arch/main/auto_install.sh)"
```

- 1.2. Cài đặt hệ thống trong ArchChroot

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ovftank/arch/main/arch-install.sh)"
```

### 2. Cài đặt thủ công

- 1\. Đồng bộ hóa thời gian với hệ thống

  - Sử dụng các lệnh sau để đồng bộ hóa thời gian và cài đặt múi giờ:

    ```bash
    timedatectl set-ntp true
    timedatectl set-timezone Asia/Ho_Chi_Minh
    ```

- 2\. Thiết lập kết nối internet

  - Kiểm tra kết nối mạng bằng cách chạy lệnh sau:

    ```bash
    ping google.com
    ```

  - Nếu không có kết nối internet, sử dụng các lệnh sau để kết nối với Wi-Fi (_đối với mạng dây chỉ cần cắm cáp vào thôi_):

    ```bash
    iwctl
    device list
    station wlan0 scan
    station wlan0 get-networks
    station wlan0 connect "tên_wifi"
    ```

- 3\. Phân vùng ổ đĩa

  - Xác định các phân vùng ổ đĩa bằng lệnh `lsblk`:
  - Sử dụng công cụ `cfdisk` để tạo các phân vùng trên ổ đĩa. Đảm bảo rằng bạn tạo ra các phân vùng sau đây:

    - Phân vùng EFI (_phân vùng cho UEFI_, _**không nhớ Legacy có cần hay không nữa, mình quên r =))**_)
    - Phân vùng Swap (_không cần thiết nếu bạn dư RAM :|_)
    - Phân vùng Root (/) (_bắt buộc_)
    - Phân vùng Home (_nếu bạn muốn tách riêng phần lưu trữ người dùng_)

  - Format các phân vùng

    - Hãy thay đổi các phân vùng phù hợp với máy của bạn. Ví dụ: `nvme0n1p1`, `nvme0n1p2`, `nvme0n1p3`, `nvme0n1p4`.

    ```bash
    mkfs.fat -F32 /dev/sda1
    mkswap /dev/sda2
    mkfs.ext4 /dev/sda3
    mkfs.ext4 /dev/sda4
    ```

  - Mount các phân vùng:

    ```bash
    swapon /dev/sda2
    mount /dev/sda3 /mnt
    mkdir /mnt/{boot,home}
    mount /dev/sda1 /mnt/boot
    mount /dev/sda4 /mnt/home
    ```

- 4\. Cài đặt

- (Fix lỗi Keyring)

  ```bash
  pacman -Sy archlinux-keyring
  pacman-key --init
  pacman-key --populate archlinux
  ```

    ```bash
    reflector --country VN --age 12 --sort rate --save /etc/pacman.d/mirrorlist
    pacstrap /mnt linux linux-firmware base base-devel vim wget
    genfstab -U /mnt >> /mnt/etc/fstab
    ```

  - 4.2\. Cấu hình thiết lập cơ bản

    - Truy cập vào hệ thống mới:

      ```bash
      arch-chroot /mnt
      ```

    - Cấu hình ngôn ngữ hệ thống:

      - Mở tệp `locale.gen` và bỏ dấu chú thích ngôn ngữ bạn muốn sử dụng:

      ```bash
      vim /etc/locale.gen
      locale-gen
      ```

    - Chỉnh sửa tệp `locale.conf` bằng `vim`:

      ```bash
      vim /etc/locale.conf
      LANG=en_US.UTF-8
      LANGUAGE=en_US
      ```

    - Đặt múi giờ:

      ```bash
      ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
      hwclock --systohc
      ```

  - 4.3\. Cá nhân hóa hệ thống của bạn

    - Đặt tên máy chủ:

      ```bash
      echo tên_của_bạn > /etc/hostname
      vim /etc/hosts
      # Add the following lines:
      127.0.0.1 localhost.localdomain localhost
      ::1 localhost.localdomain localhost
      127.0.1.1 tên_của_bạn.localdomain tên_của_bạn
      ```

    - Tạo người dùng mới cho `tên_của_bạn` và cấu hình người dùng root:

      ```bash
      useradd -m tên_của_bạn
      usermod -aG wheel,audio,video,storage,optical,power tên_của_bạn
      passwd  # enter root password
      passwd tên_của_bạn  # enter user password
      EDITOR=vim visudo
      # Uncomment the line: %wheel ALL=(ALL) NOPASSWD: ALL
      ```

    - Cài đặt các package cần thiết:

      ```bash
      pacman -S networkmanager grub os-prober efibootmgr
      systemctl enable NetworkManager
      ```

    - Cài đặt [Bootloader](https://wiki.archlinux.org/title/Arch_boot_process):

      ```bash
      grub-install --efi-directory=/boot --bootloader-id=arch
      grub-mkconfig -o /boot/grub/grub.cfg
      ```

- Xong r đó, khởi động lại và đăng nhập vào thôi

```bash
exit
umount -R /mnt
reboot
```

#### [Custom](https://github.com/ovftank/arch/blob/main/CUSTOM.MD)
