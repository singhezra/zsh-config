
PULL := git subtree pull --prefix

PLUGINS  $(realpath ./plugins)

.PHONY: install update

install:
	apt install zsh
	exec $(PLUGINS)/.oh-my-zsh/tools/install.sh

update:
	@echo "Updating plugins..."
	$(PULL) plugins/.oh-my-zsh git@github.com:ohmyzsh/ohmyzsh.git master --squash
	$(PULL) plugins/zsh-syntax-highlighting git@github.com:zsh-users/zsh-syntax-highlighting.git master --squash
	$(PULL) plugins/zsh-autosuggestions git@github.com:zsh-users/zsh-autosuggestions.git master --squash
	@echo "Updating themes..."
	$(PULL) themes/powerlevel10k git@github.com/romkatv/powerlevel10k.git master --squash

