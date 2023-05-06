#!/bin/bash

pushd /tmp > /dev/null;

sudo pacman -S --noconfirm --needed \
  alacritty \
  base-devel \
  discord \
  firefox-developer-edition \
  git \
  keepassxc \
  lxappearance-gtk3 \
  obsidian \
  neovim \
  signal-desktop \
  tmux \
  picom \
  pavucontrol \
  pulseaudio \
  pulseaudio-alsa \
  pulseaudio-bluetooth \
  pulseaudio-jack \
  python-pynvim \
  rofi \
  rofi-pass \
  ripgrep \
  unzip \
  xorg \
  xorg-xinit \
  yarn \
  ;

git clone https://aur.archlinux.org/yay.git

pushd /tmp/yay > /dev/null;

makepkg -si --noconfirm;

popd > /dev/null;

sudo rm -Rf yay;

yay -S --noconfirm \
  awesome-git \
  rcm \
  shantz-xwinwrap-bzr \
  ;

popd > /dev/null;

pushd ~/.dotfiles > /dev/null;
git submodule init;
git submodule update;
rcup;

popd > /dev/null;
