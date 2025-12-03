.PHONY: install
install: uninstall
	ln -sf $(PWD)/bash/.bashrc $(HOME)/.bashrc
	ln -sf $(PWD)/git/.gitconfig $(HOME)/.gitconfig
	ln -sf $(PWD)/tmux/.tmux.conf $(HOME)/.tmux.conf
	ln -sf $(PWD)/nvim $(HOME)/.config/nvim

.PHONY: uninstall
uninstall:
	rm -rf $(HOME)/.bashrc
	rm -rf $(HOME)/.gitconfig
	rm -rf $(HOME)/.tmux.conf
	rm -rf $(HOME)/.config/nvim

