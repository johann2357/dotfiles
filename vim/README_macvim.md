# Setup from scratch

## Install vim-plug
`curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`

## Link .gvimrc
`ln -s $PWD/init.vim $HOME/.vimrc`
`ln -s $PWD/after $HOME/.vim/after`

## Open and Install pluggins
`mvim`
`:PlugInstall`

