#!/usr/bin/bash

cd /tmp

# clone my configs
git clone https://github.com/tobitlill/configs

cd ~
# get oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# copy relevant files from my configs over
cp /tmp/configs/.zshrc ~
cp /tmp/configs/.p10k.zsh ~
cp -r /tmp/configs/i3 ~/.config

# install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install powerlevel10k theme
git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

