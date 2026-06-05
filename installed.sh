# CLI
sudo pacman -S vim
sudo pacman -S starship
sudo pacman -S fzf
sudo pacman -S atuin

# UTIL
sudo pacman -S htop
sudo yay -S linutil
sudo yay -S neofetch
yay -S overskride
yas -S rustscan
sudo pacman -S openbsd-netcat
sudo pacman -S traceroute
sudo pacman -S wireguard-tools
yay -S netbird
sudo pacman -S chezmoi

## AV
sudo pacman -S yt-dlp

# DE
sudo pacman -S hyprland
sudo pacman -S waybar rofi rofi-calc rofimoji
sudo pacman -S hyprpicker hyprpaper
sudo pacman -S xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
sudo pacman -S wl-clipboard cliphist
sudo pacman -S ttf-firacode-nerd
sudo pacman -S ghostty
yay -S hyprsunset
sudo pacman -S wev
sudo pacman -S solaar
sudo pacman -S greetd greetd-regreet cage wlr-randr
sudo pacman -S slurp grim
sudo pacman -S dunst

## Webcam
sudo pacman -S cameractrls

## extra tools
sudo pacman -S kdeconnect

# DEV
sudo pacman -S kubectl k9s kubeseal

sudo pacman -S podman
yay -S visual-studio-code-bin
yay -S flux-bin
go install github.com/gohugoio/hugo@v0.145.0
sudo pacman -S git-crypt
curl https://get.volta.sh | bash
volta install node
volta install pnpm
sudo pacman -S go
curl -fsSL https://bun.sh/install | bash
sudo pacman -S go-task
yay -S kind
sudo pacman -S jq yq
sudo pacman -S pandoc
yay -S python-weasyprint
sudo pacman -S gitleaks

## AI
yay -S github-copilot-cli
yay -S codexbar-cli

codexbar config enable --provider copilot
printf '%s' "$COPILOT_API_TOKEN" | codexbar config set-api-key --provider copilot --stdin

## Krew
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"' >> .bashrc
kubectl krew install oidc-login
kubectl krew install radar

## Virtualization
sudo pacman -S qemu-user-static-binfmt qemu-user-static
sudo pacman -S qemu-full libvirt virt-manager edk2-ovmf dnsmasq
sudo systemctl enable --now libvirtd

# General
sudo pacman -S libva-nvidia-driver libva-utils
sudo pacman -S thunderbird
sudo pacman -S thunar thunar-media-tags-plugin thunar-archive-plugin thunar-volman gvfs gvfs-smb gvfs-mtp gvfs-afc udisks2 polkit polkit-gnome ark
sudo pacman -S signal-desktop
yay -S brother-mfc-l8690cdw cups avahi nss-mdns ghostscript
sudo systemctl enable --now cups
sudo systemctl enable --now avahi-daemon
sudo lpadmin -p Brother-MFC-L8690CDW -E -v socket://10.1.1.91:9100 -m Brother/brother_mfcl8690cdw_printer_en.ppd
sudo lpoptions -d Brother-MFC-L8690CDW
sudo lpadmin -p Brother-MFC-L8690CDW -o PageSize=A4
yay -S jellyfin-desktop-git
yay -S slack-desktop

# Dictation
sudo pacman -S wtype wl-clipboard
sudo pacman -S onnxruntime # Choose cuda
yay -S voxtype
voxtype setup systemd
sudo voxtype setup gpu --enable
sudo voxtype setup onnx --enable
voxtype setup model #Choose parkeet 11
voxtype setup waybar

# Gaming
sudo pacman -S flatpak
