# ajoubert/dotfiles

## About

This repository contains my dotfiles.
It is managed using [rcm](https://github.com/thoughtbot/rcm).

## Installation

This repository is not optimized _at all_ for easy installation for anyone
but my own use-cases (new arch machine). But since my memory is terrible,
I'm writing this down for future me.

If you are me, or want the same system, then run the following commands:

```bash
$ ~/.dotfiles/local/scripts/install_yay.sh;
$ ~/.dotfiles/local/scripts/install_packages.sh;
$ rcup;
```

Once the previous commands have been run, do _not_ forget to also copy the
content of ~/.dotfiles/storage to the appropriate locations as root/sudo.

## Credits

See `CREDITS.md` for a list of credits.
I try to keep track of where I ~~shamelessly copied~~ got my inspiration from.
To my shame, that is something I started doing too late and have lost some
of my earliest sources, I'm sorry. If you recognize your work, please let
me know so I can add you to the list.
