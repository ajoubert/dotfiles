#!/bin/bash


if [ "$1" == "light" ]
then
  rm $VIM_CONFIG/config/config.vim;
  cat $VIM_CONFIG/config/config.light.theme >> $VIM_CONFIG/config/config.vim;
  cat $VIM_CONFIG/config/config.general >> $VIM_CONFIG/config/config.vim;
elif [ "$1" == "dark" ]
then
  rm $VIM_CONFIG/config/config.vim;
  cat $VIM_CONFIG/config/config.dark.theme >> $VIM_CONFIG/config/config.vim;
  cat $VIM_CONFIG/config/config.general >> $VIM_CONFIG/config/config.vim;
else
  echo "Unknown theme...";
fi

