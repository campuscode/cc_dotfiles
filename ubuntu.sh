#!/bin/sh
sudo apt-get update
sudo apt-get install -y python-software-properties software-properties-common
sudo add-apt-repository -y ppa:pi-rho/dev

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt-get update
sudo apt-get install -y silversearcher-ag \
 zsh \
 tmux \
 dconf-cli \
 vim-gnome
git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git
~/.cc_dotfiles/gnome-terminal-colors-solarized/install.sh
sudo apt-get purge ruby

echo '===========Installing Google Chrome==========='
sudo apt install google-chrome-stable
echo '=========== Installing Spotify ==========='
sudo apt install spotify-client
echo 'Installing Rambox'
wget "https://getrambox.herokuapp.com/download/linux_64?filetype=deb" -O rambox.deb
wget $(curl -s https://api.github.com/repos/ramboxapp/community-edition/releases | grep browser_download_url | grep '64[.]deb' | head -n 1 | cut -d '"' -f 4) -O rambox.deb
sudo dpkg -i rambox.deb
sudo apt-get install -f
sudo rm -f rambox.deb
echo 'Changing terminal colors'
bash ./ubuntu/gnome-terminal-profile import ./ubuntu/profile_colors

echo 'Change your terminal window to Run command as login shell and restart'
echo 'You can find more information about this on' \
     'https://github.com/rvm/ubuntu_rvm'

