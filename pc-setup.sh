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

### install docker Prerequisites
sudo apt-get install ca-certificates -y
sudo apt-get install gnupg -y
sudo apt-get install lsb-release -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y


# post docker installation
/bin/egrep  -i "^docker:" /etc/group
if [ $? -eq 0 ]; then
  sudo usermod -aG docker "$USER"
  newgrp docker
else
  sudo groupadd docker
  sudo usermod -aG docker "$USER"
  newgrp docker
fi


### install docker compose v2.4.1
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.4.1/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose


### install docker-compose Linux Standalone
sudo curl -SL https://github.com/docker/compose/releases/download/v2.4.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo "If the command docker-compose fails after installation, check your path. You can also create a symbolic link to /usr/bin or any other directory in your path."


### install chrome
cd /tmp
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
cd $HOME


### add oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


## add autosuggestions
read -p "Do you want to add zsh autosuggestions? (Y/n)" want_autosuggestions
if [ "$want_autosuggestions" != "n" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions)/g' ~/.zshrc
fi

## add syntax highlighting
read -p "Do you want to add zsh syntax highlighting? (Y/n)" want_syntax_highlighting
if [ "$want_syntax_highlighting" != "n" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  sed -i 's/plugins=(git zsh-autosuggestions)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/g' ~/.zshrc
fi


### install nodejs 14.x & yarn
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get update

sudo apt-get install nodejs -y
sudo apt-get install yarn -y
sudo apt install build-essential -y


### post npm installation
mkdir "${HOME}/.npm-packages"
npm config set prefix "${HOME}/.npm-packages"

# shellcheck disable=SC2016
NPM_ZSHRC_ENVS='
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to "manpath" so we can inherit from "/etc/manpath".
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
'

if ! grep -q NPM_ZSHRC_ENVS "${HOME}/.zshrc"; then
  echo NPM_ZSHRC_ENVS >> $HOME/.zshrc
fi

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
