<h1 id="cài-đặt-arch-linux-🐧">Cài đặt Arch Linux 🐧</h1>
<h2 id="chuẩn-bị-🛠️">Chuẩn bị 🛠️</h2>
<h3 id="tạo-usb-boot-bằng-ventoy">Tạo USB Boot bằng Ventoy:</h3>
<p><strong>Tạo USB Boot:</strong><br>
    -   Tải phiên bản mới nhất của Ventoy trên GitHub: <a href="https://github.com/ventoy/Ventoy/releases/">Ventoy GitHub</a>.<br>
    -   Gắn USB vào máy tính của bạn.<br>
    -   Mở Ventoy và chọn USB bạn muốn tạo.<br>
    -  Chọn <a href="https://quantrimang.com/cong-nghe/gpt-va-mbr-khac-nhau-nhu-the-nao-khi-phan-vung-o-dia-122635">GPT hoặc MBR</a> từ  Option<br>
    -   Nhấn nút &quot;Install&quot; để cài đặt Ventoy vào USB.<br>
    -   Sao chép file <a href="https://mirror.bizflycloud.vn/archlinux/iso/latest/">ISO của Arch Linux</a> (và bất kỳ hệ điều hành khác bạn muốn cài đặt) vào USB.</p>
<h3 id="thiết-lập-bios-để-boot-từ-usb">Thiết lập BIOS để Boot từ USB:</h3>
<p>Lưu ý: Các bước này có thể thay đổi tùy thuộc vào phiên bản BIOS của bạn. Dưới đây là một hướng dẫn tổng quát:</p>
<ol>
<li><p><strong>Khởi động lại máy tính và vào BIOS:</strong></p>
<ul>
<li>Khởi động lại máy và nhấn phím để truy cập BIOS. Phím này thường là F2, F10, F12, Esc hoặc Delete. Bạn cần kiểm tra <a href="https://www.thegioididong.com/hoi-dap/huong-dan-cach-vao-bios-win-10-va-cac-phim-tat-1532092#:~:text=B%E1%BA%A5m%20gi%E1%BB%AF%20ph%C3%ADm%20F2%20%C4%91%E1%BB%83%20v%C3%A0o%20%C4%91%C6%B0%E1%BB%A3c%20BIOS.&text=B%E1%BA%A5m%20gi%E1%BB%AF%20ph%C3%ADm%20F12%20%C4%91%E1%BB%83,v%E1%BB%ABa%20kh%E1%BB%9Fi%20%C4%91%E1%BB%99ng%20l%E1%BA%A1i%20m%C3%A1y.&text=B%E1%BA%A5m%20gi%E1%BB%AF%20ph%C3%ADm%20ESC%20%C4%91%E1%BB%83%20v%C3%A0o%20BIOS%20khi%20kh%E1%BB%9Fi%20%C4%91%E1%BB%99ng%20l%E1%BA%A1i%20m%C3%A1y.">hướng dẫn</a> của máy tính để xác định phím đúng.</li>
</ul>
</li>
<li><p><strong>Thiết lập Boot Order:</strong></p>
<ul>
<li>Trong BIOS/UEFI, tìm mục &quot;Boot&quot; hoặc &quot;Boot Order&quot;...</li>
<li>Chọn thiết bị USB làm thiết bị khởi đầu chính (Primary Boot Device). Bạn có thể di chuyển USB lên đầu danh sách hoặc chọn USB và sử dụng các phím +/- để sắp xếp lại thứ tự.</li>
</ul>
</li>
<li><p><strong>Lưu và thoát:</strong></p>
<ul>
<li>Lưu các thay đổi bạn vừa thực hiện và thoát BIOS.</li>
</ul>
</li>
<li><p><strong>Khởi động từ USB:</strong></p>
<ul>
<li>Khởi động lại máy và chờ đợi cho quá trình khởi động từ USB. Nếu bạn đã làm đúng, bạn sẽ thấy menu của Ventoy hiển thị các file ISO bạn đã sao chép vào USB.</li>
</ul>
</li>
<li><p><strong>Chọn image Arch Linux và bắt đầu cài đặt:</strong></p>
<ul>
<li>Chọn file <a href="https://mirror.bizflycloud.vn/archlinux/iso/latest/">ISO của Arch Linux</a> từ menu Ventoy và bắt đầu quá trình cài đặt.</li>
</ul>
</li>
</ol>
<h3 id="1-đồng-bộ-hóa-thời-gian-với-hệ-thống-⏰">1. Đồng bộ hóa thời gian với hệ thống ⏰</h3>
<ul>
    <li>Sử dụng các lệnh sau để đồng bộ hóa thời gian và cài đặt múi giờ:</li>
</ul>
<pre><code class="language-bash">timedatectl set-ntp true
timedatectl set-timezone Asia/Ho_Chi_Minh
</code></pre>
<h3 id="2-thiết-lập-kết-nối-internet-🌐">2. Thiết lập kết nối internet 🌐</h3>
<ul>
    <li>Kiểm tra kết nối mạng bằng cách chạy lệnh sau:</li>
</ul>
<pre><code class="language-bash">ping google.com
</code></pre>
<ul>
    <li>Nếu không có kết nối internet, sử dụng các lệnh sau để kết nối với Wi-Fi (<em>đối với mạng dây chỉ cần cắm cáp
            vào thôi</em> 😉):</li>
</ul>
<pre><code class="language-bash">iwctl
device scan
device list
station wlan0 scan
station wlan0 get-networks
station wlan0 connect &quot;tên_wifi&quot;
</code></pre>
<h3 id="3-phân-vùng-ổ-đĩa-📂">3. Phân vùng ổ đĩa 📂</h3>
<ul>
    <li>
        <p>Xác định các phân vùng ổ đĩa bằng lệnh <code>lsblk</code>:</p>
    </li>
    <li>
        <p>Sử dụng công cụ <code>cfdisk</code> để tạo các phân vùng trên ổ đĩa. Đảm bảo rằng bạn tạo ra các phân vùng
            sau đây:</p>
        <ul>
            <li>Phân vùng EFI (<em>phân vùng cho UEFI</em>, <em><strong>không nhớ Legacy có cần hay không nữa, mình quên
                        r =))</strong></em>)</li>
            <li>Phân vùng Swap (<em>không cần thiết nếu bạn dư RAM :|</em>)</li>
            <li>Phân vùng Root (/) (<em>bắt buộc</em>)</li>
            <li>Phân vùng Home (<em>nếu bạn muốn tách riêng phần lưu trữ người dùng</em>)</li>
        </ul>
    </li>
    <li>
        <p>Format các phân vùng</p>
        <ul>
            <li>Hãy thay đổi các phân vùng phù hợp với máy của bạn. Ví dụ: <code>nvme0n1p1</code>,
                <code>nvme0n1p2</code>, <code>nvme0n1p3</code>, <code>nvme0n1p4</code>. 😄</li>
        </ul>
    </li>
</ul>
<pre><code class="language-bash">mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4
</code></pre>
<ul>
    <li>Mount các phân vùng:</li>
</ul>
<pre><code class="language-bash">swapon /dev/sda2
mount /dev/sda3 /mnt
mkdir /mnt/{boot,home}
mount /dev/sda1 /mnt/boot
mount /dev/sda4 /mnt/home
</code></pre>
<h2 id="cài-đặt-🚀">Cài đặt 🚀</h2>
<ul>
    <li>(Fix lỗi Keyring)</li>
</ul>
<pre><code class="language-bash">pacman -Sy archlinux-keyring
pacman-key --init
pacman-key --populate archlinux
</code></pre>
<h3 id="1-cài-đặt-các-gói-cơ-bản-và-tạo-tệp-fstab-📦">1. Cài đặt các gói cơ bản và tạo tệp Fstab 📦</h3>
<pre><code class="language-bash">pacman -Syyu --noconfirm
pacman -S reflector --noconfirm
reflector --country VN --age 12 --sort rate --save /etc/pacman.d/mirrorlist
pacstrap /mnt linux linux-firmware base base-devel vim wget
genfstab -U /mnt &gt;&gt; /mnt/etc/fstab
</code></pre>
<h3 id="2-cấu-hình-thiết-lập-cơ-bản-⚙️">2. Cấu hình thiết lập cơ bản ⚙️</h3>
<ul>
    <li>Truy cập vào hệ thống mới:</li>
</ul>
<pre><code class="language-bash">arch-chroot /mnt
</code></pre>
<h4 id="cài-đặt-với-script">1. Cài đặt tự động với script</h4>
<ul>
    <li>Script tự động cài đặt:</li>
</ul>
<pre><code class="language-bash">wget https://raw.githubusercontent.com/tripleseven190504/arch/main/arch-install.sh
chmod +x ./arch-install.sh
./arch-install.sh
</code></pre>
<h4 id="cài-đặt-thủ-công">2. Cài đặt thủ công</h4>
<ul>
    <li>Cấu hình ngôn ngữ hệ thống:<ul>
            <li>Mở tệp <code>locale.gen</code> và bỏ dấu chú thích ngôn ngữ bạn muốn sử dụng:</li>
        </ul>
    </li>
</ul>
<pre><code class="language-bash">vim /etc/locale.gen
locale-gen
</code></pre>
<ul>
    <li>Chỉnh sửa tệp <code>locale.conf</code> bằng <code>vim</code>:</li>
</ul>
<pre><code class="language-bash">vim /etc/locale.conf
LANG=en_US.UTF-8
LANGUAGE=en_US
</code></pre>
<ul>
    <li>Đặt múi giờ:</li>
</ul>
<pre><code class="language-bash">ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
hwclock —-systohc
</code></pre>
<h3 id="3-cá-nhân-hóa-hệ-thống-của-bạn-🌟">3. Cá nhân hóa hệ thống của bạn 🌟</h3>
<ul>
    <li>Đặt tên máy chủ:</li>
</ul>
<pre><code class="language-bash">echo tên_của_bạn &gt; /etc/hostname
nvim /etc/hosts
127.0.0.1    localhost.localdomain   localhost
::1          localhost.localdomain   localhost
127.0.1.1    tên_của_bạn.localdomain    tên_của_bạn
</code></pre>
<ul>
    <li>Tạo người dùng mới cho <code>tên_của_bạn</code> và cấu hình người dùng root:</li>
</ul>
<pre><code class="language-bash">useradd -m tên_của_bạnusermod -aG wheel,audio,video,storage,optical,power tên_của_bạn
passwd (nhập mật khẩu của bạn)
passwd tên_của_bạn (nhập mật khẩu của bạn)
EDITOR=vim visudo
(Loại bỏ ký tự &quot;#&quot; trước %wheel ALL=(ALL) NOPASSWD: ALL)
</code></pre>
<ul>
    <li>Cài đặt các gói Arch cần thiết và cấu hình theo ý muốn:</li>
</ul>
<pre><code class="language-bash">pacman -S networkmanager grub os-prober efibootmgr
systemctl enable NetworkManager
</code></pre>
<ul>
    <li>Cài đặt trình khởi động:</li>
</ul>
<pre><code class="language-bash">grub-install --efi-directory=/boot --bootloader-id=arch
grub-mkconfig -o /boot/grub/grub.cfg
</code></pre>
<h2 id="xong-r-đó-khởi-động-lại-và-đăng-nhập-vào-thôi">Xong r đó, khởi động lại và đăng nhập vào thôi</h2>
<pre><code class="language-bash">exit
umount -R /mnt
reboot
</code></pre>
<h2 id="👉-custom"><a href="https://github.com/tripleseven190504/arch/blob/main/CUSTOM.MD">👉 Custom</a></h2>
