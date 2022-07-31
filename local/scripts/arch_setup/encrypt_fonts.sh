#!/bin/sh

pushd ~/.fonts > /dev/null;
zip -r -j /tmp/fonts.zip ~/.fonts/
gpg --output ~/.dotfiles/fonts.gpg -c /tmp/fonts.zip
popd >/dev/null;
#rm /tmp/fonts.zip;
