# Installation
sudo pacman -Sy && sudo pacman -S brightnessctl hyprpaper imv lf mpv neovim ttf-hack ttf-hack-nerd waybar bleachbit fastfetch unzip hyprlock newsboat mupdf

# Remove Bloat
sudo pacman -Rncsu vim dolphin nano dunst kitty ly
sudo pacman -Scc && sudo pacman -Sy

# MKdir
mkdir -p ~/.local/share ~/.config

# Post Installation
git clone --depth=1 https://gitlab.com/amrit-44404/hyprdots.git ~/hyprdots
git clone --depth=1 https://gitlab.com/amrit-44404/wall.git ~/.local/share/wall

# Managing Dotfiles
cp -r ~/hyprdots/.local/share/* ~/.local/share
cp -r ~/hyprdots/.config/* ~/.config
cp ~/hyprdots/.bashrc ~/.bashrc
