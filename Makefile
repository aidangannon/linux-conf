DOTFILES_DIR := $(shell pwd)

.PHONY: install
install: uninstall
	ln -sf $(DOTFILES_DIR)/bash/.bashrc $$HOME/.bashrc
	ln -sf $(DOTFILES_DIR)/git/.gitconfig $$HOME/.gitconfig
	ln -sf $(DOTFILES_DIR)/tmux/.tmux.conf $$HOME/.tmux.conf
	ln -sf $(DOTFILES_DIR)/nvim/.config $$HOME/.config

.PHONY: uninstall
uninstall:
	rm -f $$HOME/.bashrc
	rm -f $$HOME/.gitconfig
	rm -f $$HOME/.tmux.conf
	rm -f $$HOME/.config
