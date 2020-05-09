#/bin/bash

if ! [ -x "$(command -v git)" ];
then
  echo "Seems like git isn't installed on that system, please install it first"
  exit 1
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
TARGET="$DIR/../3rdparty/bash-preexec"

git clone https://github.com/rcaloras/bash-preexec.git $TARGET
