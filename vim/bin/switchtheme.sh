#!/bin/bash


if [ "$1" == "light" ]
then
  rm $VIM_CONFIG/config.vim;
  cat $VIM_CONFIG/config.light.theme >> $VIM_CONFIG/config.vim;
  cat $VIM_CONFIG/config.general >> $VIM_CONFIG/config.vim;
elif [ "$1" == "dark" ]
then
  rm $VIM_CONFIG/config.vim;
  cat $VIM_CONFIG/config.dark.theme >> $VIM_CONFIG/config.vim;
  cat $VIM_CONFIG/config.general >> $VIM_CONFIG/config.vim;
else
  echo "Unknown theme...";
fi

