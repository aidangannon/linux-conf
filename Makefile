DOTFILES_DIR := $(shell pwd)
FOLDERS := bash git tmux nvim

.PHONY: install
install: uninstall
	@for folder in $(FOLDERS); do \
		find $(DOTFILES_DIR)/$${folder} -maxdepth 1 -mindepth 1 | while read item; do \
			echo "ln -sf $${item} $$HOME/"; \
			ln -sf $${item} $$HOME/; \
		done; \
	done

.PHONY: uninstall
uninstall:
	@for folder in $(FOLDERS); do \
		find $(DOTFILES_DIR)/$${folder} -maxdepth 1 -mindepth 1 | while read item; do \
			echo "rm -rf $$HOME/$$(basename $${item})"; \
			rm -rf $$HOME/$$(basename $${item}); \
		done; \
	done
