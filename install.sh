#!/usr/bin/env bash

# Install workspace

set -o errexit
set -o pipefail
set -o nounset

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function install_git {
    ln -Sf $DIR/git/.gitconfig ~/.gitconfig
}

function install_tmux {
    if [[ ! -x $(which tmux) ]]; then
        sudo apt-get install tmux
    fi
    ln -Sf $DIR/tmux/.tmux.conf ~/.tmux.conf
}

function install_vim {
    # Link vim config
    ln -Sf $DIR/vim/.vimrc ~/.vimrc
    ln -s $DIR/vim/.vim ~/.vim

    # Install latest vim
    VIMDIR=$HOME/vim
    # check vim is installed and version > 9.0
    VIMVERSION=""
    if [[ -x $(which vim) ]]; then
        VIMVERSION="$(vim --version | head -1 | sed -e 's|^[^0-9]*||' -e 's| .*||')"
    fi
    if [[ -z "$VIMVERSION" || $VIMVERSION < 9.0 ]]; then
        if [[ ! -z "$VIMVERSION" ]]; then
            sudo apt-get remove -y vim
        fi

        # Clone vim repository
        if [[ ! -d $VIMDIR ]]; then
            git clone https://github.com/vim/vim.git $VIMDIR
        fi
        cd $VIMDIR/src
        git pull
        make
        make test
        sudo make install
    fi
}

function install_zsh {
    ln -Sf $DIR/zsh/.zshrc ~/.zshrc
}

function install_neovim {
    ln -Sf $DIR/nvim ~/.config/nvim
    if [[ ! -x $(which nvim) ]]; then
        sudo apt-get install neovim
    fi
}

################################################################################
# Program main function
# Globals:
#   None
# Arguments:
#   None
# Returns
#   None
################################################################################
function main {
    install_git
    install_tmux
    install_vim
    install_zsh
}

main "$@"
