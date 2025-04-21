#!/bin/bash

# Cleanup first
read -rep ':: Would you like to cleanup Home Dir? [y/N] ' DLT
if [[ $DLT == "N" || $DLT == "n" || -z $DLT ]]; then
	echo "Exiting..."
	break
else
	echo "Cleaning..."
	sudo rm -rf $HOME/.[!.]*
fi

# Disable Wifi-Power Saver
read -rep ':: Would you like to disable wifi powersave? [Y/n] ' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" || -z $WIFI ]]; then
	LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
	echo -e "The following has been added to $LOC.\n"
	echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC
	echo -e "\n"
	echo -e "Restarting NetworkManager service...\n"
	sudo systemctl restart NetworkManager
	sleep 5
fi

# Enable Multi-Lib Packages
read -rep ':: Would you like to enable "Multilib Packages" [Y/n] ' MULLIB
if [[ $MULLIB == "Y" || $MULLIB == "y" || -z $MULLIB ]]; then
	sudo cp /etc/pacman.conf /etc/pacman.conf.backup
	mline=$(grep -n "\\[multilib\\]" /etc/pacman.conf | cut -d: -f1)
	rline=$(($mline + 1))
	sudo sed -i ''$mline's|#\[multilib\]|\[multilib\]|g' /etc/pacman.conf
	sudo sed -i ''$rline's|#Include = /etc/pacman.d/mirrorlist|Include = /etc/pacman.d/mirrorlist|g' /etc/pacman.conf
fi

### Install all of the imp pacakges ####
read -rep ':: Would you like to install the packages? [Y/n] ' INST
if [[ $INST == "Y" || $INST == "y" || -z $INST ]]; then
	sudo pacman -Sy --needed base-devel && \
		sudo pacman -S --needed tesseract-data-nep hyprland brightnessctl hyprpaper foot imv lf \
		mpv neovim ttf-hack ttf-hack-nerd waybar bleachbit fastfetch unzip hyprlock ripgrep \
		newsboat noto-fonts-emoji wtype wofi htop grim slurp man-db zathura zathura-pdf-poppler \
		vulkan-intel xdg-desktop-portal-gtk adwaita-icon-theme git-lfs wf-recorder gimp imagemagick \
		gnu-free-fonts wget deluge-gtk fzf curl cmatrix gnu-netcat wl-clipboard bluez bluez-utils pulsemixer \
		rust go jdk-openjdk tmux php nodejs npm
fi
# xf86-video-intel xdg-desktop-portal-lxqt zed gimp
# Remove Bloat
# sudo pacman -Rncsu vim dolphin nano dunst kitty ly
# sudo pacman -Scc && sudo pacman -Sy

# MKdir
mkdir -p ~/.local/share ~/.config ~/.local/bin ~/.local/git-repos ~/.local/hugo-dir ~/.local/dox ~/.local/vids ~/.local/music ~/.local/audio

# Post Installation
git clone --depth=1 https://github.com/amritxyz/hyprdots.git/ ~/hyprdots
git clone --depth=1 https://github.com/amritxyz/wall.git/ ~/.local/share/wall
git clone --depth=1 https://github.com/amritxyz/dev.git/ ~/.local/dev
git clone --depth=1 https://github.com/amritxyz/kickstart-nvim.git ~/.config/nvim

# Managing Dotfiles
cp -r ~/hyprdots/.local/share/* ~/.local/share
cp -r ~/hyprdots/.local/bin/* ~/.local/bin
cp -r ~/hyprdots/.config/* ~/.config
cp ~/hyprdots/.bashrc ~/.bashrc
cp ~/hyprdots/.bash_profile ~/.bash_profile
cp ~/hyprdots/.inputrc ~/.inputrc

# Cleaning Home Dir
mv ~/hypr-install ~/.local/git-repos
mv ~/hyprdots ~/.local/git-repos

# Start the bluetooth service
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

# Just a empty directory for working stuffs
sudo mkdir -p /opt/void
sudo chown $USER:$USER /opt/void/

cat << "EOF"
########################################
Installation Completed Successfully
########################################
EOF

# End of script
