#!/bin/sh

# Install X configs
echo "===> Bootstarp .Xresources ..."
echo "\t---> Create a symlink to .Xresource.d"
ln -s $PWD/xresources.d/ $HOME/.Xresources.d

echo "\t---> Create a symlink to .Xresource"
ln -s $PWD/xresources.d/xresources $HOME/.Xresources

echo "\t---> Create a symlink to .xinitrc"
ln -s $PWD/xresources.d/xinitrc $HOME/.xinitrc

ech "\t---> Merge 'xrdb'"
xrdb -merge -I$HOME ~/.Xresources
echo "===> Done bootstrap .Xresources"
# End X configs

# Install fonts
echo "===> Install patched fonts"
sh $PWD/fonts/install.sh
echo "===> Installed patched fonts"
echo "\t Done!\n"
# End install fonts

# Oh My ZSH
echo "---> installing oh-my-zsh"
sudo dnf install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "---> Changing default shell"
chsh -s /bin/zsh
echo "[WARN] You need restart you terminal"

echo "---> Installing custom theme PowerLevel9K"
git clone https://github.com/bhilburn/powerlevel9k.git $HOME/.oh-my-zsh/custom/themes/powerlevel9k

# Copy zshrc
echo "---> coping zshrc"
ln -s $PWD/zhs/zshrc $HOME/.zshrc

# Install Antigen ZSH plugin manager
echo "===> Installing zsh plugin manager Antigen"
echo "---> Clone from oficial repo to $HOME/antigen"
#git clone https://github.com/zsh-users/antigen.git $HOME/.antigen
#yaourt -S antigen-git
mkdir -p $HOME/.zsh
curl -L git.io/antigen > $HOME/.zsh/antigen.zsh
echo "# Import antigen ZSH Plugin Manager" >> $HOME/.zshrc
echo "source $HOME/.zsh/antigen.zsh" >> $HOME/.zshrc
echo "You have several alternative methods to install Antigen as well.

Using Debian package:

  apt-get install zsh-antigen

On Archlinux you may use antigen-git package:

  yaourt -S antigen-git

On OSX you may use Homebrew:

  brew install antigen"

source $HOME/.zshrc

echo "---> Install zsh-syntax-highlighting"
# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting
# Install python packages

echo "---> [FIXME}: Install Python development tools"
# sudo apt-get install -y python3-dev python3-pip

echo "---> Install Pyhton PIP packages"
pip3 install --upgrade pip
pip3 install --user ipython
pip3 install --user git+git://github.com/Lokaltog/powerline
pip3 install --user powerline-status
pip3 install --user jupyter
echo "\t Done!\n"

# Install tmux files
echo "[TMUX ROLE]"

echo "---> Install tmux"
sudo dnf install -y tmux
echo "---> Create a symlink to tmux.conf"
ln -s $PWD/tmux/tmux.conf $HOME/.tmux.conf
echo "\t Done!\n"

# Install vim

echo "---> [FIXME] Install vim editor"
# sudo apt-get install -y ncurses-term exuberant-ctags vim vim-gnome python-dev tmux
sudo dnf -y vim vim-gnome ctags
echo "\t Done!\n"

echo "---> Config vim"
ln -s $PWD/vim $HOME/.vim
echo "\t Done!\n"


echo "[FIXME] NUMIX THEME"
echo "---> Adding numix ppa to source list ..."
# sudo add-apt-repository ppa:numix/ppa
# sudo apt-get update
echo "\t[OK]"

echo "---> [FIXME] Installing numix..."
# sudo apt-get install -y numix-gtk-theme numix-icon-theme-circle numix-* unity-tweak-tool
echo "\t [OK]"
echo "\t [Done]"

echo '---> Installing fzf: um fuzzy finder (buscador de arquivos) direto no terminal!! (y for all)'
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

echo 'Pronto, agora você poderá usar Ctrl+T quando precisar procurar por arquivos, que nem você faria no seu editor ;-)'
echo 'Viste https://github.com/junegunn/fzf para mais informações'


echo "ASDF-VM (experimental)"
source asdf-vm/install.sh
