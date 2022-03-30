
PULL := git subtree pull --prefix

PLUGINS := $(realpath ./plugins)

.PHONY: install update clean

install:
	exec $(PLUGINS)/.oh-my-zsh/tools/install.sh
	mv ${HOME}/.zshrc ${HOME}/.zshrc.bak
	cp .zshrc ${HOME}

update:
	@echo "Updating plugins..."
	$(PULL) plugins/.oh-my-zsh git@github.com:ohmyzsh/ohmyzsh.git master --squash
	$(PULL) plugins/zsh-syntax-highlighting git@github.com:zsh-users/zsh-syntax-highlighting.git master --squash
	$(PULL) plugins/zsh-autosuggestions git@github.com:zsh-users/zsh-autosuggestions.git master --squash
	@echo "Updating themes..."
	$(PULL) themes/powerlevel10k git@github.com/romkatv/powerlevel10k.git master --squash

clean:
	rm -rf aws awscliv2.zip get-docker.sh *.tar.gz