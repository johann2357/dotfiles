# Setup from scratch

## Install neovim
`brew install neovim`

## Copy init.vim
`ln -s $PWD/init.vim $HOME/.config/nvim/init.vim`

## Install vim-plug
`curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`

## Install python requirements
`pip install -r requirements.txt`

## Open and Install pluggins
`nvim`
`:PlugInstall`
