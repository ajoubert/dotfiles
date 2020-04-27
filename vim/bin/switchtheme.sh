#!/bin/bash


if [ "$1" == "light" ]
then
  rm ~/.config/vim/config.vim;
  cat ~/.config/vim/config.light.theme >> ~/.config/vim/config.vim;
  cat ~/.config/vim/config.general >> ~/.config/vim/config.vim;
elif [ "$1" == "dark" ]
then
  rm ~/.config/vim/config.vim;
  cat ~/.config/vim/config.dark.theme >> ~/.config/vim/config.vim;
  cat ~/.config/vim/config.general >> ~/.config/vim/config.vim;
else
  echo "Unknown theme...";
fi

