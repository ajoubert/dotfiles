#!/bin/sh

zip -r /tmp/fonts.zip ~/.fonts/
gpg --output ~/.dotfiles/fonts.gpg -c /tmp/fonts.zip
rm /tmp/fonts.zip;
