# Custom

## 1\. Cài đặt git và golang

  ```bash
  sudo pacman -S --needed git go
  ```

## 2\. Clone và cài đặt yay

  ```bash
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
  ```

## 3\. Cài đặt zsh và thay đổi shell mặc định

  ```bash
  sudo pacman -S zsh
  sudo chsh --shell $(which zsh) $USER
  ```

## 4\. Cài đặt gói Gnome

Tùy thuộc vào nhu cầu của bạn, bạn có thể cài đặt gói `gnome-backgrounds` hoặc `gnome-shell`. Nếu bạn muốn có hình nền, hãy chạy lệnh sau:

  ```bash
  sudo pacman -S gdm gnome-backgrounds gnome-control-center gnome-keyring
  ```

Nếu bạn không muốn có hình nền(nhẹ hơn chút), hãy chạy lệnh sau:

  ```bash
  sudo pacman -S gdm gnome-shell gnome-control-center gnome-keyring
  ```

Sau đó, kích hoạt [GDM](https://www.baeldung.com/wp-content/uploads/sites/2/2023/07/gnome_preview.png) để có thể đăng nhập với giao diện.:

  ```bash
  sudo systemctl enable gdm
  ```

## 5\. Cài đặt các gói bổ sung

- Visual Studio Code:

  ```bash
  yay -S visual-studio-code-bin
  ```

- Terminal:

  ```bash
  sudo pacman -S alacritty
  ```

- Font [Click để xem thử](https://www.programmingfonts.org/#jetbrainsmono):

  ```bash
  sudo pacman -S ttf-jetbrains-mono-nerd
  ```

- Trình duyệt Google Chrome:

  ```bash
  yay -Sy google-chrome
  ```

- Bộ gõ tiếng Việt:

  ```bash
  yay -Sy ibus-bamboo
  ```

Sau khi hoàn thành các bước trên, bạn có thể tham khảo hướng dẫn custom giống như MacOS tại [đây](https://www.youtube.com/watch?v=VQ6MVky9EUk).
