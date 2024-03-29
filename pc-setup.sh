#!/bin/bash

### default install software
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install git -y
sudo apt-get install wget -y
sudo apt-get install php -y
sudo apt-get install python3-pip -y
sudo apt-get install curl -y
sudo apt-get install python3 python3-venv python3-pip -y
sudo apt-get install terminator -y
sudo apt-get install lolcat -y
sudo apt-get install sl -y
sudo apt-get install zsh -y
sudo apt-get install pulseaudio-equalizer -y
sudo apt-get install chrome-gnome-shell -y
sudo apt-get install vim -y

## snap stuff
sudo snap install --classic code
sudo snap install slack --classic
sudo snap install teams-for-linux
sudo snap install discord

### install chrome
cd /tmp
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
cd $HOME


### add oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


## add autosuggestions
read -p "Do you want to add zsh autosuggestions? (Y/n): " want_autosuggestions
if [ "$want_autosuggestions" != "n" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions)/g' ~/.zshrc
fi

## add syntax highlighting
read -p "Do you want to add zsh syntax highlighting? (Y/n): " want_syntax_highlighting
if [ "$want_syntax_highlighting" != "n" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  sed -i 's/plugins=(git zsh-autosuggestions)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/g' ~/.zshrc
fi


### install nodejs 14.x & yarn
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash - 

sudo apt-get install nodejs -y
sudo apt-get install yarn -y
sudo apt install build-essential -y


### install jetbrains toolbox
# required for 22.04 lts
sudo apt-get install libfuse2 -y

# Prerequisites jetbrains toolbox
cd /tmp
wget -cO jetbrains-toolbox.tar.gz "https://data.services.jetbrains.com/products/download?platform=linux&code=TBA"
tar -xzf jetbrains-toolbox.tar.gz
DIR=$(find . -maxdepth 1 -type d -name jetbrains-toolbox-\* -print | head -n1)
cd $DIR
./jetbrains-toolbox
cd $HOME

echo "Done, exit the script"
sleep(1)
echo "."
sleep(1)
echo "."
sleep(1)
echo "."
