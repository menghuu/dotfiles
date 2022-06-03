.DEFAULT_GOAL := all

.PHONY: all clean install

all: clean install
install:
	mkdir -p ~/.local/share/nvim_vim/swap
	mkdir -p ~/.local/share/nvim_vim/backup
	mkdir -p ~/.local/share/nvim_vim/undo
	mkdir -p ~/.local/share/nvim_vim/shada
	mkdir -p ~/.local/shada/nvim_vim/bookmarks
	curl -fLo autoload/plug.vim --create-dirs \
    	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	\vim +PlugClean +qall
	\vim +PlugUpdate! +qall
	nvim +PackerSync
	\vim +CocUpdate
	pip install pynvim neovim-remote
	chmod u+x plugged/vim-gutentags/plat/unix/*.sh
clean:
	rm autoload/plug.vim
	rm -fr ~/.local/share/nvim/site/pack/packer
	rm -f ./plugin/packer_compiled.lua
	rm -f ./autoload/plug.vim
	rm -fr ./plugged
	rm -f ~/.cache/nvim/luacache_chunks
	rm -fr ~/.config/coc
