
PULL := git subtree pull --prefix

PLUGINS := $(realpath ./plugins)
THEMES := $(realpath ./themes)

.PHONY: install update

install:
	apt install zsh
	exec $(PLUGINS)/.oh-my-zsh/tools/install.sh

update:
	@echo "Updating plugins..."
	$(PULL) $(PLUGINS)/.oh-my-zsh git@github.com:ohmyzsh/ohmyzsh.git master --squash
	$(PULL) $(PLUGINS)/zsh-syntax-highlighting git@github.com:zsh-users/zsh-syntax-highlighting.git master --squash
	$(PULL) $(PLUGINS)/zsh-autosuggestions git@github.com:zsh-users/zsh-autosuggestions.git master --squash
	@echo "Updating themes..."
	$(PULL) $(THEMES)/powerlevel10k git@github.com/romkatv/powerlevel10k.git master --squash

