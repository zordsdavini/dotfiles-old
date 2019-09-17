# Zordsdavini dotfiles

Place to save configs and use with fork of [LARBS](https://github.com/LukeSmithxyz/LARBS) to restore my environment

To get Qtile and related stuff around in place, run `sudo larbs.sh -r https://github.com/zordsdavini/dotfiles.git -p https://raw.githubusercontent.com/zordsdavini/dotfiles/master/progs.csv`. Later remove `.git` and other trash files from home.

Additionally it has two scripts:

  - `collect.sh` - to sync all configs in `list` from the system and commit to github
  - `spread.sh` - to sync all configs in `list` from github repo clone to the system

TODO:

  - script to remove trash files from `$HOME`
  - collect programs to progs.csv. Use `pip list`, `pacman -Qqetn >> progs.csv`, `pacman -Qqemt`
  - move to Makefile
