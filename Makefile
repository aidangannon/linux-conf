SUBFOLDERS := bash nvim tmux

.PHONY:
install: uninstall
	@for dir in $(SUBFOLDERS); do \
		echo "creating symlinks for $$dir"; \
		for item in $$dir/*; do \
			ln -sf "$(PWD)/$$item" "$$HOME/$$(basename $$item)"; \
		done; \
	done

.PHONY:
uninstall:
	@for dir in $(SUBFOLDERS); do \
		echo "removing symlinks for $$dir"; \
		for item in $$dir/*; do \
			rm -f "$(PWD)/$$item" "$$HOME/$$(basename $$item)"; \
		done; \
	done
