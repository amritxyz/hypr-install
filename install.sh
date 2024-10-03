# Disable Wifi-Power Saver
read -n1 -rep 'Would you like to disable wifi powersave? (y,n)' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" ]]; then
    LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
    echo -e "The following has been added to $LOC.\n"
    echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC
    echo -e "\n"
    echo -e "Restarting NetworkManager service...\n"
    sudo systemctl restart NetworkManager
    sleep 5
fi

### Install all of the imp pacakges ####
# read -n1 -rep 'Would you like to install the packages? (y,n)' INST
# if [[ $INST == "Y" || $INST == "y" ]]; then
    sudo pacman -Sy --needed base-devel && \
    sudo pacman -S hyprland brightnessctl hyprpaper foot imv lf \
    mpv neovim ttf-hack ttf-hack-nerd waybar bleachbit fastfetch \
    unzip hyprlock newsboat mupdf noto-fonts-emoji wtype wofi \
    bluez bluez-utils htop grim slurp vulkan-intel zed \
    xdg-desktop-portal-gtk xdg-desktop-portal-lxqt
# xf86-video-intel

# fi

# Remove Bloat
# sudo pacman -Rncsu vim dolphin nano dunst kitty ly
# sudo pacman -Scc && sudo pacman -Sy

# MKdir
mkdir -p ~/.local/share ~/.config ~/.local/bin ~/.local/git-repos ~/.local/hugo-dir

# Post Installation
git clone --depth=1 https://github.com/nyx-void/hyprdots.git ~/hyprdots
git clone --depth=1 https://github.com/nyx-void/wall.git ~/.local/share/wall
# git clone --depth=1 https://github.com/nyx-void/dev.git ~/.local/dev

# Managing Dotfiles
cp -r ~/hyprdots/.local/share/* ~/.local/share
cp -r ~/hyprdots/.local/bin/* ~/.local/bin
cp -r ~/hyprdots/.config/* ~/.config
cp ~/hyprdots/.bashrc ~/.bashrc
cp ~/hyprdots/.inputrc ~/.inputrc

# Cleaning Home Dir
mv ~/hypr-install ~/.local/git-repos
mv ~/hyprdots ~/.local/git-repos

# Start the bluetooth service
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
cat << "EOF"
########################################

Installation Completed Successfully

########################################
EOF

# End of script
