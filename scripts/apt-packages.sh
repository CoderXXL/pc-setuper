#!/usr/bin/env bash

PACKAGES=(htop openssh python pip zsh curl wget git sl vim terminator jp apt-transport-https ca-certificates software-properties-common)

apt update
apt upgarde -y

for package in "${PACKAGES[@]}"
do :
   apt install "$package" -y
done
