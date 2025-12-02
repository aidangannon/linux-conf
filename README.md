# stow-conf

Dotfiles symlinked to `~` via Makefile. Bash, nvim, tmux configs.

## Structure
```
bash/
  .bashrc
nvim/
  .config/nvim/...
tmux/
  .tmux.conf
```

## Install
```bash
make          # creates symlinks (runs uninstall first)
make install  # same as above
```

## Uninstall
```bash
make uninstall  # removes all symlinks
```

## How It Works
```makefile
SUBFOLDERS := bash nvim tmux

for item in $$dir/*; do
    ln -sf "$(PWD)/$$item" "$$HOME/$$(basename $$item)";
done
```

## Stack

GNU Make • Bash • Symlinks
