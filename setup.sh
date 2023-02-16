#!/usr/bin/env sh
# debug output and exit on error or use of undeclared variable or pipe error:
set -o xtrace -o errtrace -o errexit -o nounset -o pipefail

cd $HOME
sudo apt update && sudo apt upgrade
sudo apt install zsh neovim zoxide fzf

git clone --recurse-submodules -j8 git://github.com/M7mdisk/.config/

sudo chsh -s /usr/bin/zsh

# Configure git and install lazygit
git config --global user.email "M7md.k.isk@gmail.com"
git config --global user.name "Mohammad Iskandarani"

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz lazygit


# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

mkdir -p "~/.local/bin"
version="$(curl --location --head https://github.com/gokcehan/lf/releases/latest | grep -i location: | sed 's/^.*\/tag\/\([^\/]*\)\r$/\1/')"
filename="lf-linux-amd64.tar.gz"
uri_to_download="https://github.com/gokcehan/lf/releases/download/${version}/${filename}"

curl --fail --show-error --location "$uri_to_download" |
  tar -xz -C /tmp/
mv --force /tmp/lf "${HOME}/.local/bin/lf" && 
  chmod a+x "${HOME}/.local/bin/lf"


if [ ! -x "${HOME}/.local/bin/lf" ]; then
    echo '"lf" was not successfully installed!' >&2
    # DISPLAY=:0 notify-send --urgency=critical "Failed updating lf!
      # Run $0 to check."
    exit 2
fi
