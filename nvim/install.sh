#!/usr/bin/env bash

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

arch=$(uname -m)

install_nodejs(){
    if [[ "$arch" == *"darwin"* ]]; then
        vdis="darwin-x64"
    elif [[ "$arch" == "x86_64" ]]; then
        vdis="linux-x64"
    fi

    if [ ! -x "$(command -v node)" ]; then
        # install_version=`curl -H 'Cache-Control: no-cache'  "https://api.github.com/repos/nodejs/node/releases/latest" | grep 'tag_name' | cut -d\" -f4`
        install_version="v16.20.2"
        base_name="node-$install_version-$vdis"
        file_name=$base_name.tar.gz
        curl -L https://nodejs.org/dist/$install_version/$file_name -o $file_name
        tar -xzvf $file_name
        if [[ ! $? -eq 0 ]]; then 
            rm -rf $base_name*
            exit 1
        else 
            cp -rf $base_name/* /usr/local/
        fi
        rm -rf $base_name*

        export PATH="/usr/local/bin/:$PATH"
        npm install -g neovim
    fi
}

install_neovim(){
    if command -v nvim >/dev/null 2>&1; then
        cp -R $HOME/.config/nvim/ $HOME/.config/nvim_backup/
    else
        if [[ "$arch" == *"darwin"* ]]; then
            curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-x86_64.tar.gz
            tar -C /opt -xzf nvim-macos-x86_64.tar.gz
            ln -s /opt/nvim-osx64/bin/nvim /usr/local/bin/nvim
        elif [[ "$arch" == "x86_64" ]]; then
            curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
            tar -C /opt -xzf nvim-linux64.tar.gz
            ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
        else
            exit 1
        fi
    fi

    mkdir -p $HOME/.config/nvim

    if [[ $SHELL == *"bash"* ]]; then
        echo "alias vim='nvim'" >> ~/.bashrc
        echo "alias vi='nvim'" >> ~/.bashrc
        echo "Please run 'source ~/.bashrc' to apply the alias changes."
    elif [[ $SHELL == *"zsh"* ]]; then
        echo "alias vim='nvim'" >> ~/.zshrc
        echo "alias vi='nvim'" >> ~/.zshrc
        echo "Please run 'source ~/.zshrc' to apply the alias changes."
    elif [[ $SHELL == *"fish"* ]]; then
        echo "alias vim='nvim'" >> ~/.config/fish/config.fish
        echo "alias vi='nvim'" >> ~/.config/fish/config.fish
        echo "Please run 'source ~/.config/fish/config.fish' to apply the alias changes."
    else
        echo "Unsupported shell. Please add the aliases manually."
        exit 1
    fi

    # python
    # TODO
    # pip install pynvim neovim jedi-language-server

    echo '[flake8]\nmax-line-length = 120' > $HOME/.config/flake8
    cp -R ./* $HOME/.config/nvim
    nvim +Lazy +UpdateRemotePlugins +qall

    # Install coc
    cd $HOME/.local/share/nvim/lazy/coc.nvim
    npm install
    if [ -d "$HOME/.config/coc/extensions" ]; then
        cd $HOME/.config/coc/extensions
        npm install coc-jedi coc-json coc-git coc-docker coc-tabnine coc-imselect
    fi
    nvim +CocInstall
}

if [[ "$arch" == *"darwin"* ]]; then
    brew install ripgrep fd git
else

    if command -v apt-get &> /dev/null; then
        apt update && apt upgrade
        apt install -y curl ripgrep clang
    elif command -v yum &> /dev/null; then
        # install rg
        yum install -y yum-utils git gcc
        yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
        yum install -y ripgrep

        # install git 2.36
        if command -v git &> /dev/null; then
            yum remove -y git
        fi
        yum install -y https://repo.ius.io/ius-release-el7.rpm https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
        yum install -y git236
    else
        echo "Neither apt-get, yum nor dnf found. Please install ripgrep and fd-find manually."
    fi

    # 安装fd
    if [ ! -x "$(command -v fd)" ]; then
        curl -LO https://github.com/sharkdp/fd/releases/download/v7.4.0/fd-v7.4.0-x86_64-unknown-linux-musl.tar.gz
        tar -C /opt -zxvf fd-v7.4.0-x86_64-unknown-linux-musl.tar.gz
        cp /opt/fd-v7.4.0-x86_64-unknown-linux-musl/fd /usr/local/bin/
        if [ -d "/usr/local/share/man/man1" ]; then
            cp /opt/fd-v7.4.0-x86_64-unknown-linux-musl/fd.1 /usr/local/share/man/man1/
        fi
        rm -rf fd-v7.4.0-x86_64-unknown-linux-musl.tar.gz
    fi
fi

install_nodejs
install_neovim
