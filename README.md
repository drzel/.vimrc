# Ruby on Rails & Neovim in Lubuntu Virtual Machine

## VirtualBox
Download and install latest files for your OS from https://www.virtualbox.org/wiki/Downloads

## Lubuntu
* Download latest .iso file from http://lubuntu.net/
* Open VirtualBox
* Click New
	* Name: Lubuntu
	* Type: Linux
	* Version: Other Linux
	* Memory size: At least 2048 MB
	* Create a virtual hard disk now. Allocate atleast 8 GB
* Click Start
* Select the Lubuntu .iso file from the dropdown menu
* Click Start
* Follow the installation prompts. If the installation hangs when attempting to restart click Machine > Reset to continue with the installation

## Update Lubuntu
* Click update if prompted to install updates, or
* Go to System Tools > Software Updater
* Install updates

## Install repositories
```bash
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo add-apt-repository ppa:numix/ppa
```

## Update package lists
```bash
sudo apt-get update
```

## Install programs
```bash
sudo apt-get install build-essential curl git cmake xsel numix-gtk-theme numix-icon-theme numix-icon-theme-circle postgresql postgresql-contrib libpq-dev konsole neovim python-dev python-pip python3-dev python3-pip exuberant-ctags powerline pavucontrol xclip hexchat
```

## Install VirtualBox Guest Additions
From VirtualBox menu select Devices > Insert Guest Additions CD Images, or if you have downloaded a test build Guest Additions, select Devices > Optical Drives > Choose Disk Image... and select the Guest Additions .iso fie
```

## Configure powerline
```
echo -e "
# For powerline
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh
" >> ~/.bashrc
```

## Configure sound
This command will increase the maximum volume to 100%

```
amixer -D pulse sset Master 50%
```

It might also be worthwhile checking levels with

```
alsamixer
```

## Configure theme
Open Menu > Preferences > Customize Look and Feel
* Widget: Numix
* Icon Theme: Numix Circle
* Window Border: Theme > Numix

At this point I recommend closing LXTerminal

## Installing Ruby / Rails
### Configure Konsole for RVM
* Open konsole (press Alt-F2 for the Run dialogue box)
* Click Settings > Edit Current Profile...
* Set General > Command: /bin/bash --login
* Click OK
Note: For installation on other terminals check https://rvm.io/integration for correct settings

### Install RVM
```
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --rails
source /home/drzel/.rvm/scripts/rvm
type rvm | head -1
```
You should see `rvm is /home/username/.rvm/bin/rvm`. If you see 'RVM is not a function' your terminal probably isn't properly configured.

### Configure postgresql
For easiest setup use the same username and password as your Lubuntu user account
```bash
sudo -u postgres createuser -s username
sudo -u postgres psql
```
```
postgres=# \password username
postgres=# \q
```

### Install Node.js
```bash
curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash -
sudo apt-get install -y nodejs
```

### Configure git
```bash
git config --global user.email "your.email@address.com"
git config --global user.name "Your Name"
git config --global core.excludesfile ~/.global_gitignore
```

## Configure neovim
### Make neovim the default editor
```bash
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor
```

### Install powerline-fonts
```bash
git clone https://github.com/powerline/fonts.git ~/temp
~/temp/./install.sh
rm -rf ~/temp
```

### Install vim-plug
```bash
curl -fLo ~/.nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## Install dotfiles
```
git clone https://github.com/svetlyak40wt/dotfiler.git ~/.dotfiles
echo 'export PATH="$PATH:$HOME/.dotfiles/bin"' >> $HOME/.bashrc
source .bashrc
git clone https://github.com/drzel/dotfiles.git ~/.dotfiles/dotfiles
dot update
```

#### Configure FlooBits plugin
```bash
pip install neovim
```

#### Configure YouCompleteMe plugin
```bash
~/.nvim/plugged/.install.sh
```

## Confirm working
```
rails new temp-rails-project
cd temp-rails-project
rails s
```
Then point your browser to `localhost:3000`. If you see the Rails 'Welcome aboard' sit you're good to go. When you're done you can remove the `temp-rails-project` folder.
