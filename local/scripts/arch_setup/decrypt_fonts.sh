#!/bin/sh

gpg --output /tmp/fonts.zip -d ~/.dotfiles/fonts.gpg
unzip /tmp/fonts.zip -d ~/.fonts
