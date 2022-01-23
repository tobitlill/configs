#!/usr/bin/bash

cd /tmp

if [ ! -f /usr/bin/zsh ]; then
	echo "install zsh"
	sudo apt install zsh
else
	echo "zsh is already installed"
fi

# clone my configs
if [ ! -d /tmp/configs ]; then
	echo "Download own configs"
  git clone https://github.com/tobitlill/configs
else
  echo "already pulled configs"
fi

cd ~
# get oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
	echo "Download oh my zsh"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "already downloaded oh my zsh"
fi

# copy relevant files from my configs over
cp /tmp/configs/.zshrc ~
cp /tmp/configs/.p10k.zsh ~
cp -r /tmp/configs/i3 ~/.config

# install zsh-autosuggestions
if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
	echo "Download zsh autosuggestions plugin"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
	echo "already downloaded autosuggestions plugin"
fi

# install zsh-syntax-highlighting
if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]; then
	echo "Download zsh-syntax-highlighting plugin"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
	echo "already downloaded zsh-syntax-highlighting plugin"
fi

# install powerlevel10k theme
if [ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]; then
	echo "Downloading powerlevel10k theme"
	git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
	echo "already downloaded powerlevel10k theme"
fi

# change to zsh
if [ ! $SHELL == "/usr/bin/zsh" ]; then
	echo "setting zsh as default shell"
	chsh -s $(which zsh)
else
	echo "zsh is already the default shell"
fi

echo "You may want to install fonts from here: https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k"

echo "Setting up fstab for shared folder"
sudo su -c "echo '# shared folder' >> /etc/fstab"
sudo su -c "echo '.host:/share    /mnt/share  fuse.vmhgfs-fuse    defaults,allow_other,uid=1000   0   0' >> /etc/fstab"
