#!/bin/bash
# set dotfile path and home path

# set HOME and DOTFILE_PATH
export DOTFILE_PATH=${HOME}/dotfiles
case "$(hostname)" in
	# dev1 machine
    xjydev1.corp.qihoo.net )
        echo "dev1"
        export DOTFILE_PATH=${HOME}/dotfiles
        ;;
    # dev2 machine
    dev15.se.corp.qihoo.net )
        echo "dev2"
        export HOME=/da1/zhangkang-pd
        export DOTFILE_PATH=${HOME}/dotfiles
        ;;
	# pc
    zhangkang-pd-D4 )
        echo "pc"
    	export DOTFILE_PATH=/cygdrive/e/Cloud/dotfiles
        ;;
	# gpu1-4
	gpu[1-4].imgse.bjdt.qihoo.net )
        echo "gpu"
        export DOTFILE_PATH=${HOME}/dotfiles
		;;
	# virtual machine
	face01v.image.corp.qihoo.net )
        echo "virtual machine"
        export DOTFILE_PATH=${HOME}/dotfiles
		;;	
esac

echo "soft link all config files"

# personal script
if ! [ -h "${HOME}/script" -o -d "${HOME}/script" ]; then
    ln -s ${DOTFILE_PATH}/script ${HOME}/script
fi
echo "soft link personal script"

# bash
if [ -h "${HOME}/.bashrc" -o -e "${HOME}/.bashrc" ]; then
    rm ${HOME}/.bashrc
fi
ln -s ${DOTFILE_PATH}/bash/bashrc ${HOME}/.bashrc
if [ -h "${HOME}/.bash_profile" -o -e "${HOME}/.bash_profile" ]; then
    rm ${HOME}/.bash_profile
fi
ln -s ${DOTFILE_PATH}/bash/bash_profile ${HOME}/.bash_profile
echo "soft link bash"

# zsh
#if [ -h "${HOME}/.zshrc" ]; then
#    rm ${HOME}/.zshrc
#fi
#if [ -d "${HOME}/.oh-my-zsh" ]; then
#    rm -rf ${HOME}/.oh-my-zsh
#fi
#ln -s ${DOTFILE_PATH}/zsh/templates/zshrc.zsh-template ${HOME}/.zshrc
#ln -s ${DOTFILE_PATH}/zsh/ ${HOME}/.oh-my-zsh 

# tmux
if [ -h "${HOME}/.tmux.conf" -o -e "${HOME}/.tmux.conf" ]; then
    rm ${HOME}/.tmux.conf
fi
ln -s ${DOTFILE_PATH}/tmux/tmux.conf ${HOME}/.tmux.conf
echo "soft link tmux"

# vim
if [ -d "${HOME}/.vim" -o -h "${HOME}/.vim" ]; then
    echo "${HOME}.vim dir exists"
    # rm -rf ${HOME}/.vim
else
    mkdir ${HOME}/.vim
fi
if [ -h "${HOME}/.vimrc" -o -e "${HOME}/.vimrc" ]; then
    rm ${HOME}/.vimrc
fi
ln -s ${DOTFILE_PATH}/vim/vimrc.vim ${HOME}/.vimrc
ln -s ${DOTFILE_PATH}/vim/vimfiles/ftplugin ${HOME}/.vim/ftplugin
ln -s ${DOTFILE_PATH}/vim/vimfiles/snippets ${HOME}/.vim/snippets 
echo "soft link vim"
# install Vundle for vim
if [ ! -d "${HOME}/.vim/bundle/Vundle.vim" ]; then 
    echo "install Vundle for vim"
    git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
fi

source ${HOME}/.bashrc

echo "done"
