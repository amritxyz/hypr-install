# Installation
sudo pacman -Sy && sudo pacman -S brightnessctl hyprpaper imv lf mpv neovim ttf-hack ttf-hack-nerd waybar bleachbit fastfetch unzip hyprlock newsboat mupdf noto-fonts-emoji wtype

# Remove Bloat
sudo pacman -Rncsu vim dolphin nano dunst kitty ly
sudo pacman -Scc && sudo pacman -Sy

# MKdir
mkdir -p ~/.local/share ~/.config ~/.local/bin

# Post Installation
git clone --depth=1 https://gitlab.com/amrit-44404/hyprdots.git ~/hyprdots
git clone --depth=1 https://gitlab.com/amrit-44404/wall.git ~/.local/share/wall
git clone --depth=1 https://gitlab.com/amrit-44404/dmenu.git ~/.config/dmenu

# Managing Dotfiles
cp -r ~/hyprdots/.local/share/* ~/.local/share
cp -r ~/hyprdots/.local/bin/* ~/.local/bin
cp -r ~/hyprdots/.config/* ~/.config
cp ~/hyprdots/.bashrc ~/.bashrc
cp ~/hyprdots/.inputrc ~/.inputrc
