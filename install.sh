# Disable Wifi-Power Saver
read -n1 -rep 'Would you like to disable wifi powersave? (y,n)' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" ]]; then
    LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
    echo -e "The following has been added to $LOC.\n"
    echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC
    echo -e "\n"
    echo -e "Restarting NetworkManager service...\n"
    sudo systemctl restart NetworkManager
    sleep 3
fi

### Install all of the imp pacakges ####
read -n1 -rep 'Would you like to install the packages? (y,n)' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    sudo pacman -Sy --needed base-devel && \
    sudo pacman -S hyprland brightnessctl hyprpaper foot imv lf \
    mpv neovim ttf-hack ttf-hack-nerd waybar bleachbit fastfetch \
    unzip hyprlock newsboat mupdf noto-fonts-emoji wtype wofi \
    bluez bluez-utils htop grim slurp xf86-video-intel

    # Start the bluetooth service
    echo -e "Starting the Bluetooth Service...\n"
    sudo systemctl enable --now bluetooth.service
    sleep 2
fi

# Remove Bloat
#sudo pacman -Rncsu vim dolphin nano dunst kitty ly
sudo pacman -Scc && sudo pacman -Sy

# MKdir
mkdir -p ~/.local/share ~/.config ~/.local/bin ~/.local/git-repos

# Post Installation
git clone --depth=1 https://gitlab.com/amrit-44404/hyprdots.git ~/hyprdots
git clone --depth=1 https://gitlab.com/amrit-44404/wall.git ~/.local/share/wall
git clone --depth=1 https://gitlab.com/amrit-44404/dev.git ~/.local/dev

# Managing Dotfiles
cp -r ~/hyprdots/.local/share/* ~/.local/share
cp -r ~/hyprdots/.local/bin/* ~/.local/bin
cp -r ~/hyprdots/.config/* ~/.config
cp ~/hyprdots/.bashrc ~/.bashrc
cp ~/hyprdots/.inputrc ~/.inputrc

# Cleaning Home Dir
mv ~/hypr-install ~/.local/git-repos
mv ~/hyprdots ~/.local/git-repos
